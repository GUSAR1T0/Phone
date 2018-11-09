//
//  ViewController.swift
//  Phone
//
//  Created by Roman Mashenkin on 07/11/2018.
//  Copyright © 2018 vXdesign.store. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var numLabel: UILabel!

    @IBOutlet weak var button1: UIButton! {
        didSet {
            setupButton(button1)
        }
    }

    @IBOutlet weak var button2: UIButton! {
        didSet {
            setupButton(button2)
        }
    }
    
    @IBOutlet weak var button3: UIButton! {
        didSet {
            setupButton(button3)
        }
    }
    
    @IBOutlet weak var button4: UIButton! {
        didSet {
            setupButton(button4)
        }
    }
    
    @IBOutlet weak var button5: UIButton! {
        didSet {
            setupButton(button5)
        }
    }
    
    @IBOutlet weak var button6: UIButton! {
        didSet {
            setupButton(button6)
        }
    }
    
    @IBOutlet weak var button7: UIButton! {
        didSet {
            setupButton(button7)
        }
    }
    
    @IBOutlet weak var button8: UIButton! {
        didSet {
            setupButton(button8)
        }
    }
    
    @IBOutlet weak var button9: UIButton! {
        didSet {
            setupButton(button9)
        }
    }
    
    @IBOutlet weak var buttonStar: UIButton! {
        didSet {
            setupButton(buttonStar)
        }
    }
    
    @IBOutlet weak var button0: UIButton! {
        didSet {
            setupButton(button0)
        }
    }
    
    @IBOutlet weak var buttonHash: UIButton! {
        didSet {
            setupButton(buttonHash)
        }
    }
    
    @IBOutlet weak var buttonContacts: UIButton! {
        didSet {
            setupButton(buttonContacts)
        }
    }
    
    @IBOutlet weak var buttonCall: UIButton! {
        didSet {
            setupButton(buttonCall)
        }
    }
    
    @IBOutlet weak var buttonRemove: UIButton! {
        didSet {
            setupButton(buttonRemove)
        }
    }
    
    func setupButton(_ button: UIButton) {
        button.layer.cornerRadius = 0.5 * button.bounds.size.width
        button.clipsToBounds = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func addSymbol(_ sender: Any) {
        if let buttonTitle = (sender as? UIButton)?.title(for: .normal),
            let labelTitle = numLabel.text {
            if (buttonTitle == "*" && labelTitle.last == "*") {
                numLabel.text = String(labelTitle.dropLast()) + "+"
            } else {
                numLabel.text = labelTitle.trimmingCharacters(in: .whitespaces) + buttonTitle
            }
        }
    }

    @IBAction func removeSymbol(_ sender: Any) {
        if let labelTitle = numLabel.text {
            numLabel.text = (labelTitle.count <= 1) ? " " : String(labelTitle.dropLast())
        }
    }

    @IBAction func makeCall(_ sender: Any) {
        if let number = numLabel.text,
            let url = URL(string: "tel://\(number)") {
            UIApplication.shared.open(url)
        }
    }

}
