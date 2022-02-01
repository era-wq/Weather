import Foundation

protocol LocalErasable {

    associatedtype Model

    func eraseToLocal() -> Model?
}
