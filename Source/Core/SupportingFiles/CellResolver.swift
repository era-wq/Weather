import UIKit

struct CellResolver<T: UITableViewCell> {

    static func resolve(
        in tableView: UITableView,
        on indexPath: IndexPath) -> T {

            guard let cell = tableView.dequeue(type: T.self,
                                               for: indexPath) else {
                fatalError("Should dequeue cell for \(T.self)")
            }

            cell.selectionStyle = .none

            return cell
        }
}
