//
//  RSSItemModel.swift
//  RSSReader
//
//  Created by Vladyslav on 7/17/16.
//  Copyright © 2016 Vladyslav. All rights reserved.
//

import UIKit

class RSSItemModel: NSObject {

    var title: String = ""
    var descriptionText: String = ""
    
    var pubDate: String = ""
    
    var link: String = ""
    
    //MARK: Initialization
    
    override init() {
        super.init()
    }
    
    init(dictionary: [String:String]) {
        super.init()
        
        title = dictionary["title"] ?? ""
        descriptionText = dictionary["description"] ?? ""
        pubDate = dictionary["pubDate"] ?? ""
        link = dictionary["link"] ?? ""
    }
    
}
