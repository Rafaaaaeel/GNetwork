import GCore

public class NetworkManager: NetworkManagerProtocol {
    
    private let http            :   HttpBridgeProtocol
    
    private let client          :   ClientSettingsProtocol
    
    private let tokenManager    :   TokenManagerProtocol
    
    public init(http: HttpBridgeProtocol = HttpBridge(), client: ClientSettingsProtocol = Settings.shared.client, tokenManager: TokenManagerProtocol = TokenManager()) {
        self.http           =   http
        self.client         =   client
        self.tokenManager   =   tokenManager
    }
    
    public func request<T: Decodable>(headers: Params? = nil,
                                      queries: Params? = nil,
                                      body: Data? = nil,
                                      method: HttpMethod = .post,
                                      endpoint: String = .empty) async throws -> T {
        
        let request = Url.Builder()
            .set("https://api.igdb.com/v4")
            .set(method)
            .set(queries)
            .add(endpoint)
            .add(headers)
            .add(body)
            .authorization(try await tokenManager.refreshToken(), client.secrets!)
            .build()
        
        let data: T = try await http.execute(request)
        
        return data
    }
}


