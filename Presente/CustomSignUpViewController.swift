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
    
    @IBOutlet var iAmLabel: UILabel!
    @IBOutlet var userRoleSegControl: UISegmentedControl!
    
    @IBOutlet var firstNameField: UITextField!
    @IBOutlet var lastNameField: UITextField!
    @IBOutlet var emailField: UITextField!
    @IBOutlet var passwordField: UITextField!
    @IBOutlet var confirmPasswordField: UITextField!
    
    @IBOutlet var signUpButton: UIButton!
    
    
    var actInd : UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(0, 0, 150, 150)) as UIActivityIndicatorView
    
    override func viewDidLoad() {
        // Initially set userRoleSegControl to 0 = "student"
        self.userRoleSegControl.selectedSegmentIndex = 0
        
        super.viewDidLoad()

        // Customization for the view
        let cornerRadiusVal: CGFloat = 5.0
        self.view.backgroundColor = UIColor(red: (52/255.0), green:(57/255.0), blue:(56/255.0), alpha: 1)
        
        iAmLabel.textColor = UIColor(red: (235/255.0), green:(231/255.0), blue:(221/255.0), alpha: 1)
        
        signUpButton.backgroundColor = UIColor(red: (30/255.0), green:(170/255.0), blue:(226/255.0), alpha: 1)
        signUpButton.layer.cornerRadius = cornerRadiusVal
        
        userRoleSegControl.layer.borderColor = UIColor(red: (235/255.0), green:(231/255.0), blue:(221/255.0), alpha: 1).CGColor
        userRoleSegControl.tintColor = UIColor(red: (30/255.0), green:(170/255.0), blue:(226/255.0), alpha: 1)
        
        passwordField.secureTextEntry = true
        confirmPasswordField.secureTextEntry = true
        
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
        
        var target:String = ""
        let firstname = self.firstNameField.text!
        let lastname = self.lastNameField.text!
        let username = self.emailField.text!
        let password = self.passwordField.text!
        let confirmPassword = self.confirmPasswordField.text!
        var role:String = ""
        
        // Set role variable by checking segmented control index
        if (userRoleSegControl.selectedSegmentIndex == 0) {
            role = "Student"
        }
        if (userRoleSegControl.selectedSegmentIndex == 1) {
            role = "Professor"
        }
        
        var errors:[String] = []
        
        // Validate that first name is not empty
        if (firstname == "") {
            errors += ["First name cannot be empty!"]
        }
        // Validate that last name is not empty
        if (lastname == "") {
            errors += ["Last name cannot be empty!"]
        }
        
        // Validate email using regex
        let emailvalidator = EmailValidation()
        var (result, errorType) = emailvalidator.validate(username)
        if (result == false) {
            errors += ["Email is not valid!"]
        }
        
        // Validate length and format of password
        // Validate that confirmPassword and password are equal
        if (confirmPassword == password) {
            let passwordvalidator = PasswordValidation()
            var (result, errorType) = passwordvalidator.validate(password)
            if (result == false) {
                errors += ["Password must be 8 characters and contain one uppercase!"]
            }
        }
        else {
            errors += ["Passwords do not match!"]
        }
        
        
        if (!errors.isEmpty) {
            var m = ""
            if errors.count >= 2
            {
                for index in 0...(errors.count-2)
                {
                    m += errors[index] + "\n"
                }
            }
            m += errors[errors.count-1]
            
            let alertController: UIAlertController = UIAlertController(title: m, message: "", preferredStyle: .Alert)
            let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
            alertController.addAction(defaultAction)
            
            presentViewController(alertController, animated: true, completion: nil)
        }
          
        // If validations are all OK, new User will be created
        else {
            
            self.actInd.startAnimating()
            
            let newUser = PFUser()
            
            newUser.username = username
            newUser.password = password
            newUser.setValue(lastname, forKey: "lastName")
            newUser.setValue(firstname, forKey: "firstName")
            newUser.setValue(role, forKey: "role")
            
            newUser.signUpInBackgroundWithBlock({ (succeed, error) -> Void in
                
                self.actInd.stopAnimating()
                
                if (target == "Student") {
                    let newStudent = PFObject(className: "Student")
                    newStudent.setValue(lastname, forKey: "lastName")
                    newStudent.setValue(firstname, forKey: "firstName")
                    newStudent.setObject(newUser, forKey: "userID")
            
                    newStudent.saveInBackgroundWithBlock({
                        (succeeded, error) -> Void in
                        if error == nil {
                            self.performSegueWithIdentifier("toClasses", sender: sender)
                            return;
                        }
                        else {
                            // Failed to create new Student!
                        }
                    })
                    return
                }
                    
                if (target == "Professor") {
                    let newProfessor = PFObject(className: "Professor")
                    newProfessor.setValue(lastname, forKey: "lastName")
                    newProfessor.setValue(firstname, forKey: "firstName")
                    newProfessor.setObject(newUser, forKey: "userID")
                    
                    newProfessor.saveInBackgroundWithBlock({
                        (succeeded, error) -> Void in
                        if error == nil {
                            self.performSegueWithIdentifier("toClasses", sender: sender)
                            return;
                        }
                        else {
                            // Failed to create new Professor!
                        }
                    })
                    return
                }
                
            })
            
        }
        
    }
}
