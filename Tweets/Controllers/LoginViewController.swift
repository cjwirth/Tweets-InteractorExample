import UIKit

class LoginViewController: UIViewController {

    private let models = ModelProvider()
    @IBOutlet var usernameInput: UITextField!

    @IBAction func loginButtonWasTapped() {
        let inputName = usernameInput.text ?? ""
        if let user = models.users[inputName] {
            models.currentUser = user

            let interactor = TweetViewStandardInteractor(dataSource: models)
            let controller = TweetViewController(interactor: interactor, dataSource: models)
            controller.title = "\(user.name)'s Feed"
            controller.navigationItem.leftBarButtonItem = BarButtonItem.create("Logout", handler: { _ in
                self.models.currentUser = nil
                self.navigationController?.popToRootViewControllerAnimated(true)
                self.navigationController?.setNavigationBarHidden(true, animated: true)
            })
            navigationController?.pushViewController(controller, animated: true)
            controller.navigationController?.setNavigationBarHidden(false, animated: true)

        } else {
            alert(self, title: "Could not login", message: "User does not exist.")
        }
    }

    @IBAction func previewButtonWasTapped() {
        let interactor = TweetViewLoggedOutInteractor(loginController: self)
        let controller = TweetViewController(interactor: interactor, dataSource: models)
        controller.title = "Preview"
        controller.navigationItem.leftBarButtonItem = BarButtonItem.create("Login", handler: { _ in
            self.dismissViewControllerAnimated(true, completion: nil)
        })

        let navControl = UINavigationController(rootViewController: controller)
        presentViewController(navControl, animated: true, completion: nil)
    }

}
