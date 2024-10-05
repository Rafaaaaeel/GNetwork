public protocol ClientProtocol {
    func execute<T: Decodable>(_ request: URLRequest) async throws -> T
}

internal class Client: ClientProtocol {
    
    internal static var shared = Client()
    
    private let session: URLSessionProtocol
    
    private init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }
    
    internal static func withSession(_ session: URLSessionProtocol) -> Client {
        return Client(session: session)
    }
    
  
    
}
