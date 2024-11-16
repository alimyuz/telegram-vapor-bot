// Swift Telegram SDK - Telegram Bot Swift SDK.

/**
 This object represents a chat.
 
 SeeAlso Telegram Bot API Reference:
 [WebAppChat](https://core.telegram.org/bots/webapps#webappchat)
 **/

public struct TGWebAppChat: Decodable {
    
    /// Custom keys for coding/decoding `WebAppChat` struct
    enum CodingKeys: String, CodingKey {
        case id
        case type
        case title
        case username
        case photoUrl = "photo_url"
    }
    
    enum ChatType: String, Decodable {
        case group
        case supergroup
        case channel
    }
    
    /// Unique identifier for this chat.
    let id: Int64
    
    /// Type of chat, can be either “group”, “supergroup” or “channel”
    let type: ChatType
    
    /// Title of the chat.
    let title: String
    
    /// Optional. Username of the chat.
    let username: String?
    
    /// Optional. URL of the chat’s photo. The photo can be in .jpeg or .svg formats.
    /// Only returned for Mini Apps launched from the attachment menu.
    let photoUrl: String?
}
