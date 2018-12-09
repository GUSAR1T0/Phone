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

    var active = false
    var contact: Contact?

    override func viewDidLoad() {
        super.viewDidLoad()

        nameTextField.isEnabled = active
        phoneNumberTextField.isEnabled = active
        saveButton.isHidden = !active

        nameTextField.text = contact?.name
        phoneNumberTextField.text = contact?.phoneNumber
    }

    @IBAction func save(_ sender: Any) {
        if let contact = contact {
            contact.name = nameTextField.text
            contact.phoneNumber = phoneNumberTextField.text
            Contacts.update()
        } else {
            Contacts.add(nameTextField.text, phoneNumberTextField.text)
        }
        navigationController?.popViewController(animated: true)
    }

    @IBAction func edit(_ sender: Any) {
        active = !active
        nameTextField.isEnabled = active
        phoneNumberTextField.isEnabled = active
        saveButton.isHidden = !active
    }

}
