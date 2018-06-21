//
//  Event.swift
//  juliosPWHW
//
//  Created by Julio Estrada on 6/15/18.
//  Copyright © 2018 Julio Estrada. All rights reserved.
//

import RealmSwift

class Event: Object, Decodable {
    @objc dynamic var id: Int = 0
    @objc dynamic var eventDescription: String = ""
    @objc dynamic var title: String = ""
    @objc dynamic var timeStamp: String = ""
    @objc dynamic var image: String? = ""
    @objc dynamic var phone: String? = ""
    @objc dynamic var date: String? = ""
    @objc dynamic var locationLineOne: String? = ""
    @objc dynamic var locationLineTwo: String? = ""

    override class func primaryKey() -> String? {
        return "id"
    }

    private enum CodingKeys: String, CodingKey {
        case id, title, image, phone, date
        case eventDescription = "description"
        case timeStamp = "timestamp"
        case locationLineOne = "locationline1"
        case locationLineTwo = "locationline2"
    }
    
}
