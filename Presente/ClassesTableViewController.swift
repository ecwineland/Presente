//
//  ClassesTableViewController.swift
//  
//
//  Created by Evan Wineland on 10/19/15.
//
//

import UIKit
import Parse

class ClassesTableViewController: UITableViewController {
    
    let currentUser = PFUser.currentUser()
    var classes : [PFObject] = []
    
    override func viewWillAppear(animated: Bool) {
        classes = getClasses()
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Don't display "back" button after segue
        self.navigationItem.hidesBackButton = true

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return classes.count
    }
    
    // Retrieves all classes that have been made by this user
    // Borrows from Siddarth's code for Present, following conversation on how extract for list in tableview
    func getClasses() -> [PFObject] {
        var allClasses : [PFObject] = []
        
        // All userClass objects made
        let allUserClasses = PFQuery(className: "User_Class") // className given to all objects
        
        // All userClass objects made by this user
        allUserClasses.whereKey("User", equalTo: currentUser!)
        
        
        // Get all classes from these userClass objects
        var userClasses : [PFObject] = []
        
        // Convert to array of PFObjects
        do {
            userClasses = try allUserClasses.findObjects() as [PFObject]
        } catch _ {
            userClasses = []
        }
        
        // Extract each class from userClass object
        for userClass in userClasses {
            
            let classObj = userClass["Class"]!.objectId
            var clssQuery = PFQuery(className: "Class")
            
            // Get object we want
            do {
                let clss = try clssQuery.getObjectWithId(classObj!!)
                allClasses.append(clss)
            } catch _ {
                let clss = "I give up"
            }
        }
        
        return allClasses
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ClassesTableViewCell", forIndexPath: indexPath) as! ClassesTableViewCell
        
        let currClass = classes[indexPath.row]
        let currClassName = currClass["Name"] as! String
        let currClassNum = currClass["Num"] as! String
        
        cell.textLabel?.text = currClassNum
        cell.detailTextLabel?.text = currClassName
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        // Get the new view controller using segue.destinationViewController.
//        // Pass the selected object to the new view controller.
//        if (segue.identifier == "toClassDatesView") {
//            let vc = segue.destinationViewController as! ClassDatesTableViewController
//            
//            let currClass = classes[indexPath.row]
//            let currClassNum = currClass["Num"] as! String
//            vc.classNum =
//        }
//    }


}
