//
//  FeedViewController.swift
//  RSSReader
//
//  Created by Vladyslav on 7/17/16.
//  Copyright © 2016 Vladyslav. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    
    var parser: RSSParser!
    
    var newsDataModel: [RSSItemModel] = []
    
    let coreDataHelper = CoreDataHerper.sharedInstance
    
    var isNewsLoaded: Bool = false
    
    //MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
                
        initializeRSSParser()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if !isNewsLoaded {
            startParsing()
            isNewsLoaded = true
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: Private
    
    private func configureTableView() {
        tableView.estimatedRowHeight = 100;
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    private func initializeRSSParser() {
        parser = RSSParser.init(rssURL: NSURL.init(string: URLS.AppleRSSnewsURL)!)
        parser.delegate = self
    }
    
    private func startParsing() {
        if ApplicationHelper.isConnectedToNetwork() {
            activityIndicator.startAnimating()
            parser.startParsing()
        } else {
            newsDataModel = coreDataHelper.readFromCoreData()
            if newsDataModel.count > 0 {
                tableView.reloadData()
            } else {
                
                UIAlertController.showAlert(self, messageText: AlertMessages.NoDataMessage, messageTitle: AlertTitles.NoInternetTitle, buttonText: "Ok")
            }
        }
    }
}

//MARK: RSSParserDataSource

extension FeedViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsDataModel.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(CellReuseIdentifiers.Feed.RSSFeedCell, forIndexPath: indexPath) as! FeedTableViewCell
        cell.rssItem = newsDataModel[indexPath.row]
        return cell
    }
}

//MARK: UITableViewDelegate

extension FeedViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //Show Detailed VC.
        let detailedNewsVC = self.storyboard?.instantiateViewControllerWithIdentifier(ViewControllers.DetailedNewsViewController) as! DetailedNewsViewController
        detailedNewsVC.feedItem = newsDataModel[indexPath.row]
        self.navigationController?.pushViewController(detailedNewsVC, animated: true)
    }
}

//MARK: RSSParserDelegate

extension FeedViewController: RSSParserDelegate {
    func rssParser(parser: RSSParser, didFinishParsingModels models: [RSSItemModel]) {
        newsDataModel = models
        tableView.reloadData()
        
        if self.activityIndicator.isAnimating() {
            self.activityIndicator.stopAnimating()
        }
        
        
        //Clear coreData "Feed" Entity.
        if coreDataHelper.deleteAllData() {
            coreDataHelper.saveToCoreData(newsDataModel)
        }
        
    }
}

