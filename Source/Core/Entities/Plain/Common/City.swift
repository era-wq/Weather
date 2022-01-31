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
