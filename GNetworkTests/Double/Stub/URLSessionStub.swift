import GNetwork

class URLSessionStub: URLSessionProtocol {
    
    var data: Data?
    
    func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        
        let mockData = """
            {
                "url": "\(request.url!)"
            }
            """.data(using: .utf8)!

        let response = HTTPURLResponse(url: request.url!, mimeType: nil, expectedContentLength: 200, textEncodingName: nil)
        
        return (data ?? mockData, response)
    }
    
}

        
