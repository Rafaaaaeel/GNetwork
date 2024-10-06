public enum HttpMethod: String {
    case get    = "GET"
    case post   = "POST"
    case put    = "PUT"
    case delete = "DELETE"
    
    var type: String {
        return self.rawValue
    }
}
