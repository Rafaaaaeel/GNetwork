import OSLog

let logger = Logger(subsystem: "GNetowrk", category: "HTTP")

internal class GLogger {

    internal static func log(_ request: URLRequest, _ response: HTTPURLResponse) {
        logger.info(" <------ Http Request ------>\nurl: \(request.url?.absoluteString ?? "nil")\nmethod: \(request.httpMethod ?? "nil")\nheaders: \(request.allHTTPHeaderFields ?? [:])\nbody: \(request.httpBody ?? Data())\nstatusCode: \(response.statusCode)\n<------- End Request ------>\n\n")
    }
    
    internal static func log(_ error: Error) {
        logger.error("Request failed with error: \(error.localizedDescription, privacy: .public)")
    }
    
    internal static func log(_ message: String) {
        execute(message)
    }
    
    private static func execute(_ message: String) {
        print("Logged ------> : \(message)")
    }
    
}
