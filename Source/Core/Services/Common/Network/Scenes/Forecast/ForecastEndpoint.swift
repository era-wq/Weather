import Foundation

enum ForecastEndpoint {

    case fetchWeather(ForecastRequest)
}

extension ForecastEndpoint: Endpoint {

    var path: String {

        switch self {
        case .fetchWeather:

            return "/forecast"
        }
    }

    var method: Endpoint.Method {

        switch self {
        case .fetchWeather:

            return .get
        }
    }

    var parameters: RequestParameters? {

        var params: RequestParameters = [:]

        switch self {
        case .fetchWeather(let model):

            params["lat"] = model.latitude
            params["lon"] = model.longitude
            params["lang"] = model.language.rawValue
            params["limit"] = model.limit
            params["hours"] = model.hours
            params["extra"] = model.extra

            return params
        }
    }

    var version: EndpointVersion {

        return .number(Environment.API.version)
    }

    var headers: RequestHeaders? {

        var header: RequestHeaders = [:]

        header[Environment.API.apiKey] = Environment.Keys.apiToken

        return header
    }
}
