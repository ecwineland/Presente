//
//  ViewController.swift
//  Presente
//
//  Created by Evan Wineland on 10/8/15.
//  Copyright © 2015 Evan Wineland. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class ViewController: UIViewController, PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate {

    var logInViewController: PFLogInViewController = PFLogInViewController()
    var signUpViewController: PFSignUpViewController = PFSignUpViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
            
        if (PFUser.currentUser() == nil) {
            self.logInViewController.fields = [PFLogInFields.UsernameAndPassword, PFLogInFields.LogInButton, PFLogInFields.SignUpButton, PFLogInFields.PasswordForgotten, PFLogInFields.DismissButton]
            
            // Log In Logo
            let logoInTitle = UILabel()
            logoInTitle.text = "Presente"
            
            self.logInViewController.logInView?.logo = logoInTitle
            self.logInViewController.delegate = self
            
            // Sign Up Logo
            let signUpTitle = UILabel()
            signUpTitle.text = "Presente"
            
            self.signUpViewController.signUpView!.logo = signUpTitle
            self.signUpViewController.delegate = self
            
            self.logInViewController.signUpController = self.signUpViewController
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Parse Log In
    
    
    func logInViewController(logInController: PFLogInViewController, shouldBeginLogInWithUsername username: String, password: String) -> Bool {
        
        return (!username.isEmpty || !password.isEmpty) // Same as his code, right?
            
    }
    
    func logInViewController(logInController: PFLogInViewController, didLogInUser user: PFUser) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func logInViewController(logInController: PFLogInViewController, didFailToLogInWithError error: NSError?) {
        print("Failed to log in")
    }
    
    // MARK: Parse Sign Up
    func signUpViewController(signUpController: PFSignUpViewController, didSignUpUser user: PFUser) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func signUpViewController(signUpController: PFSignUpViewController, didFailToSignUpWithError error: NSError?) {
        print("Failed to sign up")
    }
    
    func signUpViewControllerDidCancelSignUp(signUpController: PFSignUpViewController) {
        print("User dismissed signup")
    }
    
    // Mark: Actions
    
    @IBAction func simpleAction(sender: AnyObject) {
        self.presentViewController(self.logInViewController, animated: true, completion: nil)
    }
    
    @IBAction func customAction(sender: AnyObject) {
        self.performSegueWithIdentifier("custom", sender: self)
    }
    
    @IBAction func logoutAction(sender: AnyObject) {
        PFUser.logOut()
    }
}

