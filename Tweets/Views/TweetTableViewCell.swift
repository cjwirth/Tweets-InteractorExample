import UIKit
import Hakuba

class TweetCellModel: MYCellModel {
    let name: String
    let message: String
    let image: UIImage
    let retweeted: Bool
    let liked: Bool

    var didTapRetweet: (Void -> Void)?
    var didTapLike: (Void -> Void)?

    init(tweet: Tweet, retweeted: Bool = false, liked: Bool = false) {
        name = tweet.author.name
        message = tweet.message
        image = tweet.author.image
        self.retweeted = retweeted
        self.liked = liked
        super.init(cell: TweetTableViewCell.self, height: 100)
    }
}

class TweetTableViewCell: MYTableViewCell {

    @IBOutlet var iconView: UIImageView!
    @IBOutlet var usernameLabel: UILabel!
    @IBOutlet var messageLabel: UILabel!
    @IBOutlet var retweetButton: UIButton!
    @IBOutlet var likeButton: UIButton!

    var didTapRetweet: (Void -> Void)?
    var didTapLike: (Void -> Void)?

    override func configureCell(cellModel: MYCellModel) {
        super.configureCell(cellModel)
        guard let model = cellModel as? TweetCellModel else {
            return
        }
        let retweetImage = model.retweeted ? UIImage(named: "retweet-on")! : UIImage(named: "retweet")!
        let likeImage = model.liked ? UIImage(named: "like-on")! : UIImage(named: "like")!

        iconView.image = model.image
        usernameLabel.text = model.name
        messageLabel.text = model.message
        retweetButton.setImage(retweetImage, forState: .Normal)
        likeButton.setImage(likeImage, forState: .Normal)
        didTapRetweet = model.didTapRetweet
        didTapLike = model.didTapLike
    }

    @IBAction func retweetButtonTapped() {
        didTapRetweet?()
    }

    @IBAction func likeButtonTapped() {
        didTapLike?()
    }
}
