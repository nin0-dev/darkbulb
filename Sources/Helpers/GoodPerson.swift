import Foundation

let badNouns = ["cunt", "yuri", "whore", "dick", "pussy", "slut", "tit", "cum", "cock", "blowjob", "sex", "ass", "furry", "bewbs", "boob", "booba", "boobies", "boobs", "booby", "porn", "pron", "pronhub", "r34", "rape", "raped", "raping", "rapist", "mewing", "mew", "skibidi", "gyat", "gyatt", "rizzler", "nettspend", "boykisser", "ohio", "rizz", "tickle my toes bruh", "crack my spine like a whip", "hawk tuah", "retard", "faggot", "fag", "faggots", "fags", "retards", "n*g", "n*gg*", "n*gg*r", "shit", "bullshit", "bitch", "bastard", "die", "brainless", "kotlin", "avast"];
let badNounsReplacements = ["pasta", "kebab", "cake", "potato", "woman", "computer", "java", "hamburger", "monster truck", "osu!", "Ukrainian ball in search of gas game", "Anime", "Anime girl", "good", "keyboard", "NVIDIA RTX 3090 Graphics Card", "storm", "queen", "single", "umbrella", "mosque", "physics", "bath", "virus", "bathroom", "mom", "owner", "airport", "Avast Antivirus Free"]
let badVerbs = ["fuck", "cum", "kill", "destroy"]
let badVerbsReplacements = ["love", "eat", "deconstruct", "marry", "fart", "teach", "display", "plug", "explode", "undress", "finish", "freeze", "beat", "free", "brush", "allocate", "date", "melt", "breed", "educate", "injure", "change"];

func goodpersonify(message: String) -> (String, Int) {
    var fixedMessage = message
    var replacementsCount = 0

    for badNoun in badNouns {
        while let range = fixedMessage.range(of: badNoun) {
            let replacement = badNounsReplacements.randomElement()!
            fixedMessage.replaceSubrange(range, with: replacement)
            replacementsCount += 1
        }
    }

    for badVerb in badVerbs {
        while let range = fixedMessage.range(of: badVerb) {
            let replacement = badVerbsReplacements.randomElement()!
            fixedMessage.replaceSubrange(range, with: replacement)
            replacementsCount += 1
        }
    }

    return (fixedMessage, replacementsCount)
}