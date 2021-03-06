import UIKit

class AppCoordinatorAssembly {

    class func assembly() -> AppCoordinator {

        let navigationController = UINavigationController()
        let router = RouterImp(navigationController: navigationController)

        let coordinator = AppCoordinatorImp(router: router)

        coordinator.appInitialStateService = DIContainer.shared.resolve()

        return coordinator
    }
}
