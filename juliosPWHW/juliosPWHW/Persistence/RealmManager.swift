//
//  RealmManager.swift
//  juliosPWHW
//
//  Created by Julio Estrada on 6/15/18.
//  Copyright © 2018 Julio Estrada. All rights reserved.
//

import RealmSwift

class RealmManager {
    // MARK: - Singleton
    static let shared = RealmManager()

    // MARK: - Properties
    var realm: Realm
    init() {
        realm = try! Realm()
    }

    // MARK: - Functions
    func saveData(_ objects: [Event]) {
        for object in objects {
            try! realm.write {
                realm.add(object, update: true)
            }
        }
    }

    func loadSavedData(from realm: Realm) -> Results<Event> {
        let objects = realm.objects(Event.self)
        return objects
    }
}
