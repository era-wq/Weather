import Foundation
import RealmSwift

class DBLocation: EmbeddedObject {

    @Persisted var latitude: Double?
    @Persisted var longitude: Double?
}
