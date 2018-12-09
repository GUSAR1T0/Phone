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

    private static var _calls: [Call] = []
    static var needsUpdate = true
    static var calls: [Call] {
        if needsUpdate {
            return fetchData()
        } else {
            return _calls
        }
    }

    static func fetchData() -> [Call] {
        guard let applicationDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return []
        }

        let context = applicationDelegate.persistentContainer.viewContext
        let request = Call.fetchRequest() as NSFetchRequest<Call>

        do {
            _calls = try context.fetch(request)
            needsUpdate = false
            return _calls
        } catch {
            return []
        }
    }

    static func add(_ phoneNumber: String, _ time: Date) {
        guard let applicationDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }

        let context = applicationDelegate.persistentContainer.viewContext
        let contactsRequest = Contact.fetchRequest() as NSFetchRequest<Contact>
        contactsRequest.predicate = NSPredicate(format: "phoneNumber = %@", phoneNumber)

        do {
            let contacts = try context.fetch(contactsRequest)
            let callToAdd = Call(context: context)
            if let contact = contacts.first {
                callToAdd.contact = contact
            }

            callToAdd.phoneNumber = phoneNumber
            callToAdd.time = time

            try context.save()
            needsUpdate = true
        } catch {
            return
        }
    }

}
