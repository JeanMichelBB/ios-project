//
//  RegistrationViewController.swift
//  pokedex-ios
//
//  Created by Jean-Michel Beaulieu Bérubé on 2023-04-02.
//

import UIKit
import CoreData

class RegistrationViewController: ViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    @IBOutlet weak var txtUsername: UITextField!
    
    @IBOutlet weak var txtFullName: UITextField!
    
    @IBOutlet weak var txtPassword1: UITextField!
    
    @IBOutlet weak var txtPassword2: UITextField!
    
    @IBOutlet weak var switchPasswordVisibility: UISwitch!
    
    @IBAction func btnPasswordVisibilityTouchUpInside(_ sender: Any) {
        
        
        if (txtPassword1.isSecureTextEntry){
            //switchPasswordVisibility.
            txtPassword1.isSecureTextEntry.toggle()
            txtPassword2.isSecureTextEntry.toggle()
        }else{
            //switchPasswordVisibility.
            txtPassword1.isSecureTextEntry.toggle()
            txtPassword2.isSecureTextEntry.toggle()
        }
    //txtPassword1.isSecureTextEntry.toggle()
    //txtPassword2.isSecureTextEntry.toggle()
    }
    
    
    @IBAction func btnSignUpTouchUpInside(_ sender: Any) {
        
        guard let username = txtUsername.text, let fullName = txtFullName.text, let password = txtPassword1.text, let passwordCheck = txtPassword2.text else {
            Toast.ok(view: self, title: "Oups", message: "Something is wrong", handler: nil)
            return
        }
        if username.isEmpty {
            Toast.ok(view: self, title: "Oups", message: "Please, enter your username.", handler:  {
                action in self.txtUsername.becomeFirstResponder()
            })
            txtUsername.becomeFirstResponder()
            return
        }
        if fullName.isEmpty {
            Toast.ok(view: self, title: "Oups", message: "Please, enter your full name.", handler: {
                action in self.txtFullName.becomeFirstResponder()
            })
            txtFullName.becomeFirstResponder()
            return
        }
        if password.isEmpty {
            Toast.ok(view: self, title: "Oups", message: "Please, enter your password.", handler: {
                action in self.txtPassword1.becomeFirstResponder()
            })
            txtPassword1.becomeFirstResponder()
            return
        }
        if password != passwordCheck {
            Toast.ok(view: self, title: "Oups", message: "Password do not match.", handler: {
                action in self.txtPassword2.becomeFirstResponder()
            })
            txtPassword2.becomeFirstResponder()
            return
        }
        
        if (User.findByUsername(context: context, username: username) != nil){
            Toast.ok(view: self, title: "Oups", message: "Sorry, this User you enter alredy exist.", handler: {
                action in self.txtPassword1.becomeFirstResponder()
            })
            txtPassword1.becomeFirstResponder()
            return
        }

            let newUser = User(context: context)
        do
        {
            let newUser = User(context: context)
            newUser.username = username
            newUser.fullName = fullName
            newUser.password = password
            try context.save()
        }
        catch
        {
            print("Error saving context \(error)")
        }
        Toast.ok(view: self, title: "Success", message: "Your account has been created.", handler: {
            action in self.navigationController?.popViewController(animated: true)
        
        })
    }
    override func viewDidLoad() {
        super.viewDidLoad()

    }

}
