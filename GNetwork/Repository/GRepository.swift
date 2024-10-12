public protocol GRepositoryProtocol {
    var network: NetworkManagerProtocol { get }
    
    func request<T>(local: @escaping () async throws -> T, remote: @escaping () async throws -> T) async throws -> T?
}

open class GRepository : GRepositoryProtocol {
    
    open var network: NetworkManagerProtocol
    
    open var isPreview: Bool = false
    
    public init(network: NetworkManagerProtocol) {
        self.network = network
    }
    
    open func request<T>(local: @escaping () async throws -> T, remote: @escaping () async throws  -> T) async throws -> T? {
        if isPreview {
            return try? await local()
        } else {
            return try? await remote()
        }
    }
    
}
