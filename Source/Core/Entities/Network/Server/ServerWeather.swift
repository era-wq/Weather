import Foundation

struct ServerWeather: Decodable {

    let forecastWeather: [ServerForecastWeather]?

    enum CodingKeys: String, CodingKey {
        case forecastWeather = "forecasts"
    }
}

extension ServerWeather: LocalErasable {

    func eraseToLocal() -> Weather? {

        guard let forecastWeather = forecastWeather?.eraseToLocal() else {
            return nil
        }

        let weather = Weather(forecastWeather: forecastWeather)

        return weather
    }
}
