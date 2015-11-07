import UIKit

private func getJSON(filename: String) -> AnyObject {
    let url = NSBundle.mainBundle().URLForResource(filename, withExtension: "json")!
    let data = NSData(contentsOfURL: url)!
    let json = try! NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions(rawValue: 0))
    return json
}

private func loadTweets() -> [Tweet] {
    let json = getJSON("tweets") as! [[String: String]]
    return json.map(tweetFromJSON)
}

private func tweetFromJSON(json: [String: String]) -> Tweet {
    let user = User(name: json["author"]!)
    let tweet = Tweet(author: user, message: json["message"]!)
    return tweet
}

class ModelProvider {
    let users: [String: User]
    let tweets: [Tweet]

    init() {
        let loadedTweets = loadTweets()
        var loadedUsers = [String: User]()
        loadedTweets.forEach { tweet in
            loadedUsers[tweet.author.name] = tweet.author
        }
        tweets = loadedTweets
        users = loadedUsers
    }

}
