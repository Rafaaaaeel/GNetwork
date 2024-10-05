import GCore

public protocol NetworkManagerProtocol {
    func request<T: Decodable>(headers: Params?, queries: Params?, body: Encodable?, method: HttpMethod, endpoint: String) async throws -> T
}
