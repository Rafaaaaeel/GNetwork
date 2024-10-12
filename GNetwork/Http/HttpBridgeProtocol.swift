public protocol HttpBridgeProtocol {
    func execute<T: Decodable>(_ request: URLRequest) async throws -> T
    func execute<T: Decodable>(with mock: Data) async throws -> T
}
