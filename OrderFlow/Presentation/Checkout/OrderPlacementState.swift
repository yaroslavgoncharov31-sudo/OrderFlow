import Foundation

enum OrderPlacementState: Equatable {
    case idle
    case placing
    case placed(message: String)
    case failed(message: String)
}
