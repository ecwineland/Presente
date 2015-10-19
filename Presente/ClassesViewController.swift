//
//  UserDashboardViewController.swift
//  Presente
//
//  Created by Evan Wineland on 10/14/15.
//  Copyright © 2015 Evan Wineland. All rights reserved.
//

import UIKit
import Parse

class ClassesViewController: UITableViewController {
    
    @IBOutlet var nameLabel: UILabel!
    
    var user = PFUser() // User for whom info is displayed

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor(red: (52/255.0), green:(57/255.0), blue:(56/255.0), alpha: 1)
        print(user.username)
        nameLabel.text = self.user.username
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

}
