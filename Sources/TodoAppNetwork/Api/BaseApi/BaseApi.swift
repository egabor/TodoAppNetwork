import Foundation
import Alamofire
import Combine
import Logging

public typealias EmptyResponse = Alamofire.Empty

internal class BaseApi: BaseApiProtocol {

    var baseUrl: String!
    var apiKey: String!
    var headers: [String: String] {
        [
            HTTPHeaderKey.accept.rawValue: HTTPHeaderValue.applicationJson.rawValue,
            HTTPHeaderKey.contentType.rawValue: HTTPHeaderValue.applicationJson.rawValue,
            HTTPHeaderKey.authorization.rawValue: apiKey,
        ]
    }

    var logger: Logger

    init(logger: Logger, baseUrl: String, apiKey: String) {
        self.logger = logger
        self.baseUrl = baseUrl
        self.apiKey = apiKey
    }

    func buildRequest<D: Decodable>(with requestData: URLRequestConvertible) async throws -> D {
        logger.info("Building request: \(requestData.description)")
        let dataTask = AF
            .request(requestData)
            .validate(statusCode: 200...299)
            .serializingDecodable(D.self, decoder: self.decoder)
        let response = await dataTask.response

        do {
            let value = try await dataTask.value
            return value
        } catch let error {
            logger.error("Request failed: \(error)")
            let fallbackMessage = error.localizedDescription
            guard let networkResponse = response.response else {
                throw BaseApiError.missingNetworkResponse.toErrorMessage(customMessage: fallbackMessage)
            }
            guard let data = response.data else {
                throw BaseApiError.missingErrorResponse.toErrorMessage(customMessage: fallbackMessage, statusCode: networkResponse.statusCode)
            }
            let errorObject = convertToNetworkError(
                data: data,
                statusCode: networkResponse.statusCode,
                fallbackMessage: fallbackMessage
            )
            throw errorObject
        }
    }
}
