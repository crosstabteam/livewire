//
//  FieldSummaryVC.swift
//  Livewire
//
//  Created by Adil Shaikh on 21/12/15.
//  Copyright © 2015 Adil Shaikh. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class FieldSummaryVC: UIViewController, UITableViewDataSource {

    //@IBOutlet weak var lblProjectID: UILabel!
    var fieldSummaryArray = [FieldStatus]()
    
    var projectID: String = ""
    @IBOutlet weak var tblFieldSummary: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
       
        self.tabBarController?.navigationItem.title = "Field Summary"
        
        let projectTabBarVC: ProjectTabbedViewController = self.tabBarController as! ProjectTabbedViewController
        self.projectID = (projectTabBarVC.selectedProject?.id)!
        
        Alamofire.request(.GET, "http://114.143.128.150/ios/api/FieldStatus/GetFieldSummary/?projectID=\(self.projectID)").responseString { response in
            //print(response.request)  // original URL request
            //print(response.response) // URL response
            //print(response.data)     // server data
            //print(response.result)   // result of response serialization
            
            
            self.fieldSummaryArray.removeAll()
            
            if let data = (response.result.value)!.dataUsingEncoding(NSUTF8StringEncoding) {
                let projects = JSON(data: data)
                print(projects)
                
                
                var p = FieldStatus(key: "Target Completes", value: projects["Target"].stringValue)
                self.fieldSummaryArray.append(p)
                
                p = FieldStatus(key: "Completes Achieved", value: projects["Completes"].stringValue)
                self.fieldSummaryArray.append(p)
                p = FieldStatus(key: "Screened", value: projects["Screened"].stringValue)
                self.fieldSummaryArray.append(p)
                p = FieldStatus(key: "QuotaFull", value: projects["QuotaFull"].stringValue)
                self.fieldSummaryArray.append(p)
                p = FieldStatus(key: "Incompletes", value: projects["Incompletes"].stringValue)
                self.fieldSummaryArray.append(p)
                p = FieldStatus(key: "Quality Outliers", value: projects["BadData"].stringValue)
                self.fieldSummaryArray.append(p)
                
                
                print("command completed successfully")
                print(self.fieldSummaryArray.count)
                
                self.tblFieldSummary.reloadData()
            }
            
            
        }


       
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        self.tabBarController?.navigationItem.title = "Field Summary"
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! FieldSummaryTableViewCell
        cell.lblKey?.text = fieldSummaryArray[indexPath.row].key
        cell.lblValue?.text = fieldSummaryArray[indexPath.row].value

        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.fieldSummaryArray.count
    }
    
    /*func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let  headerCell = tableView.dequeueReusableCellWithIdentifier("HeaderCell") as! HeaderTableViewCell
        headerCell.backgroundColor = UIColor.cyanColor()
        headerCell.lblHeader.text = "Europe";
        
        return headerCell
    }*/
    
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
