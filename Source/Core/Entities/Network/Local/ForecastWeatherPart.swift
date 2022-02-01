import Foundation

struct ForecastWeatherPart {

    let night: DayPartWeather
    let morning: DayPartWeather
    let day: DayPartWeather
    let evening: DayPartWeather
}

extension ForecastWeatherPart: DatabaseErasable {

    func eraseToDatabase() -> DBForecastWeatherPart {

        let object = DBForecastWeatherPart()

        object.night = night.eraseToDatabase()
        object.morning = morning.eraseToDatabase()
        object.day = day.eraseToDatabase()
        object.evening = evening.eraseToDatabase()

        return object
    }
}
