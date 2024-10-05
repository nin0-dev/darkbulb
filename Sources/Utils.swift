import DDBKit
import Foundation

let startTime = Date().timeIntervalSince1970
struct Colors {
  static let info = DiscordColor(hex: "#35C0F3")
  static let success = DiscordColor(hex: "#7FFF91")
}

func reply(bot: GatewayManager, msg: Gateway.MessageCreate, payload: DiscordModels.Payloads.CreateMessage, mentionInReply: Bool = false) async throws {
  do {
    var updatedPayload = payload
    updatedPayload.message_reference = .init(
        message_id: msg.id, 
        channel_id: msg.channel_id, 
        guild_id: msg.guild_id, 
        fail_if_not_exists: false
    )
    if !mentionInReply {
      updatedPayload.allowed_mentions = .init(replied_user: false)
    }
    let _ = try await bot.client.createMessage(channelId: msg.channel_id, payload: updatedPayload)
  }
  catch {
    // :blobcatcozy:
  }
}