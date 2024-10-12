import GCore

final public class Settings {
    
    public static let shared   = Settings()
    
    public let client: Client  = Client.shared
    
    public let logger: Logger  = Logger.shared
    
    private init() {}
    
    public class Client : ClientSettingsProtocol {
         
        public static let shared = Client()
        
        public var token      : Token?
        
        public var secrets    : Secrets?
        
        public var isPreview  : Bool = false
        
        private init() {}
        
        public func set(_ token: Token) {
            self.token = token
        }

        public func set(_ secrets: Secrets) {
            self.secrets = secrets
        }
        
        public func set(_ isPreview: Bool) {
            self.isPreview = isPreview
        }
        
    }
    
    public class Logger: LoggerSettingsProtocol {
        
        public static let shared = Logger()
        
        public func set(_ isLogEnabled: Bool) {
            GCore.GLogger.loggerEnabled = isLogEnabled
        }
    }

}
