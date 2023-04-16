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
    
    @IBOutlet weak var txtLogUsername: UITextField!
    
    @IBOutlet weak var txtLogPassword: UITextField!
    
    @IBOutlet weak var imgBackground: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        if identifier == Segue.toRegistrationViewController {
            return true
        }
        guard let username = txtLogUsername.text, let password =
                txtLogPassword.text else {
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
