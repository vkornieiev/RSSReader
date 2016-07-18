//
//  DetailedNewsViewController.swift
//  RSSReader
//
//  Created by Vladyslav on 7/17/16.
//  Copyright © 2016 Vladyslav. All rights reserved.
//

import UIKit

class DetailedNewsViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    var titleString: String = ""
    var descriptionString: String = ""
    var dateString: String = ""
    
    var feedItem: RSSItemModel! {
        didSet {
            titleString = feedItem.title
            descriptionString = feedItem.descriptionText
            dateString = feedItem.pubDate
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = titleString
        descriptionLabel.text = descriptionString
        dateLabel.text = dateString
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
