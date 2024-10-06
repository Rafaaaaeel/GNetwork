struct HttpMock: Codable {
    var url     : String
    var method  : String
    var headers : [String: String?]
}
