import Foundation
import RealmSwift

class DBDaysHourForecast: Object {

    @Persisted var hourTimeStamp: Int
    @Persisted var temperature: Int
    @Persisted var icon: String
}

extension DBDaysHourForecast: LocalErasable {

    func eraseToLocal() -> DaysHourForecast? {

        let icon = URL(string: icon)

        let daysHourForecast = DaysHourForecast(hourTimeStamp: hourTimeStamp,
                                                temperature: temperature,
                                                icon: icon)

        return daysHourForecast
    }
}
