import UIKit

public struct User: Hashable, Equatable {
    let name: String
    var image: UIImage { return UIImage(named: self.name)! }

    public var hashValue: Int { return name.hashValue }
}

public struct Tweet: Hashable, Equatable {
    let id = NSUUID().UUIDString
    let author: User
    let message: String

    public var hashValue: Int { return id.hashValue }
}

public func ==(lhs: Tweet, rhs: Tweet) -> Bool {
    return lhs.author == rhs.author && lhs.message == rhs.message
}

public func ==(lhs: User, rhs: User) -> Bool {
    return lhs.name == rhs.name
}