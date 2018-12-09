//
//  ContactsViewController.swift
//  Phone
//
//  Created by Roman Mashenkin on 29/11/2018.
//  Copyright © 2018 vXdesign.store. All rights reserved.
//

import UIKit

class ContactsViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        tableView.reloadData()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return Contacts.contactsDict.keys.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Contacts.get(in: section)?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath)
        let contact = Contacts.get(in: indexPath.section, at: indexPath.row)
        cell.textLabel?.text = contact.name
        cell.detailTextLabel?.text = contact.phoneNumber
        return cell
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return Array(Contacts.contactsDict.keys)[section]
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ShowContactSegue", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowContactSegue" {
            let destinationViewController = segue.destination as! DetailsViewController
            destinationViewController.active = false
            let indexPath = tableView.indexPathForSelectedRow
            destinationViewController.contact = Contacts.get(in: indexPath?.section, at: indexPath?.row)
        } else if segue.identifier == "AddContactSegue" {
            let destinationViewController = segue.destination as! DetailsViewController
            destinationViewController.active = true
        }
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            Contacts.remove(indexPath.section, indexPath.row)
            tableView.reloadData()
        }
    }

}
