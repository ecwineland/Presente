//
//  CreateClassViewController.swift
//  Presente
//
//  Created by Evan Wineland on 10/15/15.
//  Copyright © 2015 Evan Wineland. All rights reserved.
//

import UIKit

class CreateClassViewController: UIViewController {
    
    @IBOutlet var clssName: UITextField!
    @IBOutlet var clssNum: UITextField!
    @IBOutlet var clssDesc: UITextField!
    

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
            
            // To distinguish between classes made by different users
//            newClass.setValue(<#T##value: AnyObject?##AnyObject?#>, forKey: <#T##String#>)
            
            newClass.saveInBackgroundWithBlock({ (succeed, error) -> Void in
                
                // Object created
                if succeed {
                 
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
