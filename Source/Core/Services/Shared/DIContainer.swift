import Foundation

final class DIContainer {

    static let shared = DIContainer()

    private lazy var services: [String: Any] = [:]

    private init() {}

    func register<T>(_ service: T) {
        let key = typeName(T.self)
        services[key] = service
    }

    func resolve<T>() -> T? {
        let key = typeName(T.self)
        return services[key] as? T
    }
}

private extension DIContainer {

    func typeName(_ some: Any) -> String {
        return (some is Any.Type) ? "\(some)" : "\(type(of: some))"
    }
}
