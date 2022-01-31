import Foundation

protocol Location {

    var latitude: Double { get }
    var longitude: Double { get }
}

class LocationModel: Location {

    let latitude: Double
    let longitude: Double

    init(latitude: Double, longitude: Double) {

        self.latitude = latitude
        self.longitude = longitude
    }
}
