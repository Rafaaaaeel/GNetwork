import GCore

public class Network: NetworkProtocol {
    
    private let session: URLSessionProtocol
        
    public static let shared = Network()
    
    private init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }
    
    public static func withSession(_ session: URLSessionProtocol) -> Network {
        return Network(session: session)
    }
    
    public func request<T: Decodable>(headers: [String : String]? = nil,
                                      queries: [String : String]? = nil,
                                      body: Encodable? = nil,
                                      method: HttpMethod,
                                      endpoint: String = .empty) async throws -> T {
        let request = Url()
            .set("https://api.igdb.com/v4")
            .add(endpoint)
            .set(method)
            .set(queries)
            .add(headers)
            .add(body)
            .build()
        
        let data: T = try await execute(request)
        
        return data
    }
    
    public func token<T: Decodable>(queries: [String : String], method: HttpMethod = .POST) async throws -> T {
        let request = Url()
            .set("https://id.twitch.tv/oauth2/token")
            .set(queries)
            .set(method)
            .build()
        
        let token: T = try await execute(request)
        
        return token
    }
    
    private func execute<T: Decodable>(_ request: URLRequest) async throws -> T {
        do {
            let (data, response) = try await session.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkException.invalidResponse
            }
            
            guard 200..<300 ~= httpResponse.statusCode else {
                throw HttpException.map[httpResponse.statusCode].orUnknown
            }
            
            let decodable = try JSONDecoder().decode(T.self, from: data)
            
            return decodable
        } catch {
            throw NetworkException.serializationError
        }
    }
    
}
