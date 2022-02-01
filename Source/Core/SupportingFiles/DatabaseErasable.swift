import RealmSwift

protocol DatabaseErasable {

    associatedtype Model: Object

    func eraseToDatabase() -> Model
}
