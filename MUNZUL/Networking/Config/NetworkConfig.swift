import Foundation

enum ResponseDataType {
    case Data
    case JSON
}

enum ParameterEncoding {
    case url
    case json
}

enum URLRequestError: Error {
    case invalidURLParameters
    case jsonEncodingError
}

enum RequestMethod: String {
    case options = "OPTIONS"
    case get = "GET"
    case head = "HEAD"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
    case trace = "TRACE"
    case connect = "CONNECT"
}
