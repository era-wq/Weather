import RealmSwift

class DBDayPartWeather: Object {

    @Persisted var temperature: Int
    @Persisted var icon: String
}

extension DBDayPartWeather: LocalErasable {

    func eraseToLocal() -> DayPartWeather? {

        let dayPart = DayPartWeather(temperature: temperature,
                                     icon: icon)

        return dayPart
    }
}
