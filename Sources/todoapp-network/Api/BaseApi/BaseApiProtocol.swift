import Foundation
import Alamofire

public enum BaseApiError: String, Error {
    // Internal Error Codes
    case unknownError 			= "001" // These are undefined errors
    case errorDecodingFailure 	= "002" // Not possible to decode the network error. (Error data model is different.)
    case missingErrorResponse 	= "003" // The error response data is nil. (Receive error eg.: status code 401, but no response data.)
    case missingNetworkResponse = "004" // The network response is nil. (eg.: device is offline/request timeout)

    func toErrorMessage(customMessage: String? = nil, statusCode: Int? = nil) -> Common.ErrorMessage.Response {
        let message = customMessage ?? "Something went wrong." // NOTE: Not sure if we should expose these in production or (just return a default message) not
        return Common.ErrorMessage.Response(message: customMessage, errorCode: self.rawValue, statusCode: statusCode)
    }
}

internal protocol BaseApiProtocol: LocalDependencies {

    var baseUrl: String! { get set }
    var apiKey: String! { get set }
    var decoder: JSONDecoder { get }
    var encoder: JSONEncoder { get }
    var headers: [String: String] { get }
}

extension BaseApiProtocol {
    internal func convertToData<T: Encodable>(data: T) -> Data? {
        do {
            return try encoder.encode(data)
        } catch {
            return nil
        }
    }

    internal func convertToNetworkError(data: Data, statusCode: Int, fallbackMessage: String? = nil) -> Common.ErrorMessage.Response {
        do {
            var error = try decoder.decode(Common.ErrorMessage.Response.self, from: data)
            error.statusCode = statusCode
            return error
        } catch {
            return BaseApiError.errorDecodingFailure.toErrorMessage(statusCode: statusCode)
        }
    }
}
