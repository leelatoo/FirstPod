//
//  ViewController.swift
//  FirstPod
//
//  Created by Leela on 04/28/2020.
//  Copyright (c) 2020 Leela. All rights reserved.
//

import UIKit
import FirstPod

class ViewController: UIViewController {

    @IBOutlet weak var txtField: UITextField!
    @IBOutlet weak var btn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func BtnClicked(_ sender: Any)
    {
        let logger = Logger()
        logger.printLog(text: txtField.text ?? "no value")
    }
}

