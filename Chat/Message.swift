//
//  Message.swift
//  Chat
//
//  Created by Grace Kotick on 6/21/16.
//  Copyright © 2016 Grace Kotick. All rights reserved.
//

import UIKit
import Parse

class Message: NSObject {
    class func postMessage(text: UITextField, withCompletion completion: PFBooleanResultBlock?) {
        let message = PFObject(className: "Message_fbuJuly2016")
        
        message["text"] = getMessageFromTextField(text)
        message["user"] = PFUser.currentUser()
        message.saveInBackgroundWithBlock(completion)
    }
    
    class func getMessageFromTextField(text: UITextField?) -> String?{
        if let text = text{
            return text.text!
        } else{
            return nil
        }
        
    }
}
