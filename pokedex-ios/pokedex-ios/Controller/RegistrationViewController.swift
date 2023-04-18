//
//  RegistrationViewController.swift
//  pokedex-ios
//
//  Created by Jean-Michel Beaulieu Bérubé on 2023-04-02.
//

import UIKit
import CoreData

class RegistrationViewController: ViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    let localContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var pickerGenderData : [String] = []
    
    var selectedGender : String = ""

    @IBOutlet weak var txtUsername: UITextField!
    
    @IBOutlet weak var txtFullName: UITextField!
    
    @IBOutlet weak var txtFirstPassword: UITextField!
    
    @IBOutlet weak var txtSecondPassword: UITextField!
    
    @IBOutlet weak var switchPasswordVisibility: UISwitch!
    
    @IBOutlet weak var pickerGender: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.pickerGender.delegate = self
        self.pickerGender.dataSource = self
        
        pickerGenderData = ["Female", "Male", "Other", "Prefer not to say"]
        
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        navigationController?.navigationBar.standardAppearance = appearance
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideKeyboardRegistration)))
           NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShowRegistration(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
           NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHideRegistration), name: UIResponder.keyboardWillHideNotification, object: nil)
       }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerGenderData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerGenderData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.selectedGender = self.pickerGenderData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let title = pickerGenderData[row]
        let attributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.black]
        return NSAttributedString(string: title, attributes: attributes)
    }
    
    @objc private func hideKeyboardRegistration(){
        self.view.endEditing(true)
    }

    @objc private func keyboardWillShowRegistration(notification: NSNotification){
        self.view.frame.origin.y = 0

        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue{
            let keyboardHeight = keyboardFrame.cgRectValue.height
            if let bottom = pickerGender {
                let bottomSpace = self.view.frame.height - (bottom.frame.origin.y + bottom.frame.height)
                self.view.frame.origin.y -= keyboardHeight - bottomSpace + 10
            }
        }
    }

    @objc private func keyboardWillHideRegistration(){
        self.view.frame.origin.y = 0
    }

    deinit{
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @IBAction func btnPasswordVisibilityTouchUpInside(_ sender: Any) {
        txtFirstPassword.isSecureTextEntry.toggle()
        txtSecondPassword.isSecureTextEntry.toggle()
    }
    
    @IBAction func btnSignUpTouchUpInside(_ sender: Any) {

        guard let username = txtUsername.text, let fullName = txtFullName.text, let password = txtFirstPassword.text, let passwordCheck = txtSecondPassword.text else {
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
                action in self.txtFirstPassword.becomeFirstResponder()
            })
            txtFirstPassword.becomeFirstResponder()
            return
        }
        
        if password != passwordCheck {
            Toast.ok(view: self, title: "Oups", message: "Password do not match.", handler: {
                action in self.txtSecondPassword.becomeFirstResponder()
            })
            txtSecondPassword.becomeFirstResponder()
            return
        }
        
        if (User.findByUsername(context: localContext, username: username) != nil){
            Toast.ok(view: self, title: "Oups", message: "Sorry, this User you enter alredy exist.", handler: {
                action in self.txtFirstPassword.becomeFirstResponder()
            })
            txtFirstPassword.becomeFirstResponder()
            return
        }

        do
        {
            let newUser = User(context: context)
            newUser.username = username
            newUser.fullName = fullName
            newUser.password = password
            newUser.gender = self.selectedGender
            
            try context.save()
        }
        catch {
            print("Error saving context \(error)")
        }
        Toast.ok(view: self, title: "Success", message: "Your account has been created.", handler: {
            action in self.navigationController?.popViewController(animated: true)
        })
    }
}
