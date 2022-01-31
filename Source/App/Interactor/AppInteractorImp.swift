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

        let databaseService = DatabaseService()
        let cityDetectionService = CitiesFetchService()

        DIContainer.shared.register(databaseService as DatabaseService)
        DIContainer.shared.register(cityDetectionService as CitiesFetchService)
    }
}
