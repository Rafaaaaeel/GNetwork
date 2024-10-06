import GNetwork
import XCTest

class TokenManagerTestCases: XCTestCase {
    
    var sut                 : TokenManager!
    
    var httpBridgeStub      : HttpBridgeStub!
    var clientSettingsMock  : ClientSettingsFake!
    
    override func setUp() {
        httpBridgeStub      = .init()
        clientSettingsMock  = .init()
        
        sut = .init(http: httpBridgeStub, client: clientSettingsMock)
    }
    
    override func tearDown() {
        sut                 = nil
        httpBridgeStub      = nil
        clientSettingsMock  = nil
    }
    
    func test_refreshToken_whenTokenIsValid_shouldReturnToken() async {
        // Given
        clientSettingsMock.set(Token.dummy())
        
        // When
        let response = try! await sut.refreshToken()
        
        // Then
        XCTAssertEqual(response.tokenType, "Test")
    }
    
    func test_refreshToken_whenTokenIsNotValid_shouldReturnNewToken() async {
        // Given
        let data = """
        {
            "access_token": "",
            "expires_in": 5000,
            "token_type": "New"
        }
        """.data(using: .utf8)!
        
        httpBridgeStub.data = data
        
        clientSettingsMock.set(Token.dummy(expiresIn: -1000))
        
        // When
        let response = try! await sut.refreshToken()
        
        // Then
        XCTAssertEqual(response.tokenType, "New")
    }
    
}
