import GNetwork

class URLSessionStub: URLSessionProtocol {
    
    var URLReturn   : (Data, URLResponse)?
    
    var error       : Error?
    
    func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        
        if let error {
            throw error
        }
        
        return URLReturn!
    }
    
}
