//
//  Aplication.swift
//  app-list
//
//  Created by Jonathan Macias on 1/7/20.
//  Copyright © 2020 jonathan. All rights reserved.
//

import Foundation

//struct App: Codable {
//
//    var feed: Feed
//
////    private enum CodingKeys: String, CodingKey{
////    case feed = "feed"
////
////
////    }
//
//    init(feed: Feed) {
//        self.feed = feed
//    }
//}
//
//struct Feed: Codable {
//    var entry: Entry
//
//    init(entry: Entry) {
//        self.entry = entry
//    }
//
//}
//
//struct Entry: Codable {
//    var arrayApps: [Aplication]
//
//    init(apps: [Aplication]) {
//        self.arrayApps = apps
//    }
//}

struct Aplication {
    var imname: String
    var imimage: String
    var sumari: String
    var category: String
    
//    init(imname: String, imimage: String, sumari: String, category: String) {
//        self.imname = imname
//        self.imimage = imimage
//        self.sumari = sumari
//        self.category = category
//    }
    
}
