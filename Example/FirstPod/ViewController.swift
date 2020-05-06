//
//  ViewController.swift
//  FirstPod
//
//  Created by Leela on 04/28/2020.
//  Copyright (c) 2020 Leela. All rights reserved.
//

import UIKit
import FirstPod

class ViewController: UIViewController
{

    @IBOutlet weak var txtField: UITextField!
    @IBOutlet weak var btn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func BtnClicked(_ sender: Any)
    {
        let logger = Logger()
        logger.printLog(text: "test")
        
        
        //Set App sepcific values in FirstPod and Navigate
        FirstPod.kClientID = "852e8054-ba53-4814-ae1c-6901166d0a06"
        FirstPod.kGraphEndpoint = "https://sites.ey.com"
        FirstPod.kAuthority = "https://login.microsoftonline.com/5b973f99-77df-4beb-b27d-aa0c70b8482c/"
        FirstPod.kScopes = ["user.read"]
        FirstPod.redirectUri = "msauth.com.eygsl.ctmob.xformsrefdebug"
        FirstPod.performSegueToFirspodEntryViewController(caller: self)
    }
}

