//
//  Strings.swift
//  RSSReader
//
//  Created by Vladyslav on 7/17/16.
//  Copyright © 2016 Vladyslav. All rights reserved.
//

/** Names of View Controllers **/
struct ViewControllers {
    static let FeedViewController          = "FeedNavigatonViewController"
    static let DetailedNewsViewController  = "DetailedNewsViewController"
}

/** TableView Cell Reuse Identifiers  **/
struct CellReuseIdentifiers {
    struct Feed {
    static let RSSFeedCell                 = "rssFeedCell"
    }
}

/** Titles of alert controllers **/
struct AlertTitles {
    static let NoInternetTitle             = "No internet connection"
}

/** Messages of alert controllers **/
struct AlertMessages {
    static let NoDataMessage               = "Can't display news without Internet connection. No data in local database"
}

/** URLS **/
struct URLS {
    static let AppleRSSnewsURL             = "http://developer.apple.com/news/rss/news.rss"
}


