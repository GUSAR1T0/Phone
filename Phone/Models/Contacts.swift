//
//  Contacts.swift
//  Phone
//
//  Created by Roman Mashenkin on 29/11/2018.
//  Copyright © 2018 vXdesign.store. All rights reserved.
//

import UIKit
import CoreData

class Contacts {

    private static var contacts: [Contact] = []
    static var needsUpdate = true
    static var contactsDict: [String: [Contact]] {
        return initValues()
    }

    static func initValues() -> [String: [Contact]] {
        if needsUpdate {
            contacts = fetchData()
        }

        var contactsDict: [String: [Contact]] = [:]
        for contact in contacts {
            let keys = Array(contactsDict.keys)
            let key = contact.name?.prefix(1).uppercased() ?? ""
            if keys.contains(key) {
                contactsDict[key]?.append(contact)
            } else {
                contactsDict[key] = [contact]
            }
        }
        return contactsDict
    }

    static func fetchData() -> [Contact] {
        guard let applicationDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return []
        }

        let context = applicationDelegate.persistentContainer.viewContext
        let request = Contact.fetchRequest() as NSFetchRequest<Contact>

        do {
            let contacts = try context.fetch(request)
            needsUpdate = false
            return contacts
        } catch {
            return []
        }
    }

    static func add(_ name: String?, _ phoneNumber: String?) {
        guard let applicationDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }

        let context = applicationDelegate.persistentContainer.viewContext
        let contactToAdd = Contact(context: context)
        contactToAdd.name = name
        contactToAdd.phoneNumber = phoneNumber

        do {
            try context.save()
            needsUpdate = true
            Calls.needsUpdate = true
        } catch {
            return
        }
    }

    static func update() {
        guard let applicationDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }

        let context = applicationDelegate.persistentContainer.viewContext

        do {
            try context.save()
            needsUpdate = true
            Calls.needsUpdate = true
        } catch {
            return
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
        guard let applicationDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }

        let context = applicationDelegate.persistentContainer.viewContext
        let contact = get(in: section, at: row)
        context.delete(contact)

        do {
            try context.save()
            needsUpdate = true
            Calls.needsUpdate = true
        } catch {
            return
        }
    }

}
