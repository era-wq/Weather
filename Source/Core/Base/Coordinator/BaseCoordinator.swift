import UIKit

class BaseCoordinator: Module {

    let router: Router

    var childCoordinators: [Coordinator] = []

    var viewController: UIViewController? {

        router.viewController
    }

    init(router: Router) {

        self.router = router
    }

    func add(_ coordinator: Coordinator) {

        for childCoordinator in childCoordinators where childCoordinator === coordinator {

            return
        }

        childCoordinators.append(coordinator)
    }

    func remove(_ child: Coordinator?) {

        guard !childCoordinators.isEmpty else { return }

        for coordinator in childCoordinators.enumerated() where coordinator.element === child {

            childCoordinators.remove(at: coordinator.offset)
            break
        }
    }
}
