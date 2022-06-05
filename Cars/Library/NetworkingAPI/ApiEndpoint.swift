import Foundation

enum ApiEndpoint {
    
    enum Method: String {
        case GET
        case POST
        case PUT
        case DELETE
    }
    
    /// Define all your endpoints here
    
    case getCarsList(path: String)
}

extension ApiEndpoint {

    /// The path for every endpoint
    var path: String {
        switch self {
        case .getCarsList(let value):
            return value
        }
    }
    
    /// The method for the endpoint
    var method: ApiEndpoint.Method {
        switch self {
        default:
            return .GET
        }
    }
    
    /// The URL parameters for the endpoint (in case it has any)
    var parameters: [URLQueryItem]? {
        switch self {
        default:
            return nil
        }
    }
}
