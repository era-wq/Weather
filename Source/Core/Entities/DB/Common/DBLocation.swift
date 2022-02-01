import RealmSwift

class DBLocation: Object {

    @Persisted var latitude: Double
    @Persisted var longitude: Double
}

extension DBLocation: LocalErasable {

    func eraseToLocal() -> Location? {

        let location = LocationModel(latitude: latitude,
                                     longitude: longitude)

        return location
    }
}
