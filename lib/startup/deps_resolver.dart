import 'package:citystat/ai/service/appflowy_ai_service.dart';
import 'package:citystat/core/config/kv.dart';
import 'package:citystat/core/network_monitor.dart';
import 'package:citystat/env/cloud_env.dart';
import 'package:citystat/mobile/presentation/search/view_ancestor_cache.dart';
import 'package:citystat/plugins/document/application/prelude.dart';
import 'package:citystat/plugins/document/presentation/editor_plugins/copy_and_paste/clipboard_service.dart';
import 'package:citystat/plugins/trash/application/prelude.dart';
import 'package:citystat/shared/appflowy_cache_manager.dart'3;
import 'package:citystat/shared/custom_image_cache_manager.dart';
import 'package:citystat/shared/easy_localiation_service.dart';
import 'package:citystat/startup/startup.dart';
import 'package:citystat/startup/tasks/appflowy_cloud_task.dart';
import 'package:citystat/user/application/auth/af_cloud_auth_service.dart';
import 'package:citystat/user/application/auth/auth_service.dart';
import 'package:citystat/user/application/prelude.dart';
import 'package:citystat/user/application/reminder/reminder_bloc.dart';
import 'package:citystat/user/application/user_listener.dart';
import 'package:citystat/user/presentation/router.dart';
import 'package:citystat/workspace/application/action_navigation/action_navigation_bloc.dart';
import 'package:citystat/workspace/application/edit_panel/edit_panel_bloc.dart';
import 'package:citystat/workspace/application/favorite/favorite_bloc.dart';
import 'package:citystat/workspace/application/recent/cached_recent_service.dart';
import 'package:citystat/workspace/application/settings/appearance/base_appearance.dart';
import 'package:citystat/workspace/application/settings/appearance/desktop_appearance.dart';
import 'package:citystat/workspace/application/settings/appearance/mobile_appearance.dart';
import 'package:citystat/workspace/application/settings/prelude.dart';
import 'package:citystat/workspace/application/sidebar/rename_view/rename_view_bloc.dart';
import 'package:citystat/workspace/application/subscription_success_listenable/subscription_success_listenable.dart';
import 'package:citystat/workspace/application/tabs/tabs_bloc.dart';
import 'package:citystat/workspace/application/user/prelude.dart';
import 'package:citystat/workspace/application/view/prelude.dart';
import 'package:citystat/workspace/application/workspace/prelude.dart';
import 'package:citystat/workspace/presentation/home/menu/menu_shared_state.dart';
import 'package:appflowy_backend/log.dart';
import 'package:appflowy_backend/protobuf/flowy-folder/view.pb.dart';
import 'package:appflowy_backend/protobuf/flowy-user/protobuf.dart';
import 'package:appflowy_popover/appflowy_popover.dart';
import 'package:flowy_infra/file_picker/file_picker_impl.dart';
import 'package:flowy_infra/file_picker/file_picker_service.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:universal_platform/universal_platform.dart';

class DependencyResolver {
  static Future<void> resolve(
    GetIt getIt,
    IntegrationMode mode,
  ) async {
    // getIt.registerFactory<KeyValueStorage>(() => RustKeyValue());
    getIt.registerFactory<KeyValueStorage>(() => DartKeyValue());

    await _resolveCloudDeps(getIt);
    _resolveUserDeps(getIt, mode);
    _resolveHomeDeps(getIt);
    _resolveFolderDeps(getIt);
    _resolveCommonService(getIt, mode);
  }
}

Future<void> _resolveCloudDeps(GetIt getIt) async {
  final env = await AppFlowyCloudSharedEnv.fromEnv();
  Log.info("cloud setting: $env");
  getIt.registerFactory<AppFlowyCloudSharedEnv>(() => env);
  getIt.registerFactory<AIRepository>(() => AppFlowyAIService());

  if (isAppFlowyCloudEnabled) {
    getIt.registerSingleton(
      AppFlowyCloudDeepLink(),
      dispose: (obj) async {
        await obj.dispose();
      },
    );
  }
}

