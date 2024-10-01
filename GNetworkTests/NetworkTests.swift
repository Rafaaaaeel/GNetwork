import XCTest
import GNetwork

class NetworkTests: XCTestCase {
    
    var network: Network!
    var sessionStub: URLSessionStub!
    
    override func setUp() {
        super.setUp()
        sessionStub = URLSessionStub()
        network = Network.withSession(sessionStub)
    }
    
    override func tearDown() {
        super.tearDown()
        
        self.network = nil
        self.sessionStub = nil
    }
    
    func test_request_success() async {
        // Given
        let expectation = XCTestExpectation(description: "Network request completes")
        let query = ["Query" : "2"]
        let endpoint = "/games"
        
        let expected = "https://api.igdb.com/v4/games?Query=2"
        
        var result: String = String()
        
        // When
        do {
            let request: ResponseMock =  try await network.request<ResponseMock>(headers: nil, queries: query, body: nil, method: .GET, endpoint: endpoint)
            
            result = request.url
            
            expectation.fulfill()
        } catch {
            XCTFail("Request failed with error: \(error.localizedDescription)")
        }
        
        
        // Then
        XCTAssertEqual(result, expected)
        
        await fulfillment(of: [expectation], timeout: 5.0)
    }
    
    func test_token_succes() async {
        let expectation = XCTestExpectation(description: "Network request completes")
        let query = ["client_id" : "123"]
        
        let data = """
            {
              "access_token": "access12345token",
              "expires_in": 5587808,
              "token_type": "bearer"
            }
        """.data(using: .utf8)!
        
        sessionStub.data = data
        
        // When
        do {
            let request: Token =  try await network.token(queries: query, method: .POST)
            
            
            XCTAssertEqual(request.accessToken, "access12345token")
            XCTAssertEqual(request.expiresIn, 5587808)
            XCTAssertEqual(request.tokenType, "bearer")
            
            expectation.fulfill()
        } catch {
            XCTFail("Request failed with error: \(error.localizedDescription)")
        }
        
        
        await fulfillment(of: [expectation], timeout: 5.0)
    }
    
    func test_token_url_succes() async {
        let expectation = XCTestExpectation(description: "Network request completes")
        let query = ["client_id" : "123"]
        
        
        
        let expected = "https://id.twitch.tv/oauth2/token?client_id=123"
        
        // When
        do {
            let request: ResponseMock =  try await network.token(queries: query, method: .POST)
            
            
            XCTAssertEqual(request.url, expected)
            
            expectation.fulfill()
        } catch {
            XCTFail("Request failed with error: \(error.localizedDescription)")
        }
        
        
        await fulfillment(of: [expectation], timeout: 5.0)
    }
    
}


