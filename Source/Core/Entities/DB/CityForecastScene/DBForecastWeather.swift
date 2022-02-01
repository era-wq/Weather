import RealmSwift

class DBForecastWeather: Object {

    @Persisted var date: String
    @Persisted var parts: DBForecastWeatherPart?
    @Persisted var hours: List<DBDaysHourForecast>
}

extension DBForecastWeather: LocalErasable {

    func eraseToLocal() -> ForecastWeather? {

        guard let parts = parts?.eraseToLocal() else {

            return nil
        }

        let forecastWeather = ForecastWeather(date: date,
                                              parts: parts,
                                              hours: hours.eraseToLocal())

        return forecastWeather
    }
}
