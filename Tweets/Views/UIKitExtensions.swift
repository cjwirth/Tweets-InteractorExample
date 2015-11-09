import UIKit

func alert(vc: UIViewController, title: String?, message: String?) -> UIAlertController {
    let controller = UIAlertController(title: title, message: message, preferredStyle: .Alert)
    controller.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
    vc.presentViewController(controller, animated: true, completion: nil)
    return controller
}

func confirm(vc: UIViewController, title: String?, message: String?, handler: (Void -> Void)) -> UIAlertController {
    let controller = UIAlertController(title: title, message: message, preferredStyle: .Alert)
    controller.addAction(UIAlertAction(title: "OK", style: .Default, handler: { _ in handler() }))
    controller.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
    vc.presentViewController(controller, animated: true, completion: nil)
    return controller
}

class BarButtonItem: UIBarButtonItem {
    var tapHandler: (BarButtonItem -> Void)?

    class func create(title: String, handler: (BarButtonItem -> Void)) -> BarButtonItem {
        let button = BarButtonItem(title: title, style: .Done, target: nil, action: nil)
        button.target = button
        button.action = Selector("wasTapped")
        button.tapHandler = handler
        return button
    }

    func wasTapped() {
        tapHandler?(self)
    }
}

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }

    convenience init(hex:Int) {
        self.init(red:(hex >> 16) & 0xff, green:(hex >> 8) & 0xff, blue:hex & 0xff)
    }
}

extension UIColor {
    class func twitterBlue() -> UIColor { return UIColor(hex: 0x4099FF) }
}
