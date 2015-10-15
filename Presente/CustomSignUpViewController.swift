//
//  CustomSignUpViewController.swift
//  Presente
//
//  Created by Evan Wineland on 10/13/15.
//  Copyright © 2015 Evan Wineland. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class CustomSignUpViewController: UIViewController {

    @IBOutlet var emailField: UITextField!
    @IBOutlet var usernameField: UITextField!
    @IBOutlet var passwordField: UITextField!
    
    var actInd : UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(0, 0, 150, 150)) as UIActivityIndicatorView
    
    override func viewDidLoad() {
        super.viewDidLoad()

        super.viewDidLoad()
        
        self.actInd.center = self.view.center
        self.actInd.hidesWhenStopped = true
        self.actInd.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        
        view.addSubview(self.actInd)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: Actions

    @IBAction func signUpAction(sender: AnyObject) {
        
        let username = self.usernameField.text!
        let password = self.passwordField.text!
        let email = self.emailField.text!
        
        // Check for minimum username and password length
        if (username.characters.count < 4 || password.characters.count < 5) {
            let alertController : UIAlertController = UIAlertController(title: "Invalid", message: "Username and password must have at least 4, 5 characters respectively", preferredStyle: .Alert)
            let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
            alertController.addAction(defaultAction)
            
            presentViewController(alertController, animated: true, completion: nil)
        
        // Check for minimum email length
        } else if (email.characters.count < 8) {
            
            let alertController : UIAlertController = UIAlertController(title: "Invalid", message: "Surely your email must be longer than that!", preferredStyle: .Alert) // Figure out a real error message later
            let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
            alertController.addAction(defaultAction)
            
            presentViewController(alertController, animated: true, completion: nil)
        
        // User will be created
        } else {
            
            self.actInd.startAnimating()
            
            let newUser = PFUser()
            
            newUser.username = username
            newUser.password = password
            newUser.email = email
            
            newUser.signUpInBackgroundWithBlock({ (succeed, error) -> Void in
                
                self.actInd.stopAnimating()
                
                // If error returned
                if (error != nil) {
                    
                    let alertController : UIAlertController = UIAlertController(title: "Error", message: "\(error)", preferredStyle: .Alert) // TODO: Is this how to interpolate the error message?
                    let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.presentViewController(alertController, animated: true, completion: nil)
                    
                // Sign in is successful
                } else {
                    // Signed in alert
                    let alertController : UIAlertController = UIAlertController(title: "Signed Up", message: "User created", preferredStyle: .Alert) 
                    let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                    alertController.addAction(defaultAction)
                    
                }
                
            })
            
        }
        
    }
}
