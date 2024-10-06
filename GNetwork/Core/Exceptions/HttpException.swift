public enum HttpException: Error, CustomNSError {
    
    case badRequest
    case unauthorized
    case notFound
    case conflict
    case gone
    case tooMany
    case unknown
    
    static public let map = [
        400 : HttpException.badRequest,
        401 : HttpException.unauthorized,
        404 : HttpException.badRequest,
        409 : HttpException.conflict,
        410 : HttpException.gone,
        429 : HttpException.tooMany
    ]

    var localizedDescription: String{
        switch self {
        case .badRequest:
            return "400 - Bad Request"
        case .unauthorized:
            return "401 - Unauthorized"
        case .notFound:
            return "404 - Not Found"
        case .conflict:
            return "409 - Conflict"
        case .gone:
            return "410 - Gone"
        default:
            return "Unknown Error"
        }
    }

    var errorMessage: [String : Any] {
        [NSLocalizedDescriptionKey: localizedDescription]
    }
}
