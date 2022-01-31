import RealmSwift

class DBCity: Object {

    @Persisted var id: Int
    @Persisted var name: String
    @Persisted var location: DBLocation?
}
