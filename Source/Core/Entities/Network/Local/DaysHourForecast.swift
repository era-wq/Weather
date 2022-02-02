import Foundation

struct DaysHourForecast {

    let hourTimeStamp: Int
    let temperature: Int
    let icon: String
}

extension DaysHourForecast: DatabaseErasable {

    func eraseToDatabase() -> DBDaysHourForecast {

        let object = DBDaysHourForecast()

        object.hourTimeStamp = hourTimeStamp
        object.temperature = temperature
        object.icon = icon

        return object
    }
}
