import GNetwork
import XCTest

class NetworkManagerTestCases: XCTestCase {
    
    var sut: NetworkManager!
    
    // http stub
    var httpBridgeStub: HttpBridgeStub!
    // client mock
    var clientSettingsFake: ClientSettingsFake!
    // tokenManager mock
    var tokenManagerFake: TokenManagerFake!
    
    override func setUp() {
        httpBridgeStub = .init()
        clientSettingsFake = .init()
        tokenManagerFake = .init()
        
        clientSettingsFake.set(.dummy(clientId: "dfg", clientSecret: "xyz", grantType: "acess")
        )
        
        sut = .init(http: httpBridgeStub, client: clientSettingsFake, tokenManager: tokenManagerFake)
    }
    
    override func tearDown() {
        sut = nil
        
        httpBridgeStub = nil
        clientSettingsFake = nil
        tokenManagerFake = nil
    }
    
    func test_request_default() async {
        // When
        let response: HttpMock = try! await sut.request()
        
        // Then
        XCTAssertEqual(response.method, "POST")
        XCTAssertEqual(response.url, "https://api.igdb.com/v4")
        XCTAssertEqual(response.headers, ["Authorization": "abc", "Client-ID": "dfg"])
    }
    
    func test_request_when_has_endpoint() async {
        // Given
        let endpoint = "/games"
        
        // When
        let response: HttpMock = try! await sut.request(endpoint: endpoint)
        
        // Then
        XCTAssertEqual(response.url, "https://api.igdb.com/v4/games")
    }
    
    func test_request_when_has_queries() async {
        // Given
        let queries: [String : String] = ["name" : "Dark Souls"]
        
        // When
        let response: HttpMock = try! await sut.request(queries: queries)
        
        // Then
        XCTAssertEqual(response.url, "https://api.igdb.com/v4?name=Dark%20Souls")
    }
    
}
