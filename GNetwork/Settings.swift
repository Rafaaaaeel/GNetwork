import GCore

public protocol ClientSettingsProtocol {
    var token: Token? { get }
    var secrets: Secrets? { get }
    
    func set(_ token: Token)
    func set(_ secrets: Secrets)
}

public class Settings {
    
    public static let shared = Settings()
    
    public let client: Client = Client.shared
    
    private init() {}
    
    public class Client : ClientSettingsProtocol {
        
        public static let shared = Client()
        
        public var token: Token?
        
        public var secrets: Secrets?
        
        public func set(_ token: Token) {
            self.token = token
        }

        public func set(_ secrets: Secrets) {
            self.secrets = secrets
        }
        
    }

}
