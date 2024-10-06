import GNetwork

extension Secrets {
    static func dummy(
        clientId        : String = "123",
        clientSecret    : String = "abc",
        grantType       : String = "bearer") -> Secrets {
            
        Secrets(
            clientId: clientId,
            clientSecret: clientSecret,
            grantType: grantType
        )
    }
}
