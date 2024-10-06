public protocol HttpBridgeProtocol {
    func execute<T: Decodable>(_ request: URLRequest) async throws -> T
}
