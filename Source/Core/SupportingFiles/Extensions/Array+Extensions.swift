import Foundation
import RealmSwift

extension Array where Element: Decodable, Element: LocalErasable {

    func eraseToLocal<T>() -> [T] where T == Element.Model {

        compactMap { $0.eraseToLocal() }
    }
}

extension Array where Element: DatabaseErasable {

    func eraseToDatabase<T>() -> List<T> where T == Element.Model {

        let array = map { $0.eraseToDatabase() }
        let list = List<T>()

        list.append(objectsIn: array)

        return list
    }
}
