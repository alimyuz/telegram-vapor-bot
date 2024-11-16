// Swift Telegram SDK - Telegram Bot Swift SDK.

/**
 WebAppInitData validator received via the Mini App.
 
 SeeAlso Telegram Bot API Reference:
 [Validating data received via the Mini App](https://core.telegram.org/bots/webapps#validating-data-received-via-the-mini-app)
 **/

public struct TGWebAppInitDataValidator {
    
    public func validateTelegramInitData(initData: String, botToken: String) -> Bool {
        guard let components = URLComponents(string: "https://example.com?" + initData),
              let queryItems = components.queryItems else {
            return false
        }
        
        let sortedItems = queryItems.filter { $0.name != "hash" }
            .sorted { lhs, rhs in lhs.name < rhs.name }
            .reduce("") { r, i in r + "\(i.name)=\(i.value!)\n" }
            .dropLast()
        
        let dataCheckString = sortedItems
        guard let rawHashFromQuery = queryItems.first(where: { $0.name == "hash" })?.value else {
            return false
        }
        
        let authSecretCode = HMAC<SHA256>.authenticationCode(
            for: Data(botToken.utf8),
            using: SymmetricKey(data: "WebAppData".data(using: .utf8)!))
        
        let hash1 = HMAC<SHA256>.authenticationCode(
            for: dataCheckString.data(using: .utf8)!,
            using: SymmetricKey(data: Data(authSecretCode))
        ).withUnsafeBytes { Data($0) }
        
        let hexString = hash1.map { String(format: "%02hhx", $0) }.joined()
        
        return hexString == rawHashFromQuery
    }
}
