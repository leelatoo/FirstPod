//
//  TokenDetailsViewController.swift
//  FirstPod
//
//  Created by Leeladevi Balasundaram on 5/6/20.
//

import UIKit

class TokenDetailsViewController: UIViewController
{
   public var authResult : AuthResult?
    
    @IBOutlet weak var tokenDetailsTxtField: UITextView!
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        if authResult != nil
        {
            var resultStr = "";
            resultStr.append("Result : \n")
            resultStr.append("User : \(authResult?.account.username ?? "")\n\n")
            resultStr.append("Scopes : \(authResult?.scopes ?? [])\n\n")
            resultStr.append("ExpiresOn : \(authResult?.expiresOn ?? Date() )\n\n")
            resultStr.append("Tenant identifier : \(authResult?.tenantProfile.identifier ?? "")\n\n")
            resultStr.append("Authority Url : \(authResult?.authorityUrl.absoluteString ?? "") \n\n")
            resultStr.append("Environment : \(authResult?.tenantProfile.environment ?? "")")

            self.tokenDetailsTxtField.text = resultStr
        }
        
        // Do any additional setup after loading the view.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
       if segue.destination is RawTokenViewController
        {
            let destinationVC = segue.destination as! RawTokenViewController
            destinationVC.accessToken = sender as? String
        }
    }
    
    @IBAction func RawBtnClicked(_ sender: Any)
    {
        print("RawBtnClicked")
        print("Token : \(authResult?.accessToken ?? "no value")")
        performSegue(withIdentifier: "rawtokensegue", sender: authResult?.accessToken ?? "no value")
    }
    

}
