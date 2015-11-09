//
///// Protocol for what handles interactions that can occur on a TweetView 
//protocol TweetViewInteractor {
//    var view: TweetView? { get set }
//
//    func likeTweet(tweet: Tweet, like: Bool)
//    func retweetTweet(tweet: Tweet, retweet: Bool)
//}
//
///// Protocol for a view that displays a list of tweets.
//protocol TweetView {
//    func reloadData()
//    func showConfirmationAlert(title: String, message: String, handler: (Void -> Void))
//}
//
//
///// Interactor for the TweetView when the user is logged in.
///// When the user wants to like a tweet or retweet, it updates the data model, and then tells the view to reload.
//struct TweetViewStandardInteractor: TweetViewInteractor {
//    var view: TweetView? = nil
//    let dataSource: ModelProvider
//
//    init(dataSource: ModelProvider) {
//        self.dataSource = dataSource
//    }
//
//    func likeTweet(tweet: Tweet, like: Bool) {
//        if like {
//            dataSource.likedTweets.insert(tweet)
//        } else {
//            dataSource.likedTweets.remove(tweet)
//        }
//        view?.reloadData()
//    }
//
//    func retweetTweet(tweet: Tweet, retweet: Bool) {
//        if retweet {
//            dataSource.retweetedTweets.insert(tweet)
//        } else {
//            dataSource.retweetedTweets.remove(tweet)
//        }
//        view?.reloadData()
//    }
//
//}
//
//
///// Interactor for the TweetView when there is no logged in user.
///// Alerts the user to log in before they can like tweets or retweet.
//struct TweetViewLoggedOutInteractor: TweetViewInteractor {
//    var view: TweetView? = nil
//    let loginController: LoginViewController
//
//    init(loginController: LoginViewController) {
//        self.loginController = loginController
//    }
//
//    func likeTweet(tweet: Tweet, like: Bool) {
//        view?.showConfirmationAlert("Please Login", message: "Cannot like a tweet without logging in!") {
//            self.loginController.dismissViewControllerAnimated(true, completion: nil)
//        }
//    }
//
//    func retweetTweet(tweet: Tweet, retweet: Bool) {
//        view?.showConfirmationAlert("Please Login", message: "Cannot retweet without logging in!") {
//            self.loginController.dismissViewControllerAnimated(true, completion: nil)
//        }
//        
//    }
//}