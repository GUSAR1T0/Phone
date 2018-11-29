//
//  Contacts.swift
//  Phone
//
//  Created by Roman Mashenkin on 29/11/2018.
//  Copyright © 2018 vXdesign.store. All rights reserved.
//

import UIKit

struct Contact {

    var name: String
    var phoneNumber: String

    func isValid() -> Bool {
        return !name.isEmpty && !phoneNumber.isEmpty
    }

}

class Contacts {

    static var contactsDict: [String: [Contact]] = initValues()

    static func initValues() -> [String: [Contact]] {
        let contacts = [Contact(name: "John", phoneNumber: "11111111"),
                        Contact(name: "Jack", phoneNumber: "22222222"),
                        Contact(name: "Steve", phoneNumber: "33333333"),
                        Contact(name: "Tim", phoneNumber: "44444444")]

        var contactsDict: [String: [Contact]] = [:]
        for contact in contacts {
            let keys = Array(contactsDict.keys)
            let key = contact.name.prefix(1).uppercased()
            if keys.contains(key) {
                contactsDict[key]?.append(contact)
            } else {
                contactsDict[key] = [contact]
            }
        }
        return contactsDict
    }

    static func add(_ contact: Contact) {
        let keys = Array(contactsDict.keys)
        let key = contact.name.prefix(1).uppercased()
        if keys.contains(key) {
            contactsDict[key]?.append(contact)
        } else {
            contactsDict[key] = [contact]
        }
    }

    static func get(in section: Int?) -> [Contact]? {
        let key = Array(contactsDict.keys)[section!]
        return contactsDict[key]
    }

    static func get(in section: Int?, at row: Int?) -> Contact {
        return get(in: section)![row!]
    }

    static func remove(_ section: Int, _ row: Int) {
        let key = Array(contactsDict.keys)[section]
        contactsDict[key]?.remove(at: row)
        if contactsDict[key]?.isEmpty == true {
            contactsDict.removeValue(forKey: key)
        }
    }

}
