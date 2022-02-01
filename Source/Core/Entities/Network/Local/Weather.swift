import Foundation

struct Weather {

    let forecastWeather: [ForecastWeather]
}

extension Weather: DatabaseErasable {

    func eraseToDatabase() -> DBWeather {

        let object = DBWeather()

        object.forecast = forecastWeather.eraseToDatabase()

        return object
    }
}
