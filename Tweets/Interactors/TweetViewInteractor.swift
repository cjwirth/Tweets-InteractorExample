
protocol TweetViewInteractor {
    var view: TweetView? { get set }

    func likeTweet(tweet: Tweet, like: Bool)
    func retweetTweet(tweet: Tweet, retweet: Bool)
}

protocol TweetView {
    func reloadData()
    func showConfirmationAlert(title: String, message: String, handler: (Void -> Void))
}

struct TweetViewStandardInteractor: TweetViewInteractor {
    var view: TweetView? = nil
    let dataSource: ModelProvider

    init(dataSource: ModelProvider) {
        self.dataSource = dataSource
    }

    func likeTweet(tweet: Tweet, like: Bool) {
        if like {
            dataSource.likedTweets.insert(tweet)
        } else {
            dataSource.likedTweets.remove(tweet)
        }
        view?.reloadData()
    }

    func retweetTweet(tweet: Tweet, retweet: Bool) {
        if retweet {
            dataSource.retweetedTweets.insert(tweet)
        } else {
            dataSource.retweetedTweets.remove(tweet)
        }
        view?.reloadData()
    }

}

struct TweetViewLoggedOutInteractor: TweetViewInteractor {
    var view: TweetView? = nil
    let loginController: LoginViewController

    init(loginController: LoginViewController) {
        self.loginController = loginController
    }

    func likeTweet(tweet: Tweet, like: Bool) {
        view?.showConfirmationAlert("Please Login", message: "Cannot like a tweet without logging in!") {
            self.loginController.dismissViewControllerAnimated(true, completion: nil)
        }
    }

    func retweetTweet(tweet: Tweet, retweet: Bool) {
        view?.showConfirmationAlert("Please Login", message: "Cannot retweet without logging in!") {
            self.loginController.dismissViewControllerAnimated(true, completion: nil)
        }
        
    }
}