import UIKit
import Hakuba

//class TweetViewController: UIViewController {
class TweetViewController: UIViewController, TweetView {

    // Model Data
    let dataSource: ModelProvider

    // View Management
    let tableView = UITableView(frame: CGRectZero, style: .Plain)
    var hakuba: Hakuba!

    var interactor: TweetViewInteractor

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.frame = view.bounds
        tableView.allowsSelection = false
        view.addSubview(tableView)

        hakuba = Hakuba(tableView: tableView)
        hakuba.registerNibForCellClass(TweetTableViewCell)

        reloadData()
    }

    func reloadData() {
        let tweets = dataSource.tweets.map(toTweetCellModel)
        hakuba[0].reset(tweets).slide()
    }

    func showConfirmationAlert(title: String, message: String, handler: (Void -> Void)) {
        confirm(self, title: title, message: message, handler: handler)
    }

    init(interactor: TweetViewInteractor, dataSource: ModelProvider) {
        self.interactor = interactor
        self.dataSource = dataSource
        super.init(nibName: nil, bundle: nil)
        self.interactor.view = self
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func toTweetCellModel(tweet: Tweet) -> TweetCellModel {
        weak var wself = self

        let liked = dataSource.likedTweets.contains(tweet)
        let retweeted = dataSource.retweetedTweets.contains(tweet)
        let model = TweetCellModel(tweet: tweet, retweeted: retweeted, liked: liked)
        model.didTapLike = { wself?.interactor.likeTweet(tweet, like: !liked) }
        model.didTapRetweet = { wself?.interactor.retweetTweet(tweet, retweet: !retweeted) }
        return model
    }

}
