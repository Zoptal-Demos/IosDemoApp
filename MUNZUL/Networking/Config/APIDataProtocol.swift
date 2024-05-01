import Foundation

protocol APIData {
    var baseUrlType: BaseURLType { get }
    var requestMethod: RequestMethod { get }
    var relativeURL: String { get }
    var headers: [String: String]? { get }
    var isUnsigned: Bool { get }
    var appendCommonHeaders: Bool { get }
    var parameterEncoding: ParameterEncoding { get }
    func params() -> [String: Any]
}

extension APIData {
    var isUnsigned: Bool { return false }
    var baseUrlType: BaseURLType {.home } 
    var appendCommonHeaders: Bool { return true }
    func params() -> [String: Any] {
        return [String: Any]()
    }
}
