import UIKit

struct User {
    let name: String
    var image: UIImage { return UIImage(named: self.name)! }
}

struct Tweet {
    let author: User
    let message: String
}