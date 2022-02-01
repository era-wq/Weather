protocol CityForecastModuleOutput {

    var onChooseDay: (([DaysHourForecast]) -> Void)? { get set }
}
