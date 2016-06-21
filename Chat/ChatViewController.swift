//
//  ChatViewController.swift
//  Chat
//
//  Created by Grace Kotick on 6/21/16.
//  Copyright © 2016 Grace Kotick. All rights reserved.
//

import UIKit
import Parse
class ChatViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    var messages = [PFObject]?()
    
    @IBOutlet weak var messageField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.makeQuery()
        // Do any additional setup after loading the view.
        NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(onTimer), userInfo: nil, repeats: true)
        
    }
    func makeQuery(){
        
        var query = PFQuery(className: "Message_fbuJuly2016")
        query.orderByDescending("_created_at")
        query.includeKey("user")
        query.findObjectsInBackgroundWithBlock { (messages:[PFObject]?, error: NSError?) -> Void in
            if error == nil {
                //print(messages)
                self.messages = messages
                
            } else{
                print(error)
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func createMessage(sender: AnyObject) {
        Message.postMessage(messageField, withCompletion: { (success: Bool, error: NSError?) in
            if success {
                print("Message sent.")
            } else{
                print("Send in failed.")
            }
        })
        
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let messages = messages{
            return messages.count
        } else{
            return 0
        }
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MessageCell", forIndexPath: indexPath) as! MessageTableViewCell
        let message = messages![indexPath.row]
        cell.textMessage.text = message["text"] as? String
        if let user = message["user"] as? PFObject{
            if let username = user["username"] as? String{
                cell.userLabel.text = username
            }
        }
        
        return cell
        
    }
    func onTimer(){
        self.makeQuery()
        tableView.reloadData()
        print("here")
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
