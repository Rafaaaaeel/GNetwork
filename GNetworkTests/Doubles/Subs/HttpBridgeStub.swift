import GNetwork

class HttpBridgeStub: HttpBridgeProtocol {
    
    var data: Data?
    
    func execute<T: Decodable>(_ request: URLRequest) async throws -> T {
            
        let mockData = """
            {
                "url": "\(request.url?.absoluteString ?? "")", 
                "method": "\(request.httpMethod ?? "")",
                "headers": {
                    "Client-ID": "\(request.allHTTPHeaderFields!["Client-ID"] ?? "error")",
                    "Authorization": "\(request.allHTTPHeaderFields!["Authorization"] ?? "error")"
                }
            }
             
        """.data(using: .utf8)!
        
        
        return try JSONDecoder().decode(T.self, from: self.data ?? mockData)
    }
    
    func execute<T>(with mock: Data) async throws -> T where T : Decodable {
        return try JSONDecoder().decode(T.self, from: mock)
    }
    
    
}
