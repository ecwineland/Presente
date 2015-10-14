
//
//  CustomLogInViewController.swift
//  Presente
//
//  Created by Evan Wineland on 10/13/15.
//  Copyright © 2015 Evan Wineland. All rights reserved.
//

import UIKit

class CustomLogInViewController: UIViewController {

    @IBOutlet var usernameField: UITextField!
    @IBOutlet var passwordField: UITextField!
    
    var actInd : UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(0, 0, 150, 150)) as UIActivityIndicatorView
    
    
    override func viewDidLoad() {
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
    
    @IBAction func logInAction(sender: AnyObject) {
        
        var username = self.usernameField.text!
        var password = self.passwordField.text!
        
        // Check for minimum username and password length
        if (username.characters.count < 4 || password.characters.count < 5) {
            let alert : UIAlertController = UIAlertController(title: "Invalid", message: "Username and password must have at least 4, 5 characters respectively", preferredStyle: .Alert)
            let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
            presentViewController(alert, animated: true, completion: nil)
            
        }
        
    }

    @IBAction func signUpAction(sender: AnyObject) {
        self.performSegueWithIdentifier("signup", sender: self)
    }
}
