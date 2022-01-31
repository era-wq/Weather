import UIKit

final class AppInteractorImp: NSObject, AppInteractor {

    private let window: UIWindow?
    private var appCoordinator: AppCoordinator?

    init(for window: UIWindow?) {

        self.window = window

        super.init()
    }

    func onStart() {

        appCoordinator = AppCoordinatorAssembly.assembly()
        appCoordinator?.onStart()

        window?.rootViewController = appCoordinator?.viewController
        window?.makeKeyAndVisible()
    }
}
