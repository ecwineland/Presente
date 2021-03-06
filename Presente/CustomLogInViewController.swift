
//
//  CustomLogInViewController.swift
//  Presente
//
//  Created by Evan Wineland on 10/13/15.
//  Copyright © 2015 Evan Wineland. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class CustomLogInViewController: UIViewController {

    @IBOutlet var loginTitle: UILabel!
    @IBOutlet var usernameField: UITextField!
    @IBOutlet var passwordField: UITextField!
    
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var signUpButton: UIButton!
    
    var actInd : UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(0, 0, 150, 150)) as UIActivityIndicatorView
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Customization for the view
        let cornerRadiusVal: CGFloat = 5.0
        self.view.backgroundColor = UIColor(red: (52/255.0), green:(57/255.0), blue:(56/255.0), alpha: 1)
        
        loginTitle.textColor = UIColor(red: (235/255.0), green:(231/255.0), blue:(221/255.0), alpha: 1)
        
        loginButton.backgroundColor = UIColor(red: (30/255.0), green:(170/255.0), blue:(226/255.0), alpha: 1)
        loginButton.layer.cornerRadius = cornerRadiusVal
        
        signUpButton.backgroundColor = UIColor.clearColor()
        signUpButton.layer.borderWidth = 1.0
        signUpButton.layer.borderColor = UIColor(red: (255/255.0), green:(206/255.0), blue:(52/255.0), alpha: 1).CGColor
        signUpButton.layer.cornerRadius = cornerRadiusVal
        
        passwordField.secureTextEntry = true
        
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
    
    @IBAction func logInAction(sender: AnyObject) {
        
        let username = self.usernameField.text!
        let password = self.passwordField.text!
        
        // Check for minimum username and password length
        if (username.characters.count < 4 || password.characters.count < 5) {
            let alertController : UIAlertController = UIAlertController(title: "Invalid", message: "Username and password must have at least 4, 5 characters respectively", preferredStyle: .Alert)
            let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
            alertController.addAction(defaultAction)
            
            presentViewController(alertController, animated: true, completion: nil)
            
        } else { //
            
            self.actInd.startAnimating()
            
            PFUser.logInWithUsernameInBackground(username, password: password, block: { (user, error) -> Void in
                
                self.actInd.stopAnimating()
                
                // Login success or denial logic
                if (user != nil) {
                    // Log in success
                    dispatch_async(dispatch_get_main_queue()){
//                        self.presentViewController(alertController, animated: true, completion: nil) // NOTE: self recommended by Xcode
                        
                        // Create user dashboard view controller
                        var classesController = self.storyboard!.instantiateViewControllerWithIdentifier("Classes")
                        
                        // Send to classes dashboard
//                        self.presentViewController(classesController, animated: true, completion: nil)
                        self.performSegueWithIdentifier("toClasses", sender: self)
                    }
                } else {
                    // Log in failure
                    let alertController : UIAlertController = UIAlertController(title: "Error", message: "\(error)", preferredStyle: .Alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.presentViewController(alertController, animated: true, completion: nil) // NOTE: self recommended by Xcode
                }
                
            })
            
        }
        
    }

    @IBAction func signUpAction(sender: AnyObject) {
        self.performSegueWithIdentifier("signup", sender: self)
    }
    
//    @IBAction func signInAction(sender: AnyObject) {
//        self.performSegueWithIdentifier("loggedIn", sender: nil) // TODO: Add custom identifier
//    }
}
