//
//  UIAlertController+Extensions.swift
//  RSSReader
//
//  Created by Vladyslav on 7/18/16.
//  Copyright © 2016 Vladyslav. All rights reserved.
//

import UIKit

extension UIAlertController {
    class func showAlert(parent: UIViewController, messageText: String, messageTitle: String, buttonText: String) -> UIAlertController {
        let alert = UIAlertController(title: messageTitle, message: messageText, preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: buttonText, style: .Default, handler: nil))
      
        parent.presentViewController(alert, animated: true, completion: nil)
        return alert
    }
}