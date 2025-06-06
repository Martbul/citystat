import 'dart:async';
import 'dart:io';

import 'package:citystat/env/cloud_env.dart';
import 'package:citystat/plugins/document/presentation/editor_plugins/desktop_toolbar/desktop_floating_toolbar.dart';
import 'package:citystat/plugins/document/presentation/editor_plugins/desktop_toolbar/link/link_hover_menu.dart';
import 'package:citystat/util/expand_views.dart';
import 'package:citystat/workspace/application/settings/prelude.dart';
import 'package:citystat/packages/citystat_backend/lib/citystat_backend.dart';
import 'package:citystat/packages/citystat_backend/lib/log.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:synchronized/synchronized.dart';

import 'deps_resolver.dart';
import 'entry_point.dart';
import 'launch_configuration.dart';
import 'plugin/plugin.dart';
import 'tasks/af_navigator_observer.dart';
import 'tasks/file_storage_task.dart';
import 'tasks/prelude.dart';

final getIt = GetIt.instance; //This line defines a singleton reference to the GetIt service locator, a dependency injection (DI) library in Dart/Flutter.

abstract class EntryPoint {
  Widget create(LaunchConfiguration config);
}

class CityStatRunnerContext {
  CityStatRunnerContext({required this.applicationDataDirectory});

  final Directory applicationDataDirectory;
}

Future<void> runAppCityStat({bool isAnon = false}) async {
  Log.info('restart CityStat: isAnon: $isAnon');

  if (kReleaseMode) {
    await CityStatRunner.run(
      CityStatApplication(),
      integrationMode(),
      isAnon: isAnon,
    );
  } else {
    // When running the app in integration test mode, we need to
    // specify the mode to run the app again.
    await CityStatRunner.run(
      CityStatApplication(),
      CityStatRunner.currentMode,
      didInitGetItCallback: IntegrationTestHelper.didInitGetItCallback,
      rustEnvsBuilder: IntegrationTestHelper.rustEnvsBuilder,
      isAnon: isAnon,
    );
  }
}

class CityStatRunner {
  // This variable specifies the initial mode of the app when it is launched for the first time.
  // The same mode will be automatically applied in subsequent executions when the runAppFlowy()
  // method is called.
  static var currentMode = integrationMode();



//Static means that run() can be called on the class itself without creating an instance
    // the func returns var of type CityStatRunnerContext
    //Future itself does not indicate that a function is async — rather, it indicates that the function returns a Future object,
    //which means the result will be available at some point in the future, not immediately.
    // This callback is triggered after the initialization of 'getIt',
    // which is used for dependency injection throughout the app.
    // If your functionality depends on 'getIt', ensure to register
    // your callback here to execute any necessary actions post-initialization.
    // Indicate whether the app is running in anonymous mode.
    // Note: when the app is running in anonymous mode, the user no need to
    // sign in, and the app will only save the data in the local storage.
  static Future<CityStatRunnerContext> run(EntryPoint f,IntegrationMode mode, { Future Function()? didInitGetItCallback,Map<String, String> Function()? rustEnvsBuilder,bool isAnon = false,}) async {
    currentMode = mode;

    // Only set the mode when it's not release mode
    if (!kReleaseMode) {
      IntegrationTestHelper.didInitGetItCallback = didInitGetItCallback;
      IntegrationTestHelper.rustEnvsBuilder = rustEnvsBuilder;
    }

    // Disable the log in test mode
    Log.shared.disableLog = mode.isTest;

    // Clear and dispose tasks from previous AppLaunch
    if (getIt.isRegistered(instance: AppLauncher)) {
      await getIt<AppLauncher>().dispose();
    }

    // Clear all the states in case of rebuilding.
    await getIt.reset();

    final config = LaunchConfiguration(
      isAnon: isAnon,
      // Unit test can't use the package_info_plus plugin
      version: mode.isUnitTest
          ? '1.0.0'
          : await PackageInfo.fromPlatform().then((value) => value.version),
      rustEnvs: rustEnvsBuilder?.call() ?? {},
    );

    // Specify the env
    await initGetIt(getIt, mode, f, config);
    await didInitGetItCallback?.call();

    final applicationDataDirectory = await getIt<ApplicationDataStorage>()
        .getPath()
        .then((value) => Directory(value));

    // add task
    final launcher = getIt<AppLauncher>();
    launcher.addTasks([
      // this task should be first task, for handling platform errors.
      // don't catch errors in test mode
      if (!mode.isUnitTest && !mode.isIntegrationTest)
        const PlatformErrorCatcherTask(),
      // this task should be second task, for handling memory leak.
      // there's a flag named _enable in memory_leak_detector.dart. If it's false, the task will be ignored.
      MemoryLeakDetectorTask(),
      DebugTask(),
      const FeatureFlagTask(),

      // localization
      const InitLocalizationTask(),
      // init the app window
      InitAppWindowTask(),
      // Init Rust SDK
      InitRustSDKTask(customApplicationPath: applicationDataDirectory),
      // Load Plugins, like document, grid ...
      const PluginLoadTask(),
      const FileStorageTask(),

      // init the app widget
      // ignore in test mode
      if (!mode.isUnitTest) ...[
        // The DeviceOrApplicationInfoTask should be placed before the AppWidgetTask to fetch the app information.
        // It is unable to get the device information from the test environment.
        const ApplicationInfoTask(),
        // The auto update task should be placed after the ApplicationInfoTask to fetch the latest version.
        if (!mode.isIntegrationTest) AutoUpdateTask(),
        const HotKeyTask(),
        if (isAppFlowyCloudEnabled) InitAppFlowyCloudTask(),
        const InitAppWidgetTask(),
        const InitPlatformServiceTask(),
        const RecentServiceTask(),
      ],
    ]);
    await launcher.launch(); // execute the tasks

    return CityStatRunnerContext(
      applicationDataDirectory: applicationDataDirectory,
    );
  }
}

