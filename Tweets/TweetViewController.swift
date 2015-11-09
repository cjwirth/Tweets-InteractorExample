import UIKit
import Hakuba

class TweetViewController: UIViewController {

    // Model Data
    let dataSource: ModelProvider

    // View Management
    let tableView = UITableView(frame: CGRectZero, style: .Plain)
    var hakuba: Hakuba!

    init(dataSource: ModelProvider) {
        self.dataSource = dataSource
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.frame = view.bounds
        tableView.allowsSelection = false
        view.addSubview(tableView)

        hakuba = Hakuba(tableView: tableView)
        hakuba.registerNibForCellClass(TweetTableViewCell)

        reloadData()
    }

    // MARK: Table View Management

    func reloadData() {
        let tweets = dataSource.tweets.map(toTweetCellModel)
        hakuba[0].reset(tweets).slide()
    }


    private func toTweetCellModel(tweet: Tweet) -> TweetCellModel {
        weak var wself = self

        let liked = dataSource.likedTweets.contains(tweet)
        let retweeted = dataSource.retweetedTweets.contains(tweet)
        let model = TweetCellModel(tweet: tweet, retweeted: retweeted, liked: liked)
        model.didTapLike = {
            if wself?.dataSource.currentUser == nil {
                wself?.showConfirmationAlert("Please Login", message: "Cannot like a tweet without logging in!", handler: {
                    wself?.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
                })
            } else {
                if liked {
                    wself?.dataSource.likedTweets.remove(tweet)
                } else {
                    wself?.dataSource.likedTweets.insert(tweet)
                }
                wself?.reloadData()
            }
        }
        model.didTapRetweet = {
            if wself?.dataSource.currentUser == nil {
                wself?.showConfirmationAlert("Please Login", message: "Cannot retweet without logging in!", handler: {
                    wself?.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
                })
            } else {
                if retweeted {
                    wself?.dataSource.retweetedTweets.remove(tweet)
                } else {
                    wself?.dataSource.retweetedTweets.insert(tweet)
                }
                wself?.reloadData()
            }
        }
        return model
    }

    // MARK: View Presentation

    func showConfirmationAlert(title: String, message: String, handler: (Void -> Void)) {
        confirm(self, title: title, message: message, handler: handler)
    }

}
