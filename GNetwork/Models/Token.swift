public struct Token: Codable {
    public var accessToken  : String
    public var expiresIn    : Int
    public var tokenType    : String
    
    public init(accessToken: String, expiresIn: Int, tokenType: String) {
        self.accessToken    = accessToken
        self.expiresIn      = expiresIn
        self.tokenType      = tokenType
    }
    
    enum CodingKeys: String, CodingKey {
        case accessToken    = "access_token"
        case expiresIn      = "expires_in"
        case tokenType      = "token_type"
    }
}
