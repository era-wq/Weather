import Foundation

struct DayPartWeather {

    let temperature: Int
    let icon: String
}

extension DayPartWeather: DatabaseErasable {

    func eraseToDatabase() -> DBDayPartWeather {

        let object = DBDayPartWeather()

        object.temperature = temperature
        object.icon = icon

        return object
    }
}
