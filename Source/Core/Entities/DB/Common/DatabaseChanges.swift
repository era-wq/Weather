import Foundation
import RealmSwift

struct LocalChanges<T> {

    let insertions: [T]
    let modifications: [T]
}

struct DatabaseChanges<T: Object> {

    let insertions: [T]
    let modifications: [T]

    init(results: Results<T>,
         insertions: [Int],
         modifications: [Int]) {

        self.insertions = insertions
            .map { results.count > $0 ? results[$0] : nil }
            .compactMap { $0 }
        self.modifications = modifications
            .map { results.count > $0 ? results[$0] : nil }
            .compactMap { $0 }
    }
}
