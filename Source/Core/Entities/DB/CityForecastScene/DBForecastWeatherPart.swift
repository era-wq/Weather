import RealmSwift

class DBForecastWeatherPart: Object {

    @Persisted var night: DBDayPartWeather?
    @Persisted var morning: DBDayPartWeather?
    @Persisted var day: DBDayPartWeather?
    @Persisted var evening: DBDayPartWeather?
}

extension DBForecastWeatherPart: LocalErasable {

    func eraseToLocal() -> ForecastWeatherPart? {

        guard let night = night?.eraseToLocal(),
              let morning = morning?.eraseToLocal(),
              let day = day?.eraseToLocal(),
              let evening = evening?.eraseToLocal() else { return nil }

        let weatherPart = ForecastWeatherPart(
            night: night,
            morning: morning,
            day: day,
            evening: evening
        )

        return weatherPart
    }
}
