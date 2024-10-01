internal extension Optional where Wrapped == HttpException {
    
    var orUnknown: HttpException {
        return self ?? HttpException.unknown
    }
    
}
