//
//  QuotaFirstLevelVC.swift
//  Livewire
//
//  Created by Adil Shaikh on 16/01/16.
//  Copyright © 2016 Adil Shaikh. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class QuotaFirstLevelVC: UIViewController, UITableViewDataSource {
    
    var projectID: String = ""
    var authKey: String = ""
    var subquotaArray = [SubQuota]()
    
    @IBOutlet weak var tblQuotaFirstLevel: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.tabBarController?.navigationItem.title = "Quota Report"
        

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! QuotaFirstLevelTableViewCell
        cell.lblCellName.text = self.subquotaArray[indexPath.section].cells[indexPath.row].title
        cell.lblCompletes.text = self.subquotaArray[indexPath.section].cells[indexPath.row].completes
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return self.subquotaArray[0].cells.count

        return self.subquotaArray[section].cells.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.subquotaArray.count
    }
    
    func tableView( tableView : UITableView,  titleForHeaderInSection section: Int)->String? {
        
        return self.subquotaArray[section].subQuotaTitle

        
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
