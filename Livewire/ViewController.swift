//
//  ViewController.swift
//  Livewire
//
//  Created by Adil Shaikh on 19/12/15.
//  Copyright © 2015 Adil Shaikh. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import UIColor_Hex_Swift

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var projectsArray = [Project]()
    var authKey: String = ""

    @IBOutlet weak var projectTableView: UITableView!
    
    var indicator = UIActivityIndicatorView()
    
    func activityIndicator(){
        indicator = UIActivityIndicatorView(frame: CGRectMake(0, 0, 40, 40))
        indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        indicator.center = self.view.center
        self.view.addSubview(indicator)
        
    }
    
    @IBAction func logout(sender: AnyObject) {
        
        let refreshAlert = UIAlertController(title: "Logout", message: "Are you sure you wish to sign out?", preferredStyle: UIAlertControllerStyle.Alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Yes", style: .Default, handler: { (action: UIAlertAction!) in
            //println("Handle Ok logic here")
            let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
            prefs.removeObjectForKey("ISLOGGEDIN")
            prefs.removeObjectForKey("AUTHKEY")
            prefs.removeObjectForKey("USERNAME")
            
            
            self.projectsArray.removeAll()
            self.projectTableView.reloadData()
            
            
            self.performSegueWithIdentifier("goto_login", sender: self)
        }))
        
        refreshAlert.addAction(UIAlertAction(title: "No", style: .Default, handler: { (action: UIAlertAction!) in
            //println("Handle Cancel Logic here")
            //do nothing
        }))
        
        presentViewController(refreshAlert, animated: true, completion: nil)
        
        

    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        
        self.viewDidLoad()
    }
    
    
    override func viewDidLoad() {

        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
      
        self.navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationController?.navigationBar.barTintColor = UIColor(rgba: "#1FAE66")
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()

        
        let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        let isLoggedIn:Int = prefs.integerForKey("ISLOGGEDIN") as Int
        if (isLoggedIn != 1) {
            self.performSegueWithIdentifier("goto_login", sender: self)
        } else {
            self.authKey = prefs.objectForKey("AUTHKEY") as! String
            
            //start please wait animation
            indicator.startAnimating()
            indicator.backgroundColor = UIColor.whiteColor()
            
            Alamofire.request(.GET,  "http://114.143.128.150/ROService/ROService.svc/ListAllProject/\(self.authKey)").responseString { response in
                print(response.request)  // original URL request
                print(response.response) // URL response
                print(response.data)     // server data
                print(response.result)   // result of response serialization
                
                
                self.projectsArray.removeAll()
                
                if let data = (response.result.value)!.dataUsingEncoding(NSUTF8StringEncoding) {
                    let projects = JSON(data: data)
                    //print(json)
                    
                    for item in projects["AllProjects"].arrayValue {
                        print(item["ProjectName"].stringValue)
                        
                        let p = Project(id: item["RO_ProjectId"].stringValue, projectName: item["ProjectName"].stringValue.uppercaseString,
                            targetCompletes: item["TargetCompletes"].stringValue, qualifiedCompletes: item["Completes"].stringValue)
                        
                        self.projectsArray.append(p)
                        print(item)
                    }
                    
                    print("command completed successfully")
                    print(self.projectsArray.count)
                    
                    self.projectTableView.reloadData()
                    
                    //stop please wait animation
                    self.indicator.stopAnimating()
                    self.indicator.hidesWhenStopped = true
                }
                
                
            }
        }
        

    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! ProjectTableViewCell
        cell.lblProjectName?.text = projectsArray[indexPath.row].projectName
        cell.lblCompletesInfo?.text = "Completes Achieved: \(projectsArray[indexPath.row].qualifiedCompletes) / \(projectsArray[indexPath.row].targetCompletes)"
        cell.imgFieldStatus.image =  UIImage(named: "green_dot")
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.projectsArray.count
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let tabBar : ProjectTabbedViewController = self.storyboard?.instantiateViewControllerWithIdentifier("ProjectTabbedViewController") as! ProjectTabbedViewController
        tabBar.selectedProject = projectsArray[indexPath.row]
        self.navigationController!.pushViewController(tabBar, animated: true)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

