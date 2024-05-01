import Foundation

protocol DefaultInteractorProtocol {
    func fetch<DecodableType: Decodable>(decodableType: DecodableType.Type,
                                         apiData: APIData,
                             completionHandler: @escaping ((Result<DecodableType, NetworkError>) -> Void))
}
