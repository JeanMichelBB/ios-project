//
//  Toast.swift
//  DogAge
//
//  Created by Daniel Carvalho on 5/17/18.
//

import UIKit

class Toast: UIAlertController {
    
    static func show( view : ViewController, title : String, message : String, delay: Int) {
        
        let alert = UIAlertController(title:title, message:message, preferredStyle: .alert );
        
        view.present(alert, animated: true);
        
        let deadlineTime = DispatchTime.now() + .seconds(delay);
        
        DispatchQueue.main.asyncAfter(deadline: deadlineTime, execute: {
            alert.dismiss(animated: true, completion: nil);
        })
    }
    
    static func ok ( view : ViewController, title : String, message : String, handler: ((UIAlertAction) -> Void)? = nil ) {
 
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: handler))
        
        view.present(alert, animated: true)
    }
}
