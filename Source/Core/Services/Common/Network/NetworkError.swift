import Foundation

enum NetworkError: Error {

    case failureOnRequestCreation
    case decodingError
    case badRequest
}
