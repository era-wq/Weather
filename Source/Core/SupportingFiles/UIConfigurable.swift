import Foundation

@objc protocol UIConfigurable: AnyObject {

    func configureUI()
    @objc optional func setInitialAppearance()
    func addSubviews()
    func makeConstraints()
}
