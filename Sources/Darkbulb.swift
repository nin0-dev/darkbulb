import DDBKit
import DDBKitUtilities
import DotEnv
import Foundation

@main
struct Darkbulb: DiscordBotApp {
  
  init() async {
    let httpClient = HTTPClient()
    startTime = Date().timeIntervalSince1970
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
    CoreCommands
    TextManipCommands
  }

  var bot: Bot
  var cache: Cache
  var CoreCommands: Group {
    Group {
      Command("info") { interaction, cmd, db in
        do {
          let applicationInfo: DiscordApplication = try await bot.client.getOwnApplication().decode()
          try? await bot.createInteractionResponse(to: interaction) {
            Message {
              MessageEmbed {
                Title("Bot information")
                Description {
                  Text(
                    """
                    This bot is an instance of **darkbulb**, a Discord bot written in [Swift](https://swift.org) using [DDBKit](https://github.com/llsc12/DDBKit).
                    You can find my code at [nin0-dev/darkbulb](https://github.com/nin0-dev/darkbulb).
                    > **⏲️ Uptime**: <t:\(String(Int(startTime))):R>
                    > **🛡️ Bot owner**: \(applicationInfo.owner?.username ?? "Unknown") (<@\(applicationInfo.owner?.id.rawValue ?? "Unknown")>)
                    > **📊 Guild count**: in \(String(applicationInfo.approximate_guild_count!)) guild\((applicationInfo.approximate_guild_count! != 1) ? "s" : "")
                    """
                  )
                }
              }
              .setColor(Colors.info!)
            }
          }
        }
        catch {}
      }
      .description("Get information about the bot")
      .integrationType(.all, contexts: .all)
    }
  }
}