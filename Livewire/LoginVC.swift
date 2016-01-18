//
//  LoginVC.swift
//  Livewire
//
//  Created by Adil Shaikh on 22/12/15.
//  Copyright © 2015 Adil Shaikh. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class LoginVC: UIViewController {


    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?){
        view.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
    }

    @IBAction func onSigninTap(sender: AnyObject) {
    
        let username:String = txtUsername.text!
        let password:String = txtPassword.text!
        
        if ( username.isEmpty || password.isEmpty ) {
            
            
            let invalidAlert = UIAlertController(title: "Sign In Failed", message: "Please check username and/or password", preferredStyle: UIAlertControllerStyle.Alert)
           
            invalidAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
                //println("Handle Cancel Logic here")
                //do nothing
            }))
            
            presentViewController(invalidAlert, animated: true, completion: nil)
            
            
            /*let alertView:UIAlertView = UIAlertView()
            alertView.title = "Sign in Failed!"
            alertView.message = "Please enter Username and Password"
            alertView.delegate = self
            alertView.addButtonWithTitle("OK")
            alertView.show()*/
            
        } else {
            
            //first check if we have a working internet connection
            /*let status = Reach().connectionStatus()
            switch status {
            case .Unknown, .Offline:
                print("Not connected")
            case .Online(.WWAN):
                print("Connected via WWAN")
            case .Online(.WiFi):
                print("Connected via WiFi")
            }*/
            
            /*let manager = Manager.sharedInstance
            // Specifying the Headers we need
            manager.session.configuration.HTTPAdditionalHeaders = [
                "Content-Type": "application/json"
            ]*/
            
            let parameters = ["Username": username, "Password": password]
            Alamofire.request(.POST, "http://114.143.128.150/ROService/ROService.svc/UserManagement/AppLogin", parameters: parameters, encoding: .JSON).responseString { response in
                //print(response.request)  // original URL request
                //print(response.response) // URL response
                //print(response.data)     // server data
                //print(response.result)   // result of response serialization
                
                
                if let data = (response.result.value)!.dataUsingEncoding(NSUTF8StringEncoding) {
                    let projects = JSON(data: data)
                    print(projects["AppLoginResult"].stringValue)
                    
                    
                    let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
                   
                    prefs.setObject(username, forKey: "USERNAME")
                    prefs.setInteger(1, forKey: "ISLOGGEDIN")
                    prefs.setObject(projects["AppLoginResult"].stringValue, forKey: "AUTHKEY")
                    //prefs.synchronize()
                    
                   
                    self.dismissViewControllerAnimated(true, completion: nil)
                    
                    print("command completed successfully")
           
                }
                
                
            }
            
            

            
        }
    
    
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
