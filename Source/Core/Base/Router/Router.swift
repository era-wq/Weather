import UIKit

protocol Router: Module {

    var navigationController: UINavigationController { get }
    var rootViewController: UIViewController? { get }

    func push(_ module: Module, animated: Bool)
    func pop(animated: Bool)
    func root(_ module: Module, animated: Bool)
}
