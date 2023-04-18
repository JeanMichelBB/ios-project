//
//  ViewController.swift
//  pokedex-ios
//
//  Created by Jean-Michel Beaulieu Bérubé on 2023-03-28.
//

import UIKit

class ViewController: UIViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private var loggedUser : User?
    
    @IBOutlet weak var txtLoginUsername: UITextField!
    
    @IBOutlet weak var txtLoginPassword: UITextField!
    
    @IBOutlet weak var imgBackground: UIImageView!
    
    @IBOutlet weak var btnLogin: UIButton!
    
    @IBOutlet weak var btnHidden: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideKeyboard)))
        NotificationCenter.default.addObserver(self, selector: #selector (keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector (keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func hideKeyboard(){
        self.view.endEditing(true)
    }
    
    @objc private func keyboardWillShow(notification: NSNotification){
        self.view.frame.origin.y = 0

        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue{
            let keyboardHeight = keyboardFrame.cgRectValue.height
            if let bottom = btnLogin {
                let bottomSpace = self.view.frame.height - (bottom.frame.origin.y + bottom.frame.height)
                self.view.frame.origin.y -= keyboardHeight - bottomSpace + 10
            }
        }
    }
    @objc private func keyboardWillHide(){
        self.view.frame.origin.y = 0
    }
    
    deinit{
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
     
        if identifier == Segue.toRegistrationViewController {
            return true
        }
        if identifier == Segue.toTableViewControllerHidden{
            return true
        }
        guard let username = txtLoginUsername.text, let password =
                txtLoginPassword.text else {
            Toast.ok(view: self, title: "Oups", message: "The username and password are required", handler: nil)
            return false
        }
        if let user = User.findByUsername(context: context, username: username) {
            if user.password == password {
                loggedUser = user
                return true
            } else {
                Toast.ok(view: self, title: "Oups", message: "The password is incorrect", handler: nil)
                return false
            }
        } else {
            Toast.ok(view: self, title: "Oups", message: "The username is incorrect", handler: nil)
            return false
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Segue.toTableViewController {
            let destination = segue.destination as! TableViewController
            destination.loggedUser = loggedUser
        }
    }
}
