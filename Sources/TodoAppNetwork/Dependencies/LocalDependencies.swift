import Foundation

protocol LocalDependencies {
    var decoder: JSONDecoder { get }
    var encoder: JSONEncoder { get }
}

extension LocalDependencies {

    var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }

    var encoder: JSONEncoder {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        return encoder
    }

}
