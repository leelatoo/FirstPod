//
//  RawTokenViewController.swift
//  FirstPod
//
//  Created by Leeladevi Balasundaram on 5/6/20.
//

import UIKit

class RawTokenViewController: UIViewController
{

    @IBOutlet weak var tokenTxtFld: UITextView!
    public var accessToken : String?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.tokenTxtFld.text = accessToken ?? "no value"
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
