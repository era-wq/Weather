import Foundation

protocol ForecastRequest {

    var latitude: Double { get }
    var longitude: Double { get }
    var limit: Int { get }
    var language: ForecastLanguage { get }
    var hours: Bool { get }
    var extra: Bool { get }
}

struct ForecastRequestModel: ForecastRequest {

    let latitude: Double
    let longitude: Double
    let limit: Int = 7
    let language: ForecastLanguage = .russian
    let hours: Bool = true
    let extra: Bool = true
}

extension ForecastRequestModel {

    init(from location: Location) {

        latitude = location.latitude
        longitude = location.longitude
    }
}
