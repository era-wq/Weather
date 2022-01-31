import UIKit

final class RouterImp: NSObject, Router {

    let navigationController: UINavigationController

    var rootViewController: UIViewController? {

        navigationController.viewControllers.first
    }

    var viewController: UIViewController? {

        navigationController
    }

    init(navigationController: UINavigationController) {

        self.navigationController = navigationController

        super.init()
    }

    func push(_ module: Module, animated: Bool) {

        guard let viewController = module.viewController,
              !(viewController is UINavigationController) else { return }

        navigationController.pushViewController(viewController,
                                                animated: animated)
    }

    func pop(animated: Bool) {}

    func root(_ module: Module, animated: Bool) {

        guard let viewController = module.viewController else { return }

        navigationController.setViewControllers([viewController],
                                                animated: animated)
    }
}
