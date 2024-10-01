internal class Url {
    
    internal var components: URLComponents?
    
    internal var request: URLRequest = URLRequest(url: URL(string: "https:://localhost:8080/api")!)
    
    internal var headers: [String : String]?
    
    internal var queries: [String : String]?
    
    internal var body: Encodable?
    
    internal var method: HttpMethod = .GET
 
    internal func add(_ headers: [String : String]?) -> Url {
        guard let headers else { return self }
        
        headers.forEach { request.addValue($1, forHTTPHeaderField: $0) }
        
        return self
    }
    
    internal func set(_ baseUrl: String) -> Url {
        self.components = URLComponents(string: baseUrl)
        
        return self
    }
    
    internal func add(_ endpoint: String) -> Url {
        self.components?.path += endpoint
        
        return self
    }
    
    internal func set(_ queries: [String : String]?) -> Url {
        guard let queries else { return self }
        
        if components?.queryItems == nil {
            components?.queryItems = []
        }
        
        queries.forEach { components?.queryItems?.append(URLQueryItem(name: $0, value: $1)) }
        
        return self
    }
    
    internal func set(_ method: HttpMethod) -> Url {
        self.method = method
        
        return self
    }
    
    internal func add(_ body: Encodable?) -> Url {
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
