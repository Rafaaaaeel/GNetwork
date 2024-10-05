public protocol TokenManagerProtocol {
    func refreshToken() async throws -> Token
}
