import UIKit

protocol CityForecastTableViewAdapterDelegate: AnyObject {

    func onTapDay(_ day: String)
}

protocol CityForecastTableViewAdapter {

    func setup(_ tableView: UITableView)
    func set(_ days: [DayWeather])
}

// swiftlint:disable type_name
final class CityForecastTableViewAdapterImp: NSObject,
                                             CityForecastTableViewAdapter {

    private weak var tableView: UITableView?

    weak var delegate: CityForecastTableViewAdapterDelegate?

    private var days: [DayWeather] = []

    func setup(_ tableView: UITableView) {

        self.tableView = tableView
        self.tableView?.register(headerFooter: DisclosureTableHeaderView.self)
        self.tableView?.register(cell: DayPartForecastTableViewCell.self)
        self.tableView?.dataSource = self
        self.tableView?.delegate = self
        self.tableView?.allowsSelection = false
        self.tableView?.separatorStyle = .none
        self.tableView?.showsVerticalScrollIndicator = false
        if #available(iOS 15.0, *) {
            self.tableView?.sectionHeaderTopPadding = 0
        }
    }

    func set(_ days: [DayWeather]) {

        self.days = days

        tableView?.reloadData()
    }
}

extension CityForecastTableViewAdapterImp: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {

        days.count
    }

    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {

        days[section].forecast.count
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = CellResolver<DayPartForecastTableViewCell>.resolve(in: tableView,
                                                                      on: indexPath)

        cell.model = days[indexPath.section].forecast[indexPath.row]

        return cell
    }
}

extension CityForecastTableViewAdapterImp: UITableViewDelegate {

    func tableView(_ tableView: UITableView,
                   viewForHeaderInSection section: Int) -> UIView? {

        let header = tableView.header(type: DisclosureTableHeaderView.self)

        header?.model = days[section].day
        header?.delegate = self

        return header
    }

    func tableView(_ tableView: UITableView,
                   heightForHeaderInSection section: Int) -> CGFloat {

        UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView,
                   estimatedHeightForHeaderInSection section: Int) -> CGFloat {

        44
    }
}

extension CityForecastTableViewAdapterImp: DisclosureTableHeaderViewDelegate {

    func onDisclosureTap(_ model: DisclosureHeader) {

        delegate?.onTapDay(model.id)
    }
}
