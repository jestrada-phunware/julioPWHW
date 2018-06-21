//
//  RealmManager.swift
//  juliosPWHW
//
//  Created by Julio Estrada on 6/16/18.
//  Copyright © 2018 Julio Estrada. All rights reserved.
//

import RealmSwift

class RealmManager {
    static let shared = RealmManager()
    var realm: Realm
    init() {
        realm = try! Realm()
    }
    
    func saveData(objects: [Event]) {

        for object in objects {
            if realm.object(ofType: Event.self, forPrimaryKey: object.id) != nil {
                return
            }
            try! realm.write {
                realm.add(object)
            }
        }

    }
}
