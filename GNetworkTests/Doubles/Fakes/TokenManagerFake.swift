import GNetwork

class TokenManagerFake: TokenManagerProtocol {
    
    func refreshToken() async throws -> Token {
        .dummy(accessToken: "abc", expiresIn: 10000, tokenType: "123")
    }
    
}
