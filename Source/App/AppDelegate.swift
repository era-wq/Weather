import UIKit
import SnapKit

@main
class AppDelegate: UIResponder,
                   UIApplicationDelegate {

    var window: UIWindow?

    private var appCoordinator: AppCoordinator?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {

        setupDI()

        appCoordinator = AppCoordinatorAssembly.assembly()
        appCoordinator?.onStart()

        window?.rootViewController = appCoordinator?.viewController
        window?.makeKeyAndVisible()

        return true
    }
}

private extension AppDelegate {

    func setupDI() {

        let networkManager = NetworkManager()
        let databaseService = DatabaseService()
        let appInitialStateService = AppInitialStateServiceImp(database: databaseService)
        let citiesFetchService = CitiesFetchService()

        DIContainer.shared.register(networkManager as NetworkManager)
        DIContainer.shared.register(databaseService as DatabaseService)
        DIContainer.shared.register(appInitialStateService as AppInitialStateService)
        DIContainer.shared.register(citiesFetchService as CitiesFetchService)
    }
}
