import GNetwork

extension Token {
    static func dummy(accessToken: String = "abc",
                      expiresIn: Int = 10000,
                      tokenType: String = "Test") -> Token {
        Token(
            accessToken: accessToken,
            expiresIn: expiresIn,
            tokenType: tokenType
        )
    }
}
