import UIKit

final class AppInteractorImp: NSObject, AppInteractor {

    private let window: UIWindow?
    private var appCoordinator: AppCoordinator?

    init(for window: UIWindow?) {

        self.window = window

        super.init()

        setupDI()
    }

    func onStart() {

        appCoordinator = AppCoordinatorAssembly.assembly()
        appCoordinator?.onStart()

        window?.rootViewController = appCoordinator?.viewController
        window?.makeKeyAndVisible()
    }
}

extension AppInteractorImp {

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
