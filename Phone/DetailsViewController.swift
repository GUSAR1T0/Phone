//
//  DetailsViewController.swift
//  Phone
//
//  Created by Roman Mashenkin on 29/11/2018.
//  Copyright © 2018 vXdesign.store. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!

    @IBOutlet weak var saveButton: UIButton!

    var active: Bool?
    var contact: Contact?

    override func viewDidLoad() {
        super.viewDidLoad()

        nameTextField.isEnabled = active!
        phoneNumberTextField.isEnabled = active!

        nameTextField.text = contact?.name
        phoneNumberTextField.text = contact?.phoneNumber
    }

    @IBAction func save(_ sender: Any) {
        let count: Int = (navigationController?.viewControllers.count)!
        let contactsController = navigationController?.viewControllers[count - 2] as! ContactsViewController
        let contact = Contact(name: nameTextField.text!, phoneNumber: phoneNumberTextField.text!)

        if contact.isValid() {
            Contacts.add(contact)
            contactsController.tableView.reloadData()
            navigationController?.popViewController(animated: true)
        }
    }
}
