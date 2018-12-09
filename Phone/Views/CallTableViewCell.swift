//
//  CallTableViewCell.swift
//  Phone
//
//  Created by Roman Mashenkin on 04/12/2018.
//  Copyright © 2018 vXdesign.store. All rights reserved.
//

import UIKit

class CallTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!

    func setCall(_ call: Call) {
        nameLabel.text = call.contact?.name ?? call.phoneNumber
        let formatter = DateFormatter()
        formatter.dateStyle = .none // can be used - "hh:mm dd/MMM"
        formatter.timeStyle = .short
        timeLabel.text = formatter.string(from: call.time ?? Date())
    }

}
