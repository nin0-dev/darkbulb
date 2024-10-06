import DDBKit
import DDBKitUtilities
import Foundation

extension Darkbulb {
  var TextManipCommands: DDBKit.Group {
    Group {
      Command("goodperson") { i, cmd, dbreq in
      let result = goodpersonify(message: (try? cmd.requireOption(named: "message").value?.asString) ?? "❌ You didn't provide a message.")
        try? await bot.createInteractionResponse(to: i) {
          Message {
            MessageEmbed {
              Description {
                Text(result.0)
              }
              Footer("Replacements: \(result.1)")
            }
            .setColor(getRandomColor())
          }
        }
      }
      .description("Make a message be good")
      .integrationType(.all, contexts: .all)
      .addingOptions {
        StringOption(name: "message", description: "The message to make good")
          .required()
      }
    }
  }
}