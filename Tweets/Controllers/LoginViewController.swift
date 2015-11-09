import UIKit

class LoginViewController: UIViewController {

    private let models = ModelProvider()
    @IBOutlet var usernameInput: UITextField!

    @IBAction func loginButtonWasTapped() {
        let inputName = usernameInput.text ?? ""
        if let user = models.users[inputName] {
            NSLog("Welcome back, \(user.name)")
        } else {
            alert(self, title: "Could not login", message: "User does not exist.")
        }
    }

    @IBAction func previewButtonWasTapped() {
        let controller = TweetViewController()
        controller.title = "Preview"
        controller.navigationItem.leftBarButtonItem = BarButtonItem.create("Login", handler: { _ in
            self.dismissViewControllerAnimated(true, completion: nil)
        })

        let navControl = UINavigationController(rootViewController: controller)
        presentViewController(navControl, animated: true, completion: nil)
    }


}
