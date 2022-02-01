import Alamofire
import Foundation

typealias NetworkResponse<T> = (Swift.Result<T, NetworkError>) -> Void

protocol ForecastNetworkService {

    func fetchWeather(using forecast: ForecastRequest,
                      onCompletion completion: @escaping NetworkResponse<ServerWeather>)
}

final class NetworkManager {

    private lazy var session: Session = {

        let configuration = URLSessionConfiguration.default
        let session = Session(configuration: configuration,
                              rootQueue: DispatchQueue.global())

        return session
    }()

    func perform<E: Endpoint,
                 D: Decodable>(endpoint: E,
                               onCompletion completion: @escaping NetworkResponse<D>) {

        session.request(endpoint)
            .validate()
            .responseDecodable(of: D.self) { json in

                guard let data = json.data else {

                    completion(.failure(.decodingError))
                    return
                }

                do {

                    let decoder = JSONDecoder()
                    let response = try decoder.decode(D.self,
                                                      from: data)

                    completion(.success(response))
                } catch {

                    completion(.failure(.decodingError))
                }
            }
    }
}

extension NetworkManager: ForecastNetworkService {

    func fetchWeather(using forecast: ForecastRequest,
                      onCompletion completion: @escaping NetworkResponse<ServerWeather>) {

        perform(
            endpoint: ForecastEndpoint.fetchWeather(forecast),
            onCompletion: completion
        )
    }
}
