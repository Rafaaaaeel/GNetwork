public protocol ClientSettingsProtocol {
    var token   : Token? { get }
    var secrets : Secrets? { get }
    
    func set(_ token: Token)
    func set(_ secrets: Secrets)
}