void _resolveCommonService(
  GetIt getIt,
  IntegrationMode mode,
) async {
  getIt.registerFactory<FilePickerService>(() => FilePicker());

  getIt.registerFactory<ApplicationDataStorage>(
    () => mode.isTest ? MockApplicationDataStorage() : ApplicationDataStorage(),
  );

  getIt.registerFactory<ClipboardService>(
    () => ClipboardService(),
  );

  // theme
  getIt.registerFactory<BaseAppearance>(
    () => UniversalPlatform.isMobile ? MobileAppearance() : DesktopAppearance(),
  );

  getIt.registerFactory<FlowyCacheManager>(
    () => FlowyCacheManager()
      ..registerCache(TemporaryDirectoryCache())
      ..registerCache(CustomImageCacheManager())
      ..registerCache(FeatureFlagCache()),
  );

  getIt.registerSingleton<EasyLocalizationService>(EasyLocalizationService());
}

void _resolveUserDeps(GetIt getIt, IntegrationMode mode) {
  switch (currentCloudType()) {
    case AuthenticatorType.local:
      getIt.registerFactory<AuthService>(
        () => BackendAuthService(
          AuthTypePB.Local,
        ),
      );
      break;
    case AuthenticatorType.appflowyCloud:
    case AuthenticatorType.appflowyCloudSelfHost:
    case AuthenticatorType.appflowyCloudDevelop:
      getIt.registerFactory<AuthService>(() => AppFlowyCloudAuthService());
      break;
  }

  getIt.registerFactory<AuthRouter>(() => AuthRouter());

  getIt.registerFactory<SignInBloc>(
    () => SignInBloc(getIt<AuthService>()),
  );
  getIt.registerFactory<SignUpBloc>(
    () => SignUpBloc(getIt<AuthService>()),
  );

  getIt.registerFactory<SplashRouter>(() => SplashRouter());
  getIt.registerFactory<EditPanelBloc>(() => EditPanelBloc());
  getIt.registerFactory<SplashBloc>(() => SplashBloc());
  getIt.registerLazySingleton<NetworkListener>(() => NetworkListener());
  getIt.registerLazySingleton<CachedRecentService>(() => CachedRecentService());
  getIt.registerLazySingleton<ViewAncestorCache>(() => ViewAncestorCache());
  getIt.registerLazySingleton<SubscriptionSuccessListenable>(
    () => SubscriptionSuccessListenable(),
  );
}

void _resolveHomeDeps(GetIt getIt) {
  getIt.registerSingleton(FToast());

  getIt.registerSingleton(MenuSharedState());

  getIt.registerFactoryParam<UserListener, UserProfilePB, void>(
    (user, _) => UserListener(userProfile: user),
  );

  // share
  getIt.registerFactoryParam<ShareBloc, ViewPB, void>(
    (view, _) => ShareBloc(view: view),
  );

  getIt.registerSingleton<ActionNavigationBloc>(ActionNavigationBloc());

  getIt.registerLazySingleton<TabsBloc>(() => TabsBloc());

  getIt.registerSingleton<ReminderBloc>(ReminderBloc());

  getIt.registerSingleton<RenameViewBloc>(RenameViewBloc(PopoverController()));
}

void _resolveFolderDeps(GetIt getIt) {
  // Workspace
  getIt.registerFactoryParam<WorkspaceListener, UserProfilePB, String>(
    (user, workspaceId) =>
        WorkspaceListener(user: user, workspaceId: workspaceId),
  );

  getIt.registerFactoryParam<ViewBloc, ViewPB, void>(
    (view, _) => ViewBloc(
      view: view,
    ),
  );

  // User
  getIt.registerFactoryParam<SettingsUserViewBloc, UserProfilePB, void>(
    (user, _) => SettingsUserViewBloc(user),
  );

  // Trash
  getIt.registerLazySingleton<TrashService>(() => TrashService());
  getIt.registerLazySingleton<TrashListener>(() => TrashListener());
  getIt.registerFactory<TrashBloc>(
    () => TrashBloc(),
  );

  // Favorite
  getIt.registerFactory<FavoriteBloc>(() => FavoriteBloc());
}