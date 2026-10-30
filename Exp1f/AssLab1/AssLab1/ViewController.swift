//
//  ViewController.swift
//  AssLab1
//
//  Created by Mac Lab 25 on 24/07/26.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var bg: UIView!
    @IBOutlet weak var Label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func Toogle(_ sender: UISwitch) {
        if sender.isOn {
            bg.backgroundColor = .systemPink
        }
        else {
            bg.backgroundColor = .yellow
        }
    }
    
    @IBAction func Button(_ sender: Any) {
        Label.text = "Hello Guys"
    }
}

