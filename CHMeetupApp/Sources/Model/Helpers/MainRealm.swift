//
//  MainRealm.swift
//
//  Created by Igor Tudoran on 07.02.17.
//

import Foundation
import RealmSwift

protocol ObjectSingletone: class {
    init()
}

var mainRealm: Realm!

let realmWriteError = "realmWriteCatchError"

class RealmController {

    static var shared: RealmController = RealmController()

    func setup() {
        Realm.Configuration.defaultConfiguration =
            Realm.Configuration(schemaVersion:1, migrationBlock: nil)

        do {
            mainRealm = try Realm()
        } catch let error as NSError {
            print("Realm setup: \(error)")
        }
    }

    func copyRealmFile(_ done: ((Bool) -> Void)) {
        if let defaultRealmURL = Realm.Configuration.defaultConfiguration.fileURL,
            let myRealmURL = Bundle.main.url(forResource: "default", withExtension: "realm") {

            do {
                try FileManager.default.removeItem(at: defaultRealmURL)
                print("Realm file deleted")
            } catch let error as NSError {
                print("No mainRealm file to delete or error: \(error)")
            }

            do {
                try FileManager.default.copyItem(at: myRealmURL, to: defaultRealmURL)
            } catch let error as NSError {
                print("Copy mainRealm file error: \(error)")
                done(false)
            }

            done(true)
        } else {
            print("Realm file url error or nil")
            done(false)
        }
    }
}

public func realmWrite(_ realmObject: Realm = mainRealm, block: (() -> Void)) {

    if realmObject.isInWriteTransaction {
        block()
    } else {
        do {
            try realmObject.write(block)
        } catch {
            NotificationCenter.default.post(name: Foundation.Notification.Name(rawValue: realmWriteError),
                                            object: nil)
        }
    }

}

// MARK: - Extension

extension Realm {

    public func writeFunction(_ block: (() -> Void)) {

        if mainRealm.isInWriteTransaction {
            block()
        } else {
            do {
                try write(block)
            } catch {
                NotificationCenter.default.post(name: Foundation.Notification.Name(rawValue: realmWriteError),
                                                object: nil)
            }
        }

    }
}

extension ObjectSingletone where Self: Object {

    static var value: Self {

        let object = mainRealm.objects(Self.self).first

        if let value = object {
            return value
        } else {
            let value = Self()

            mainRealm.writeFunction({ () -> Void in
                mainRealm.add(value)
            })

            return value
        }
    }

}

extension Results {

    func toArray() -> [T] {
        return self.map {$0}
    }

}

extension List {

    func toArray() -> [T] {
        return self.map {$0}
    }

}
