// Swift Telegram SDK - Telegram Bot Swift SDK.

/**
 WebAppInitData authenticator received via the Mini App for the Vapor framework.
 
 SeeAlso Telegram Bot API Reference:
 [Validating data received via the Mini App](https://core.telegram.org/bots/webapps#validating-data-received-via-the-mini-app)
 **/

#if canImport(Vapor)
import Vapor


struct TGWebAppVaporAuthenticator: AsyncRequestAuthenticator {
    
    let initDataSource: ((Request) -> String?)
    let secretToken: ((Request) -> String?)
    
    func authenticate(request: Request) async throws {
        guard let token = self.secretToken(request) else {
            request.logger.error("No telegram secret token for the request")
            throw Abort(.internalServerError)
        }
        guard let initDataStr = self.initDataSource(request),
              TGWebAppInitDataValidator().validateTelegramInitData(initData: initDataStr, botToken: token) else {
            throw Abort(.unauthorized)
        }
        
        let initData = try WebAppInitData(initData: initDataStr)
        request.auth.login(initData)
    }
}
#endif