Future<void> initGetIt(
  GetIt getIt,
  IntegrationMode mode,
  EntryPoint f,
  LaunchConfiguration config,
) async {
  getIt.registerFactory<EntryPoint>(() => f);
  getIt.registerLazySingleton<FlowySDK>(
    () {
      return FlowySDK();
    },
    dispose: (sdk) async {
      await sdk.dispose();
    },
  );
  getIt.registerLazySingleton<AppLauncher>(
    () => AppLauncher(context: LaunchContext(getIt, mode, config)),
    dispose: (launcher) async {
      await launcher.dispose();
    },
  );
  getIt.registerSingleton<PluginSandbox>(PluginSandbox());
  getIt.registerSingleton<ViewExpanderRegistry>(ViewExpanderRegistry());
  getIt.registerSingleton<LinkHoverTriggers>(LinkHoverTriggers());
  getIt.registerSingleton<AFNavigatorObserver>(AFNavigatorObserver());
  getIt.registerSingleton<FloatingToolbarController>(
    FloatingToolbarController(),
  );

  await DependencyResolver.resolve(getIt, mode);
}

class LaunchContext {
  LaunchContext(this.getIt, this.env, this.config);

  GetIt getIt;
  IntegrationMode env;
  LaunchConfiguration config;
}

enum LaunchTaskType { dataProcessing, appLauncher }

/// The interface of an app launch task, which will trigger
/// some nonresident indispensable task in app launching task.
class LaunchTask {
  const LaunchTask();

  LaunchTaskType get type => LaunchTaskType.dataProcessing;

  @mustCallSuper
  Future<void> initialize(LaunchContext context) async {
    Log.info('LaunchTask: $runtimeType initialize');
  }

  @mustCallSuper
  Future<void> dispose() async {
    Log.info('LaunchTask: $runtimeType dispose');
  }
}

class AppLauncher {
  AppLauncher({required this.context});

  final LaunchContext context;
  final List<LaunchTask> tasks = [];
  final lock = Lock();

  void addTask(LaunchTask task) {
    lock.synchronized(() {
      Log.info('AppLauncher: adding task: $task');
      tasks.add(task);
    });
  }

  void addTasks(Iterable<LaunchTask> tasks) {
    lock.synchronized(() {
      Log.info('AppLauncher: adding tasks: ${tasks.map((e) => e.runtimeType)}');
      this.tasks.addAll(tasks);
    });
  }

  Future<void> launch() async {
    await lock.synchronized(() async {
      final startTime = Stopwatch()..start();
      Log.info('AppLauncher: start initializing tasks');

      for (final task in tasks) {
        final startTaskTime = Stopwatch()..start();
        await task.initialize(context);
        final endTaskTime = startTaskTime.elapsed.inMilliseconds;
        Log.info(
          'AppLauncher: task ${task.runtimeType} initialized in $endTaskTime ms',
        );
      }

      final endTime = startTime.elapsed.inMilliseconds;
      Log.info('AppLauncher: tasks initialized in $endTime ms');
    });
  }

  Future<void> dispose() async {
    await lock.synchronized(() async {
      Log.info('AppLauncher: start clearing tasks');

      for (final task in tasks) {
        await task.dispose();
      }

      tasks.clear();

      Log.info('AppLauncher: tasks cleared');
    });
  }
}

enum IntegrationMode {
  develop,
  release,
  unitTest,
  integrationTest;

  // test mode
  bool get isTest => isUnitTest || isIntegrationTest;

  bool get isUnitTest => this == IntegrationMode.unitTest;

  bool get isIntegrationTest => this == IntegrationMode.integrationTest;

  // release mode
  bool get isRelease => this == IntegrationMode.release;

  // develop mode
  bool get isDevelop => this == IntegrationMode.develop;
}

IntegrationMode integrationMode() {
  if (Platform.environment.containsKey('FLUTTER_TEST')) {
    return IntegrationMode.unitTest;
  }

  if (kReleaseMode) {
    return IntegrationMode.release;
  }

  return IntegrationMode.develop;
}

/// Only used for integration test
class IntegrationTestHelper {
  static Future Function()? didInitGetItCallback;
  static Map<String, String> Function()? rustEnvsBuilder;
}
