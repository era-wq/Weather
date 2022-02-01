import RealmSwift

extension RealmCollection where Element: LocalErasable {

    func eraseToLocal<T>() -> [T] {

        compactMap { $0.eraseToLocal() as? T }
    }
}
