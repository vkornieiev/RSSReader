//
//  FeedTableViewCell.swift
//  RSSReader
//
//  Created by Vladyslav on 7/17/16.
//  Copyright © 2016 Vladyslav. All rights reserved.
//

import UIKit

class FeedTableViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var shortDescription: UILabel!
    @IBOutlet weak var publicationDate: UILabel!
    
    // Initialize properties after setting rssItem
    var rssItem: RSSItemModel! {
        didSet {
            title.text = rssItem.title
            shortDescription.text = rssItem.descriptionText
            publicationDate.text = rssItem.pubDate
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
