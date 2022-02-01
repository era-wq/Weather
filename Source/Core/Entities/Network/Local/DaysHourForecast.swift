import Foundation

struct DaysHourForecast {

    let hourTimeStamp: Int
    let temperature: Int
    let icon: URL?
}

extension DaysHourForecast: DatabaseErasable {

    func eraseToDatabase() -> DBDaysHourForecast {

        let object = DBDaysHourForecast()

        object.hourTimeStamp = hourTimeStamp
        object.temperature = temperature
        object.icon = icon?.absoluteString ?? ""

        return object
    }
}
