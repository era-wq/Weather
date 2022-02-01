import Foundation

class RequestBuilder {

    class func createRequest<E: Endpoint>(from endpoint: E) -> URLRequest? {

        var components = URLComponents()
        components.scheme = "https"
        components.host = endpoint.hostname
        components.path = endpoint.version.value + endpoint.path

        guard let url = components.url else { return nil }

        var request = URLRequest(url: url)
        request.method = endpoint.method

        if let headers = endpoint.headers {
            headers.forEach { request.setValue($0.value, forHTTPHeaderField: $0.key) }
        }

        return request
    }
}
