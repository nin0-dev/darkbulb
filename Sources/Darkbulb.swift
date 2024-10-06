import DDBKit
import DotEnv
import Foundation

@main
struct Darkbulb: DiscordBotApp {
  
  init() async {
    let httpClient = HTTPClient()
    do {
      let env = try DotEnv.read(path: "./.env")
      env.load()
      print("Loaded .env file")
    } catch {
      print("Failed to load .env file, things won't work!")
    }
    // Edit this as needed.
    bot = await BotGatewayManager(
      eventLoopGroup: httpClient.eventLoopGroup,
      httpClient: httpClient,
      token: ProcessInfo.processInfo.environment["BOT_TOKEN"]!,
      largeThreshold: 250,
      presence: .init(activities: [], status: .online, afk: false),
      intents: [.messageContent, .guildMessages]
    )
    cache = await .init(
      gatewayManager: bot,
      intents: .all, // it's better to minimise cached data to your needs
      requestAllMembers: .enabledWithPresences,
      messageCachingPolicy: .saveEditHistoryAndDeleted
    )
  }
  
  var body: [any BotScene] {
    ReadyEvent { ready in
      print("Logged in!")
    }
    Commands
  }

  var bot: Bot
  var cache: Cache
  var Commands: Group {
    Group {
      Command("info") { interaction, cmd, db in
        do {
          let applicationInfo = try await bot.client.getOwnApplication().decode()
          let _ = try await bot.client.createInteractionResponse(
            id: interaction.id,
            token: interaction.token,
            payload: .channelMessageWithSource(
              .init(embeds: [
                .init(
                  title: "Bot information",
                  description: """
                  This bot is an instance of **darkbulb**, a Discord bot written in [Swift](https://swift.org) using [DDBKit](https://github.com/llsc12/DDBKit).
                  You can find my code at [nin0-dev/darkbulb](https://github.com/nin0-dev/darkbulb).
                  > **⏲️ Uptime**: <t:\(String(Int(startTime))):R>
                  > **🛡️ Bot owner**: \(String(describing: applicationInfo.owner?.username)) <@\(String(describing: applicationInfo.owner?.id))>
                  > **📊 Guild count**: in \(String(applicationInfo.approximate_guild_count!)) guild\((applicationInfo.approximate_guild_count! != 1) ? "s" : "")
                  """,
                  color: Colors.info
                )
              ])
            )
          )
        }
        catch {}
      }
      .description("Get information about the bot")
      .integrationType(.all, contexts: .all)
    }
  }
}