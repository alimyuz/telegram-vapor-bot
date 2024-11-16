// Swift Telegram SDK - Telegram Bot Swift SDK.

/**
 This object contains the data of the Mini App user.
 
 SeeAlso Telegram Bot API Reference:
 [WebAppUser](https://core.telegram.org/bots/webapps#webappuser)
 **/

public struct TGWebAppUser: Decodable {
    
    /// Custom keys for coding/decoding `WebAppUser` struct
    enum CodingKeys: String, CodingKey {
        case id
        case isBot = "is_bot"
        case firstName = "first_name"
        case lastName = "last_name"
        case username
        case languageCode = "language_code"
        case isPremium = "is_premium"
        case addedToAttachmentMenu = "added_to_attachment_menu"
        case allowsWriteToPm = "allows_write_to_pm"
        case photoUrl = "photo_url"
    }
    
    /// A unique identifier for the user or bot.
    let id: Int64
    
    /// Optional. True, if this user is a bot. Returns in the receiver field only.
    let isBot: Bool?
    
    /// First name of the user or bot.
    let firstName: String
    
    /// Optional. Last name of the user or bot.
    let lastName: String?
    
    /// Optional. Username of the user or bot.
    let username: String?
    
    /// Optional. IETF language tag of the user's language. Returns in the user field only.
    let languageCode: String?
    
    /// Optional. True, if this user is a Telegram Premium user.
    let isPremium: Bool?
    
    /// Optional. True, if this user added the bot to the attachment menu.
    let addedToAttachmentMenu: Bool?
    
    /// Optional. True, if this user allowed the bot to message them.
    let allowsWriteToPm: Bool?
    
    /// Optional. URL of the user’s profile photo. The photo can be in .jpeg or .svg formats.
    /// Only returned for Mini Apps launched from the attachment menu.
    let photoUrl: String?
}
