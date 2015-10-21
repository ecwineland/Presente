//
//  CreateClassViewController.swift
//  Presente
//
//  Created by Evan Wineland on 10/15/15.
//  Copyright © 2015 Evan Wineland. All rights reserved.
//

import UIKit

class CreateClassViewController: UIViewController, ESTBeaconManagerDelegate {
    
    @IBOutlet var clssName: UITextField!
    @IBOutlet var clssNum: UITextField!
    @IBOutlet var clssDesc: UITextField!
    
    let beaconManager = ESTBeaconManager()
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func cancel(sender: AnyObject) {
        
        self.performSegueWithIdentifier("backToClasses", sender: self)
        
    }
    
    
    @IBAction func startMonitoring(sender: AnyObject) {
        
        appDelegate.startMonitoring()
        
    }
    
    @IBAction func stopMonitoring(sender: AnyObject) {
        
        appDelegate.stopMonitoring()
        
    }
    
    
    @IBAction func createClass(sender: AnyObject) {
        
        // Create error message if one or more fields is empty
        if (clssName.text!.isEmpty || clssNum.text!.isEmpty || clssDesc.text!.isEmpty ) {
            
            let alert = UIAlertView()
            alert.title = "Missing fields"
            alert.message = "Fill in all fields to create the new class"
            alert.addButtonWithTitle("Ok")
            alert.show()
            
        // Create new class
        } else {
            var newClass = PFObject(className: "Class")
            newClass.setObject(clssName.text!, forKey: "Name")
            newClass.setObject(clssNum.text!, forKey: "Num")
            newClass.setObject(clssDesc.text!, forKey: "Description")
            
            // Save newClass
            newClass.saveInBackgroundWithBlock({ (succeeded, error) -> Void in
                
                // Object created
                if succeeded {
                    
                    // Users :: Classes is a many to many, so create user_classes to resolve
                    let userClass = PFObject(className: "User_Class")
                    userClass.setObject(newClass, forKey: "Class")
                    userClass.setObject(PFUser.currentUser()!, forKey: "User")
                    
                    // Save userClass
                    userClass.saveInBackgroundWithBlock({ (succeeded, error) -> Void in
                        
                        if succeeded {
                            print("UserClass created for class: \(self.clssName.text!) and user \(PFUser.currentUser()!)")
                        
                        // Show error, if there is one
                        } else {
                            let alertController : UIAlertController = UIAlertController(title: "Error", message: "\(error)", preferredStyle: .Alert)
                            
                            let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                            alertController.addAction(defaultAction)
                            
                            self.presentViewController(alertController, animated: true, completion: nil)
                        }
                        
                    })
                    
                    print("Class created with name: \(self.clssName.text!)")
                    self.performSegueWithIdentifier("backToClasses", sender: self)
                
                // Create error message
                } else {
                    
                    let alertController : UIAlertController = UIAlertController(title: "Error", message: "\(error)", preferredStyle: .Alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.presentViewController(alertController, animated: true, completion: nil)
                    
                }
                
            })
        }
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
