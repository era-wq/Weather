import UIKit

extension UITableView {

    func register<Cell: UITableViewCell>(cell type: Cell.Type) {

        register(Cell.self, forCellReuseIdentifier: Cell.reuseIdentifier)
    }

    func register<Header: UITableViewHeaderFooterView>(headerFooter type: Header.Type) {

        register(Header.self,
                 forHeaderFooterViewReuseIdentifier: Header.reuseIdentifier)
    }

    func dequeue<Cell: UITableViewCell>(type: Cell.Type,
                                        for indexPath: IndexPath) -> Cell? {

        dequeueReusableCell(withIdentifier: Cell.reuseIdentifier,
                            for: indexPath) as? Cell
    }

    func header<Header: UITableViewHeaderFooterView>(type: Header.Type) -> Header? {

        dequeueReusableHeaderFooterView(withIdentifier: Header.reuseIdentifier) as? Header
    }
}
