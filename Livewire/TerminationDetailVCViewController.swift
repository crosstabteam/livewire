//
//  TerminationDetailVCViewController.swift
//  Livewire
//
//  Created by Adil Shaikh on 16/01/16.
//  Copyright © 2016 Adil Shaikh. All rights reserved.
//

import UIKit

class TerminationDetailVCViewController: UIViewController, UITableViewDelegate {

    var termVariable: TermVariable?
    var keys = [String]()
    var values = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        for (key, _) in (termVariable?.elements)! {
            keys.append(key)
        }
        
        for (_, value) in (termVariable?.elements)! {
            values.append(String(value))
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        
        cell.textLabel?.text = keys[indexPath.row]

        cell.detailTextLabel?.text = values[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.keys.count
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
