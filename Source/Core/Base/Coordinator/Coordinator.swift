import Foundation

protocol Coordinator: AnyObject, Module {

    var router: Router { get }

    func onStart()
}
