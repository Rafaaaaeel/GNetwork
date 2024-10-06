public class TokenManager: TokenManagerProtocol {
    
    private let http    : HttpBridgeProtocol
    
    private let client  : ClientSettingsProtocol
    
    public init(http: HttpBridgeProtocol = HttpBridge(), client: ClientSettingsProtocol = Settings.shared.client) {
        self.http   = http
        self.client = client
    }
    
    public func refreshToken() async throws -> Token {
        guard let token = client.token, !isTokenValid() else {
            let token = try await token()
            
            client.set(token)
            
            return token
        }
        
        return token
    }
    
    private func isTokenValid() -> Bool {
        guard let token = client.token else { return false }
        
        return Date() > Date(timeInterval: TimeInterval(token.expiresIn), since: .now)
    }
    
    private func token() async throws -> Token {
        let request = Url.Builder()
            .set("https://id.twitch.tv/oauth2/token")
            .set(client.secrets!)
            .set(.post)
            .build()
        
        return try await http.execute(request)
    }
    
}
