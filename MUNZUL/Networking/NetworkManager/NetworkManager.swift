import Foundation

final class NetworkManager: NetworkManagerProtocol {
    // make this class singletone
    private init() {}
    static let shared = NetworkManager()
    
    
    
    private var task: URLSessionTask?
    private let urlSession = URLSession.shared
    // Based on your project requirement this queue qos can be differenc
    private let backgroundQueue = DispatchQueue.global(qos: .utility)
    
   
    
    func startRequest(apiData: APIData, completion: @escaping (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void) {
           GlobalLoader.shared.startLoading() // Start loader before request
           self.backgroundQueue.async { [weak self] in
               guard let self = self else { return }
               do {
                   let urlRequest = try self.getUrlRequest(apiData: apiData)
                   self.task = self.urlSession.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
                       completion(data, response, error)
                       DispatchQueue.main.async { // Ensure UI updates on main thread
                           GlobalLoader.shared.stopLoading() // Stop loader after response
                       }
                   })
                   self.task?.resume()
               } catch {
                   completion(nil, nil, error)
                   DispatchQueue.main.async { // Ensure UI updates on main thread
                       
                       GlobalLoader.shared.stopLoading() // Stop loader on error
                   }
               }
           }
       }
   
}

private extension NetworkManager {
    
    private func getUrlRequest(apiData: APIData) throws -> URLRequest {
        
        let urlString = NetworkUtility.baseUrl(apiData.baseUrlType) + apiData.relativeURL
        print("Caling API: \(urlString)")
        guard let url = URL(string: urlString) else {
            throw NetworkError.malformedURL
        }
        
        let requestBuilder = URLRequestBuilder(url: url,
                                               method: apiData.requestMethod,
                                               headerParams: apiData.headers,
                                               bodyParams: apiData.params(),
                                               parameterEncoding: apiData.parameterEncoding)
        do {
            return try requestBuilder.build()
        } catch let error as URLRequestError {
            switch error {
                case .invalidURLParameters:
                    throw NetworkError.invalidParameters
                case .jsonEncodingError:
                    throw NetworkError.parameterEncodingFailed
            }
        }
    }
}
