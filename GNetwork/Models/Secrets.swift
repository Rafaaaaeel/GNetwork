public struct Secrets: Codable {
    public let clientId     : String
    public let clientSecret : String
    public let grantType    : String
    
    public init(clientId: String, clientSecret: String, grantType: String) {
        self.clientId       = clientId
        self.clientSecret   = clientSecret
        self.grantType      = grantType
    }
    
    enum CodingKeys: String, CodingKey {
        case clientId       = "client_id"
        case clientSecret   = "client_secret"
        case grantType      = "grant_type"
    }
}
