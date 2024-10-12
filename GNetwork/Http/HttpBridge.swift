import GCore

public final class HttpBridge: HttpBridgeProtocol {
    
    private let session: URLSessionProtocol
    
    public init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }
    
    public func execute<T: Decodable>(_ request: URLRequest) async throws -> T {
        do {
            let (data, response) = try await session.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkException.invalidResponse
            }
            
            GLogger.log(request, httpResponse)
            
            guard 200..<399 ~= httpResponse.statusCode else {
                throw HttpException.map[httpResponse.statusCode].orUnknown
            }
            
            let decodable = try JSONDecoder().decode(T.self, from: data)
            
            return decodable
        } catch let error {
            GLogger.log(error)
            throw error
        }
       
    }
    
    public func execute<T: Decodable>(with mock: Data) async throws -> T {

        try await Task.sleep(for: .seconds(2))
        
        let result = try? JSONDecoder().decode(T.self, from: mock)
        
        return result!
        
    }
    
}
