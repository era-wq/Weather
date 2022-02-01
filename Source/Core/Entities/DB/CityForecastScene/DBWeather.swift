import RealmSwift

class DBWeather: Object {

    @Persisted var forecast: List<DBForecastWeather>
}

extension DBWeather: LocalErasable {

    func eraseToLocal() -> Weather? {

        Weather(forecastWeather: forecast.eraseToLocal())
    }
}
