public protocol NetworkProtocol {
    func request<T: Decodable>(headers: [String : String]?, queries: [String : String]?, body: Encodable?, method: HttpMethod, endpoint: String) async throws -> T
    
    func token<T: Decodable>(queries: [String : String], method: HttpMethod) async throws -> T
}
