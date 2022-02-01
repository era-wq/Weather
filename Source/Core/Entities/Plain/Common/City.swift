import Foundation

protocol City {

    var id: Int { get }
    var name: String { get }
    var location: Location { get }
}

struct CityModel: City {

    let id: Int
    let name: String
    let location: Location
}

extension CityModel: DatabaseErasable {

    func eraseToDatabase() -> DBCity {

        let object = DBCity()

        object.id = id
        object.name = name
        object.location = (location as? LocationModel)?.eraseToDatabase()

        return object
    }
}
