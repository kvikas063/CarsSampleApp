import Foundation

/// Define your custom errors
enum ApiError: Error {
    case invalidPath
    case invalidJson
}

extension ApiError {
    
    var description: String {
        switch self {
        case .invalidPath:
            return "Invalid Path"
        case .invalidJson:
            return "Invalid Json"
        }
    }
}
