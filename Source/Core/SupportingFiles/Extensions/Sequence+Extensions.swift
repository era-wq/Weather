import Foundation

extension Sequence where Iterator.Element == NSAttributedString {

    func joined(with separator: NSAttributedString) -> NSAttributedString {

        return reduce(NSMutableAttributedString()) { (result, element) in

            if result.length > 0 {
                result.append(separator)
            }

            result.append(element)
            return result
        }
    }

    func joined(with separator: String = "") -> NSAttributedString {

        joined(with: NSAttributedString(string: separator))
    }
}
