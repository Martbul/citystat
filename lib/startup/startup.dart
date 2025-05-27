final getIt = GetIt.instance;

Future<void> runAppCityStat({bool isAnon = false}) async {
  Log.info('restart CityStat: isAnon: $isAnon');

  if (kReleaseMode) {
    await FlowyRunner.run(
      AppFlowyApplication(),
      integrationMode(),
      isAnon: isAnon,
    );
  } else {
    // When running the app in integration test mode, we need to
    // specify the mode to run the app again.
    await FlowyRunner.run(
      AppFlowyApplication(),
      FlowyRunner.currentMode,
      didInitGetItCallback: IntegrationTestHelper.didInitGetItCallback,
      rustEnvsBuilder: IntegrationTestHelper.rustEnvsBuilder,
      isAnon: isAnon,
    );
  }
}