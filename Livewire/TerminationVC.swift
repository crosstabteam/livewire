//
//  TerminationVC.swift
//  Livewire
//
//  Created by Adil Shaikh on 22/12/15.
//  Copyright © 2015 Adil Shaikh. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class TerminationVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    //@IBOutlet weak var lblDummy: UILabel!
    @IBOutlet weak var tblTerminationReport: UITableView!
    
    var termVariableArray = [TermVariable]()
    var authKey: String = ""
    var projectID: String = ""
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        self.tabBarController?.navigationItem.title = "Terminates"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.tabBarController?.navigationItem.title = "Terminates"
        
        let projectTabBarVC: ProjectTabbedViewController = self.tabBarController as! ProjectTabbedViewController
        self.projectID = (projectTabBarVC.selectedProject?.id.uppercaseString)!
        let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        self.authKey = prefs.objectForKey("AUTHKEY") as! String
        
        let URL = "http://114.143.128.150/ios/api/FieldStatus/GetTerminationReport/?projectID=\(self.projectID)"

        Alamofire.request(.GET, URL).responseString { response in
            print(response.request)  // original URL request
            print(response.response) // URL response
            print(response.data)     // server data
            print(response.result)   // result of response serialization
            
            
            self.termVariableArray.removeAll()
            
            if let data = (response.result.value)!.dataUsingEncoding(NSUTF8StringEncoding) {
                let reportJSON = JSON(data: data)
                print(reportJSON)
                
                for item in reportJSON.arrayValue {
                    
                    
                    
                    print(item["Title"].stringValue)
                    
                    //var dict = Dictionary<String, Int>()
                    var dict = [String : Int]()
                    
                    for i in item["Splits"].arrayValue {
                        dict[i["SplitTitle"].stringValue] = Int(i["SplitCount"].stringValue)
                        print(i["SplitTitle"].stringValue)
                        print(i["SplitCount"].stringValue)
                    }
                    
                    let p = TermVariable(variable: item["Title"].stringValue, elements: dict)
                    self.termVariableArray.append(p)
                    
                    /*let p = Project(id: item["RO_ProjectId"].stringValue, projectName: item["ProjectName"].stringValue,
                        targetCompletes: item["TargetCompletes"].stringValue, qualifiedCompletes: item["Completes"].stringValue)
                    
                    self.termVariableArray.append(p)*/
                }
                
                print("command completed successfully")
                print(self.termVariableArray.count)
                
                self.tblTerminationReport.reloadData()
            }
            
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! TerminationTableViewCell
        cell.lblVariableName.text = termVariableArray[indexPath.row].variable
        cell.lblCounts.text = String(termVariableArray[indexPath.row].elements["Total"]!)
        //cell.textLabel?.text = termVariableArray[indexPath.row].variable
        
        /*let s: Int = termVariableArray[indexPath.row].elements["Total"]!
        print(s)
        cell.detailTextLabel?.text = String(s)*/
        
        if termVariableArray[indexPath.row].elements.count == 1 {
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            cell.userInteractionEnabled = false
            cell.accessoryType = UITableViewCellAccessoryType.None
        }

        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.termVariableArray.count
    }
    
    
    // MARK: - UITableViewDelegate Methods
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)

    }
    
   
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "termination_detail" {
            if let destination = segue.destinationViewController as? TerminationDetailVCViewController {
                destination.termVariable = termVariableArray[tblTerminationReport.indexPathForSelectedRow!.row]
            }
        }
    }

}
