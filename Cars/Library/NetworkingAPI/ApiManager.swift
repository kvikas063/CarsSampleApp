import Foundation

final class ApiManager {
        
    static let shared = ApiManager()
    
    private let session = URLSession.shared
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
      
    func getData(from endpoint: ApiEndpoint, completionBlock: @escaping (AnyObject?, Error?) -> Void) {
        guard let request = createRequest(from: endpoint) else {
            completionBlock(nil, NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid Path"]))
            return
        }
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as AnyObject
                    completionBlock(json, nil)
                } catch let error {
                    completionBlock(nil, error)
                }
            } else {
                completionBlock(nil, error)
            }
        }.resume()
    }
}

private extension ApiManager {
    
    func createRequest(from endpoint: ApiEndpoint) -> URLRequest? {
        guard let urlPath = URL(string: ApiHelper.baseURL.appending(endpoint.path)), var urlComponents = URLComponents(string: urlPath.path) else {
            return nil
        }
        
        if let parameters = endpoint.parameters {
            urlComponents.queryItems = parameters
        }
        
        var request = URLRequest(url: urlPath)
        request.httpMethod = endpoint.method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        return request
    }
}
