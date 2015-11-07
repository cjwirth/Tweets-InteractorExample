import UIKit
import Hakuba

class ViewController: UIViewController {

    let tableView = UITableView(frame: CGRectZero, style: .Plain)
    var hakuba: Hakuba!

    let dataSource = ModelProvider()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.frame = view.bounds
        view.addSubview(tableView)

        hakuba = Hakuba(tableView: tableView)
        hakuba.registerNibForCellClass(TweetTableViewCell)

        let tweets = dataSource.tweets.map(TweetCellModel.init)
        hakuba[0].append(tweets)
    }


}

