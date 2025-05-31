import 'package:citystat/startup/startup.dart';
import 'package:citystat/packages/citystat_backend/lib/log.dart';

class RecentServiceTask extends LaunchTask {
  const RecentServiceTask();

  @override
  Future<void> initialize(LaunchContext context) async {
    await super.initialize(context);

    Log.info('[CachedRecentService] Initialized');
  }
}
