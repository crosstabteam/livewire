//
//  QuotaVC.swift
//  Livewire
//
//  Created by Adil Shaikh on 22/12/15.
//  Copyright © 2015 Adil Shaikh. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class QuotaVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tblQuota: UITableView!
    var projectID: String = ""
    var authKey: String = ""
    var quotaArray = [Quota]()
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        self.tabBarController?.navigationItem.title = "Quotas"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.tabBarController?.navigationItem.title = "Quotas"
        
        let projectTabBarVC: ProjectTabbedViewController = self.tabBarController as! ProjectTabbedViewController
        self.projectID = (projectTabBarVC.selectedProject?.id.uppercaseString)!
        let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        self.authKey = prefs.objectForKey("AUTHKEY") as! String
        
        let URL = "http://114.143.128.150/ios/api/FieldStatus/GetQuotaReport/?projectID=\(self.projectID)&authToken=\(self.authKey)"
        
        Alamofire.request(.GET, URL).responseString { response in
            print(response.request)  // original URL request
            print(response.response) // URL response
            print(response.data)     // server data
            print(response.result)   // result of response serialization
            
            
            self.quotaArray.removeAll()
            
            if let data = (response.result.value)!.dataUsingEncoding(NSUTF8StringEncoding) {
                let reportJSON = JSON(data: data)
                print(reportJSON)
                
                for item in reportJSON.arrayValue {
                    
                    var q = Quota(title: item["Title"].stringValue, subQuotas: [SubQuota]())
                    
                    for i in item["SubQuotas"].arrayValue{
                        var subQuota = SubQuota(subQuotaTitle: i["SubQuotaTitle"].stringValue, cells: [QuotaCell]())
                        
                        
                        for x in i["Cells"].arrayValue{
                            
                            subQuota.cells.append(QuotaCell(title: x["Title"].stringValue, target: x["Target"].stringValue, completes: x["Completes"].stringValue, remaining: x["Remaining"].stringValue, percentageAchieved: x["PercentageAchieved"].stringValue))
                        }
                        
                        q.subQuotas.append(subQuota)
                    }
                    
                    self.quotaArray.append(q)
                    

                }
                
                print("command completed successfully")
                print(self.quotaArray.count)
                
                self.tblQuota.reloadData()
            }
            
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        cell.textLabel?.text = self.quotaArray[indexPath.row].title
        //cell.detailTextLabel?.text = "sdf"

        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.quotaArray.count
    }
    

    // MARK: - UITableViewDelegate Methods
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "goto_first_level_quota" {
            if let destination = segue.destinationViewController as? QuotaFirstLevelVC {
                destination.subquotaArray = quotaArray[tblQuota.indexPathForSelectedRow!.row].subQuotas
            }
        }
    }

}
