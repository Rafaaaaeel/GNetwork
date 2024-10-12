public protocol ClientSettingsProtocol {
    var token   : Token? { get }
    var secrets : Secrets? { get }
    var isPreview: Bool { get }
    
    func set(_ token: Token)
    func set(_ secrets: Secrets)
    func set(_ isPreview: Bool)
}

public protocol LoggerSettingsProtocol {
    func set(_ isLogEnabled: Bool)
}


