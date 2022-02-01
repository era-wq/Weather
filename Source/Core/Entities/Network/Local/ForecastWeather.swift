import Foundation

struct ForecastWeather {

    let date: String
    let parts: ForecastWeatherPart
    let hours: [DaysHourForecast]
}

extension ForecastWeather: DatabaseErasable {

    func eraseToDatabase() -> DBForecastWeather {

        let object = DBForecastWeather()

        object.date = date
        object.parts = parts.eraseToDatabase()
        object.hours = hours.eraseToDatabase()

        return object
    }
}
