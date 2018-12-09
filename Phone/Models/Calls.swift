//
//  Calls.swift
//  Phone
//
//  Created by Roman Mashenkin on 04/12/2018.
//  Copyright © 2018 vXdesign.store. All rights reserved.
//

import UIKit
import CoreData

class Calls: NSObject {

    private static var calls: [Call] = []
    static var needsUpdate = true
    static var callsDict: [String: [Call]] {
        return initValues()
    }

    static func initValues() -> [String: [Call]] {
        if needsUpdate {
            calls = fetchData()
        }

        let formatter = DateFormatter()
        formatter.dateStyle = .full
        formatter.timeStyle = .none

        var callsDict: [String: [Call]] = [:]
        for call in calls {
            let keys = Array(callsDict.keys)
            let key = formatter.string(from: call.time ?? Date())
            if keys.contains(key) {
                callsDict[key]?.append(call)
            } else {
                callsDict[key] = [call]
            }
        }
        return callsDict
    }

    static func fetchData() -> [Call] {
        guard let applicationDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return []
        }

        let context = applicationDelegate.persistentContainer.viewContext
        let request = Call.fetchRequest() as NSFetchRequest<Call>

        var calls: [Call] = []
        do {
            calls = try context.fetch(request)
            needsUpdate = false
        } catch {
            return calls
        }

        let contactsRequest = Contact.fetchRequest() as NSFetchRequest<Contact>
        for call in calls {
            contactsRequest.predicate = NSPredicate(format: "phoneNumber = %@", call.phoneNumber!)
            do {
                let contacts = try context.fetch(contactsRequest)
                if let contact = contacts.first, contact != call.contact {
                    call.contact = contact
                    try context.save()
                }
            } catch {
            }
        }

        return calls
    }

    static func add(_ phoneNumber: String, _ time: Date) {
        guard let applicationDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }

        let context = applicationDelegate.persistentContainer.viewContext

        do {
            let callToAdd = Call(context: context)
            callToAdd.phoneNumber = phoneNumber
            callToAdd.time = time
            try context.save()
            needsUpdate = true
        } catch {
            return
        }
    }

    static func get(in section: Int?) -> [Call]? {
        let key = Array(callsDict.keys)[section!]
        return callsDict[key]
    }

    static func get(in section: Int?, at row: Int?) -> Call {
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
        } catch {
            return
        }
    }

}
