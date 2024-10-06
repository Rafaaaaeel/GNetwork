import GCore

public class Settings {
    
    public static let shared    = Settings()
    
    public let client: Client   = Client.shared
    
    private init() {}
    
    public class Client : ClientSettingsProtocol {
        
        public static let shared = Client()
        
        public var token    : Token?
        
        public var secrets  : Secrets?
        
        public func set(_ token: Token) {
            self.token = token
        }

        public func set(_ secrets: Secrets) {
            self.secrets = secrets
        }
        
    }

}
