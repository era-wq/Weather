import Foundation
import Alamofire

/// Version type of a network endpoint.
enum EndpointVersion {
    /// Uses when there should not be a version of the api.
    case none
    /// Uses with interpolation given version number.
    /// Example: v1, v2.
    case number(Int)
    /// Uses when there should be a custom version key exept of standart "v".
    case custom(String)

    var value: String {
        switch self {
        case .none:
            return ""
        case .custom(let key):
            return "/\(key)"
        case .number(let number):
            return "/v\(number)"
        }
    }
}

extension EndpointVersion: Equatable {}

/// Protocol of the default network endpoint.
/// Each network endpoint must conform it.
protocol Endpoint: URLRequestConvertible {

    typealias Method = HTTPMethod
    typealias RequestParameters = Parameters
    typealias RequestHeaders = [String: String]

    /// The hostname of api endpoint.
    /// Default one is hostname from API of Environment.
    var hostname: String { get }
    /// The version of the endpoint. Default is none.
    var version: EndpointVersion { get }
    var path: String { get }
    var method: Method { get }
    var parameters: RequestParameters? { get }
    var headers: RequestHeaders? { get }
}

extension Endpoint {

    var hostname: String {

        Environment.API.hostname
    }

    var version: EndpointVersion {

        .none
    }

    var headers: RequestHeaders? {

        return nil
    }

    func asURLRequest() throws -> URLRequest {

        guard let request = RequestBuilder.createRequest(from: self) else {

            throw NetworkError.failureOnRequestCreation
        }

        return try URLEncoding.default.encode(request, with: parameters)
    }
}
