import RealmSwift

class DBCity: Object {

    @Persisted var id: Int
    @Persisted var name: String
    @Persisted var location: DBLocation?
}

extension DBCity: LocalErasable {

    func eraseToLocal() -> City? {

        guard let location = location?.eraseToLocal() else {

            return nil
        }

        let city = CityModel(
            id: id,
            name: name,
            location: location
        )

        return city
    }
}
