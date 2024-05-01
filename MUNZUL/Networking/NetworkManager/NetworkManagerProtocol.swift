import Foundation

protocol NetworkManagerProtocol {
    func startRequest(apiData: APIData, completion: @escaping (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void)
}


public protocol DataRequestProtocol {
    @discardableResult func cancel() -> Self
}

extension DataRequestProtocol {
}
