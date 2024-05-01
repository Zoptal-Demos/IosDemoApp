import Foundation

class DefaultInteractor: DefaultInteractorProtocol {
    
    private let networkManager: NetworkManagerProtocol
    private var keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy
    private let dateDecodingStrategy: JSONDecoder.DateDecodingStrategy
    private let rootQueue: DispatchQueue
    
    init(authorizationManager: NetworkManagerProtocol = NetworkManager.shared,
         _ keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys, dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .deferredToDate) {
        self.networkManager = authorizationManager
        self.keyDecodingStrategy = keyDecodingStrategy
        self.rootQueue = DispatchQueue(label: "com.DemoApp.home.APIClient.rootQueue", attributes: .concurrent)
        self.dateDecodingStrategy = dateDecodingStrategy
        
    }
    
    func fetch<DecodableType: Decodable>(decodableType: DecodableType.Type,
                                         apiData: APIData,
                             completionHandler: @escaping ((Result<DecodableType, NetworkError>) -> Void)) {
        
        self.networkManager.startRequest(apiData: apiData) { [weak self] (data, response, error) in
            guard let self = self else {
                print("returning from else in default interector ")
                return
            }
            self.rootQueue.async {
                if let error = error {
                    if let response = response as? HTTPURLResponse {
                        completionHandler(.failure(.requestFailed(statusCode: response.statusCode, response: response, underlyingError: error)))
                    } else {
                        completionHandler(.failure(.requestFailed(statusCode: 0, response: response, underlyingError: error)))
                    }
                    return
                }
                
                guard let responseData = response as? HTTPURLResponse,
                      let receivedData = data else {
                    completionHandler(.failure(NetworkError.noResponseData))
                    return
                }
                
                let responseStatus = self.isValidResposne(response: responseData)
                switch responseStatus {
                case .success:
                    let jsonDecoder = JSONDecoder()
                    jsonDecoder.keyDecodingStrategy = self.keyDecodingStrategy
                    do {
                        self.printResponse(data: receivedData)
                        let apiResponseModel = try jsonDecoder.decode(DecodableType.self, from: receivedData)
                        completionHandler(.success(apiResponseModel))
                    } catch ( let error ) {
                        print(error.localizedDescription)
                        
                        completionHandler(.failure(NetworkError.unableToDecodeResponseData(errorDescription: error.localizedDescription)))
                    }
                case .failure(let error):
                    completionHandler(.failure(error))
                }
            }
        }
    }
    
    func isValidResposne(response: HTTPURLResponse) -> Result<String, NetworkError>{
        switch response.statusCode{
        case 200...299:
            return .success("Valid Response")
        case 401:
            return .failure(NetworkError.authenticationError)
        case 500:
            return .failure(NetworkError.badRequest)
        default:
            return .failure(NetworkError.failed)
        }
    }
}

extension DefaultInteractor {
    private func printResponse(data: Data) {
        
        
        do {
            // make sure this JSON is in the format we expect
            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                      print(json)
             }
        } catch let error as NSError {
            print("Failed to load: \(error.localizedDescription)")
        }
    }
}
