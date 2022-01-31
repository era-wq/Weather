import UIKit

@main
class AppDelegate: UIResponder,
                   UIApplicationDelegate {

    var window: UIWindow?

    private var appInteractor: AppInteractor?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {

        appInteractor = AppInteractorImp(for: window)

        appInteractor?.onStart()

        return true
    }
}
