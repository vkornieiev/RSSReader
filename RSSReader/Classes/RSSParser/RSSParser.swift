//
//  RSSParser.swift
//  RSSReader
//
//  Created by Vladyslav on 7/17/16.
//  Copyright © 2016 Vladyslav. All rights reserved.
//

import UIKit

//MARK: RSSParserDelegate

protocol RSSParserDelegate: class {
    func rssParser(parser: RSSParser, didFinishParsingModels models: [RSSItemModel])
}

class RSSParser: NSObject {
    
    var xmlParser = NSXMLParser()
    
    var entryTitle: String = ""
    var entryDescription: String = ""
    var entryLink: String = ""
    var entryPubDate: String = ""
    
    var currentParsedElement:String = ""
    var entryDictionary: [String:String] = [:]
    var entriesArray:[Dictionary<String, String>] = []
    
    var feedModelsArray: [RSSItemModel] = []
    
    var delegate: RSSParserDelegate?
    
    //MARK: Initialization
    
    init(rssURL: NSURL) {
        super.init()
        
        xmlParser = NSXMLParser(contentsOfURL: rssURL)!
        xmlParser.delegate = self
    }
    
    //MARK: Public
    
    func startParsing() {
        xmlParser.parse()
    }
}

//MARK: NSXMLParserDelegate

extension RSSParser: NSXMLParserDelegate {
    
    //Detect xml object names from RSS feed
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        print("element name: \(elementName)")
        
        if elementName == "media:thumbnail" {
            print("Catch")
        }
        if elementName == "title"{
            entryTitle = String()
            currentParsedElement = "title"
        }
        if elementName == "description" {
            entryDescription = String()
            currentParsedElement = "description"
        }
        if elementName == "link" {
            entryLink = String()
            currentParsedElement = "link"
        }
        if elementName == "pubDate" {
            entryPubDate = String()
            currentParsedElement = "pubDate"
        }
    }
    
    //Detect xml RSS feed object data by names
    func parser(parser: NSXMLParser, foundCharacters string: String) {
        print("string name: \(string)")
        
        if currentParsedElement == "title" {
            entryTitle = entryTitle + string
        }
        if currentParsedElement == "description" {
            entryDescription = entryDescription + string
        }
        if currentParsedElement == "link" {
            entryLink = entryLink + string
        }
        if currentParsedElement == "pubDate" {
            entryPubDate = entryPubDate + string
        }
    }
    
    //End of working with current xml object
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        if elementName == "title" {
            entryDictionary["title"] = entryTitle
        }
        if elementName == "link" {
            entryDictionary["link"] = entryLink
        }
        if elementName == "description" {
            entryDictionary["description"] = entryDescription
        }
        if elementName == "pubDate" {
            entryDictionary["pubDate"] = entryPubDate
            entriesArray.append(entryDictionary)
        }
    }
    
    //End of xml data.
    func parserDidEndDocument(parser: NSXMLParser) {
        
        // Compose models array
        for itemDictionary in entriesArray {
            let itemModel = RSSItemModel.init(dictionary: itemDictionary)
            feedModelsArray.append(itemModel)
        }
        
        // Tell detegate that class finish parrsing data.
        delegate?.rssParser(self, didFinishParsingModels: feedModelsArray)
    }
}