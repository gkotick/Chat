//
//  LoginViewController.swift
//  Chat
//
//  Created by Grace Kotick on 6/21/16.
//  Copyright © 2016 Grace Kotick. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logInTapped(sender: AnyObject) {
        PFUser.logInWithUsernameInBackground(username.text!, password: password.text!) { (user: PFUser?, error: NSError?) in
                if user != nil{
                    print("You're logged in.")
                    self.performSegueWithIdentifier("LoginSegue", sender: nil)
            }
        }
    }
 

    @IBAction func signUpTapped(sender: AnyObject) {
        let newUser = PFUser()
        newUser.username = username.text
        newUser.password = password.text
        newUser.signUpInBackgroundWithBlock { (success:Bool, error: NSError?) in
            if success{
                print("created user.")
                self.performSegueWithIdentifier("LoginSegue", sender: nil)
                
            } else{
                print(error?.localizedDescription)
            }
        }
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
