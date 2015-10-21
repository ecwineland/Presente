//
//  ClassSessionViewController.swift
//  Presente
//
//  Created by Jenny Yang on 10/21/15.
//  Copyright © 2015 Evan Wineland. All rights reserved.
//

import UIKit

class ClassSessionViewController: UIViewController {

    @IBOutlet var presentButton: UIButton!
    @IBOutlet var absentButton: UIButton!
    
    @IBOutlet weak var circleGraph: CircleGraphView!
    @IBOutlet weak var numStudentsLabel: UILabel!
    @IBOutlet weak var numTextLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Customization for the view
        let cornerRadiusVal: CGFloat = 5.0
        self.view.backgroundColor = UIColor(red: (52/255.0), green:(57/255.0), blue:(56/255.0), alpha: 1)
        
        presentButton.backgroundColor = UIColor(red: (114/255.0), green:(191/255.0), blue:(91/255.0), alpha: 1)
        presentButton.layer.cornerRadius = cornerRadiusVal
        absentButton.backgroundColor = UIColor(red: (255/255.0), green:(206/255.0), blue:(52/255.0), alpha: 1)
        absentButton.layer.cornerRadius = cornerRadiusVal
        
        // Customization for the circle graph view
        circleGraph.endArc = 0.15
        circleGraph.arcWidth = 10.0
        let backgroundTrackColor = UIColor(red: (114/255.0), green:(191/255.0), blue:(91/255.0), alpha: 1)
        circleGraph.arcBackgroundColor = backgroundTrackColor
        circleGraph.backgroundColor = UIColor(red: (52/255.0), green:(57/255.0), blue:(56/255.0), alpha: 1)
        
        numStudentsLabel.textColor = UIColor(red: (235/255.0), green:(231/255.0), blue:(221/255.0), alpha: 1)
        numTextLabel.textColor = UIColor(red: (235/255.0), green:(231/255.0), blue:(221/255.0), alpha: 1)
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
