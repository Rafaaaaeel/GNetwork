public struct Secrets {
    public let clientId: String
    public let clientSecret: String
    public let grantType: String
    
    public init(clientId: String, clientSecret: String, grantType: String) {
        self.clientId = clientId
        self.clientSecret = clientSecret
        self.grantType = grantType
    }
}
