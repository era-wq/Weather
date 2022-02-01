import Foundation

struct ServerForecastWeather: Decodable {

    let date: String?
    let parts: ServerForecastWeatherPart?
    let hours: [ServerDaysHourForecast]?
}

extension ServerForecastWeather: LocalErasable {

    func eraseToLocal() -> ForecastWeather? {

        guard let date = date,
              let parts = parts?.eraseToLocal(),
              let hours = hours?.eraseToLocal() else {
            return nil
        }

        let forecastWeather = ForecastWeather(date: date,
                                              parts: parts,
                                              hours: hours)

        return forecastWeather
    }
}
