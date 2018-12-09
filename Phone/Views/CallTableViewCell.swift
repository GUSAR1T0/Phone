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
    @IBOutlet weak var callIcon: UIImageView!


    func setCall(_ call: Call) {
        let randomInt = Int.random(in: 0..<3)
        switch randomInt {
            case 0:
                callIcon.image = UIImage(named: "IconIncomingCall")
            case 1:
                callIcon.image = UIImage(named: "IconMissedIncomingCall")
            case 2:
                callIcon.image = UIImage(named: "IconOutcomingCall")
            default:
                callIcon.image = UIImage(named: "IconOutcomingCall")
        }
        nameLabel.text = call.contact?.name ?? call.phoneNumber
        let formatter = DateFormatter()
        formatter.dateStyle = .none // can be used - "hh:mm dd/MMM"
        formatter.timeStyle = .short
        timeLabel.text = formatter.string(from: call.time ?? Date())
    }

}
