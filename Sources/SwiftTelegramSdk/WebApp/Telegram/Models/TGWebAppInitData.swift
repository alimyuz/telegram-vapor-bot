// Swift Telegram SDK - Telegram Bot Swift SDK.

/**
 This object contains data that is transferred to the Mini App when it is opened. It is empty if the Mini App was launched from a keyboard button or from inline mode.
 
 SeeAlso Telegram Bot API Reference:
 [WebAppInitData](https://core.telegram.org/bots/webapps#webappinitdata)
 **/

import Foundation

public struct TGWebAppInitData {
    
    /// Custom decoding errors
    enum DecodingError: Error {
        case invalidQuery
        case missingField(field: String)
        case invalidValue(field: String, value: String)
    }
    
    /// Custom keys for coding/decoding `WebAppInitData` struct
    enum CodingKeys: String, CodingKey {
        case queryId = "query_id"
        case user
        case receiver
        case chat
        case chatType = "chat_type"
        case chatInstance = "chat_instance"
        case startParam = "start_param"
        case canSendAfter = "can_send_after"
        case authDate = "auth_date"
        case hash
    }
    
    enum ChatType: String, Decodable {
        case sender
        case `private` = "private"
        case group
        case superGroup = "supergroup"
        case channel
    }
    
    /// A unique identifier for the Mini App session, required for sending messages via the `answerWebAppQuery` method.
    let queryId: String?
    
    /// An object containing data about the current user.
    let user: TGWebAppUser?
    
    /// An object containing data about the chat partner of the current user in the chat where the bot was launched via the attachment menu.
    /// Returned only for private chats and only for Mini Apps launched via the attachment menu.
    let receiver: TGWebAppUser?
    
    /// An object containing data about the chat where the bot was launched via the attachment menu.
    /// Returned for supergroups, channels, and group chats – only for Mini Apps launched via the attachment menu.
    let chat: TGWebAppChat?
    
    /// Optional. Type of the chat from which the Mini App was opened. Can be either “sender” for a private chat with the user opening the link, “private”, “group”, “supergroup”, or “channel”.
    /// Returned only for Mini Apps launched from direct links.
    let chatType: ChatType?
    
    /// Global identifier, uniquely corresponding to the chat from which the Mini App was opened.
    /// Returned only for Mini Apps launched from a direct link.
    let chatInstance: String?
    
    /// The value of the `startattach` parameter, passed via link.
    /// Only returned for Mini Apps when launched from the attachment menu via link.
    let startParam: String?
    
    /// Time in seconds, after which a message can be sent via the `answerWebAppQuery` method.
    let canSendAfter: Int?
    
    /// Unix time when the form was opened.
    let authDate: Int
    
    /// A hash of all passed parameters, which the bot server can use to check their validity.
    let hash: String
    
    init(initData: String) throws(DecodingError) {
        guard let dictionary = Self.dictionaryFromInitData(initData: initData) else { throw DecodingError.invalidQuery }
        
        self.queryId = dictionary[CodingKeys.queryId.rawValue]
        
        let jsonDecoder = JSONDecoder()
        if let userQuery = dictionary[CodingKeys.user.rawValue]?.data(using: .utf8),
           let user = try? jsonDecoder.decode(TGWebAppUser.self, from: userQuery) {
            self.user = user
        } else {
            self.user = nil
        }
        
        if let receiverQuery = dictionary[CodingKeys.receiver.rawValue]?.data(using: .utf8),
           let receiver = try? jsonDecoder.decode(TGWebAppUser.self, from: receiverQuery) {
            self.receiver = receiver
        } else {
            self.receiver = nil
        }
        
        if let chatQuery = dictionary[CodingKeys.chat.rawValue]?.data(using: .utf8),
           let chat = try? jsonDecoder.decode(TGWebAppChat.self, from: chatQuery) {
            self.chat = chat
        } else {
            self.chat = nil
        }
        
        if let chatType = dictionary[CodingKeys.chatType.rawValue] {
            self.chatType = ChatType(rawValue: chatType)
        } else {
            self.chatType = nil
        }
        
        self.chatInstance = dictionary[CodingKeys.chatInstance.rawValue]
        self.startParam = dictionary[CodingKeys.chatInstance.rawValue]
        
        if let canSendAfter = dictionary[CodingKeys.canSendAfter.rawValue],
           let canSendAfterInt = Int(canSendAfter) {
            self.canSendAfter = canSendAfterInt
        } else {
            self.canSendAfter = nil
        }
        
        if let authDate = dictionary[CodingKeys.authDate.rawValue] {
            if let authDate = Int(authDate) {
                self.authDate = authDate
            } else {
                throw DecodingError.invalidValue(field: authDate, value: authDate)
            }
        } else {
            throw DecodingError.missingField(field: CodingKeys.authDate.rawValue)
        }
        
        if let hash = dictionary[CodingKeys.hash.rawValue] {
            self.hash = hash
        } else {
            throw DecodingError.missingField(field: CodingKeys.hash.rawValue)
        }
    }
    
    private static func dictionaryFromInitData(initData: String) -> [String: String]? {
        var components = URLComponents()
        components.percentEncodedQuery = initData
        
        // Convert query items to a dictionary
        guard let queryItems = components.queryItems else { return nil }
        
        var dictionary = [String: String]()
        for item in queryItems {
            if let value = item.value {
                dictionary[item.name] = value
            }
        }
        return dictionary
    }
}
