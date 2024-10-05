import GCore

internal class Url {
    
    internal let components: URLComponents?
    
    internal let request: URLRequest
    
    internal let headers: [String : String]?
    
    internal let queries: [String : String]?
    
    internal let body: Encodable?
    
    internal let method: HttpMethod
    
    private init(components: URLComponents?, request: URLRequest, headers: [String : String]?, queries: [String : String]?, body: Encodable?, method: HttpMethod) {
        self.components = components
        self.request = request
        self.headers = headers
        self.queries = queries
        self.body = body
        self.method = method
    }
    
    internal class Builder {
        internal var components: URLComponents?
        
        internal var request: URLRequest = URLRequest(url: URL(string: "https:://localhost:8080/api")!)
        
        internal var headers: [String : String]?
        
        internal var queries: [String : String]?
        
        internal var body: Encodable?
        
        internal var method: HttpMethod  = .get
        
        
        internal func add(_ headers: Params?) -> Builder {
            guard let headers else { return self }
            
            headers.forEach { request.addValue($1, forHTTPHeaderField: $0) }
            
            return self
        }
        
        internal func set(_ baseUrl: String) -> Builder {
            self.components = URLComponents(string: baseUrl)
            
            return self
        }
        
        internal func add(_ endpoint: String) -> Builder {
            self.components?.path += endpoint
            
            return self
        }
        
        internal func set(_ queries: Params?) -> Builder {
            guard let queries else { return self }
            
            if components?.queryItems == nil {
                components?.queryItems = []
            }
            
            queries.forEach { components?.queryItems?.append(URLQueryItem(name: $0, value: $1)) }
            
            return self
        }
        
        internal func set(_ method: HttpMethod) -> Builder {
            self.method = method
            
            return self
        }
        
        internal func add(_ secrets: Secrets) -> Builder {
            
            let headers = [
                "client_id": secrets.clientId,
                "client_secrets": secrets.clientSecret,
                "grand_type": secrets.grantType,
            ]
            
            headers.forEach { request.addValue($1, forHTTPHeaderField: $0) }
            
            return self
        }
        
        internal func authorization(_ token: Token, _ secrets: Secrets) -> Builder {
            
            let headers = [
                "Client-ID": secrets.clientId,
                "Authorization": token.accessToken,
            ]
            
            headers.forEach { request.addValue($1, forHTTPHeaderField: $0) }
            
            return self
        }
        
        internal func add(_ body: Encodable?) -> Builder {
            guard let body else { return self }
            
            request.httpBody = try? JSONEncoder().encode(body)
            
            return self
        }
        
        internal func build() -> URLRequest {
            
            request.url = components?.url
            request.httpMethod = method.type
            
            return request
        }
    }
    
}

extension String {
    
    var queryFormatted: String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? self
    }
    
}
