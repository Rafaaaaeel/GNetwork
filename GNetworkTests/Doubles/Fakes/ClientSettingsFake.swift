import GNetwork

class ClientSettingsFake: ClientSettingsProtocol {
    
    var token       : Token?     = nil
    
    var secrets     : Secrets? = nil
    
    var isPreview   : Bool = false
    
    func set(_ token: Token) {
        self.token = token
    }
    
    func set(_ secrets: Secrets) {
        self.secrets = secrets
    }
    
    func set(_ isPreview: Bool) {
        self.isPreview = isPreview
    }
    
}
