import Foundation

enum NetworkingErrors: LocalizedError {
    case failedToDecodeData(underlying: Error)
    case invalidResponse
    case serverError(statusCode: Int)

    var errorDescription: String? {
        switch self {
        case .failedToDecodeData:
            "Could not read the server response"
        case .invalidResponse:
            "Unexpected response from the server."
        case .serverError(let code):
            "Server error (\(code)). Please try again later."
        }
    }
}
