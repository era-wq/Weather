protocol HourForecastViewOutput {

    var tableViewAdapter: HourForecastTableViewAdapter? { get set }
    func onViewDidLoad()
}
