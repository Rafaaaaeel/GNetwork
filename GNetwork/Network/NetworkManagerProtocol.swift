import GCore

public protocol NetworkManagerProtocol {
    func request<T: Decodable>(headers: Params?, queries: Params?, body: Data?, method: HttpMethod, endpoint: String) async throws -> T
}

public extension NetworkManagerProtocol {
    func request<T: Decodable>(
        headers: Params? = nil,
        queries: Params? = nil,
        body: Data? = nil,
        method: HttpMethod,
        endpoint: String
    ) async throws -> T {
        return try await request(headers: headers, queries: queries, body: body, method: method, endpoint: endpoint)
    }
}
