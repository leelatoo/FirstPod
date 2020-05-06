//
//  TokenRequestViewController.swift
//  FirstPod
//
//  Created by Leeladevi Balasundaram on 5/6/20.
//

import UIKit
import MSAL

class TokenRequestViewController: UIViewController
{

        let kClientID = "852e8054-ba53-4814-ae1c-6901166d0a06"
        let kGraphEndpoint = "https://sites.ey.com"
        let kAuthority = "https://login.microsoftonline.com/5b973f99-77df-4beb-b27d-aa0c70b8482c/"
        let kScopes: [String] = ["user.read"]
        
        var accessToken = String()
        var applicationContext : MSALPublicClientApplication?
        var webViewParamaters : MSALWebviewParameters?
        var currentAccount: MSALAccount?
        
        var authResult : AuthResult?
        
        @IBOutlet weak var selectEndpointBtn: UIButton!
        @IBOutlet weak var tokenStatusLabel: UILabel!
        @IBOutlet weak var viewTokenBtn: UIButton!
        @IBOutlet weak var azureAppClientIdTxtFld: UITextField!
        @IBOutlet weak var authorityTenantUriTxtFld: UITextField!
        @IBOutlet weak var resourceAudienceTxtFld: UITextField!
        @IBOutlet weak var redirectUriTxtFld: UITextField!
        
        override func viewDidLoad()
        {
            super.viewDidLoad()
            print("ResultsViewController")
            do
            {
               try self.initMSAL()
            }
            catch let error {
               print("Unable to create Application Context \(error)")
            }
            SetUi()
        }
        
//        @objc func dismissKeyboard()
//        {
//            view.endEditing(true)
//        }
//
//        @objc func keyboardWillShow(notification: NSNotification)
//        {
//            guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else
//            {
//               return
//            }
//
//          self.view.frame.origin.y = 0 - keyboardSize.height
//        }

        @objc func keyboardWillHide(notification: NSNotification)
        {
          self.view.frame.origin.y = 0
        }
        
        func SetUi()
        {
            viewTokenBtn.isEnabled = false
            azureAppClientIdTxtFld.text = kClientID
            authorityTenantUriTxtFld.text = kAuthority
            resourceAudienceTxtFld.text = kGraphEndpoint
            redirectUriTxtFld.text = "msauth.com.eygsl.ctmob.xformsrefdebug"
            tokenStatusLabel.text = "No Token"

//            let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
//            tap.cancelsTouchesInView = false
//            view.addGestureRecognizer(tap)
//
//            NotificationCenter.default.addObserver(self, selector: #selector(ResultsViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
//            NotificationCenter.default.addObserver(self, selector: #selector(ResultsViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        }

        func initMSAL() throws
        {
            guard let authorityURL = URL(string: kAuthority) else {
                print("Unable to create authority URL")
                return
            }
            
            let authority = try MSALAADAuthority(url: authorityURL)
            
            let msalConfiguration = MSALPublicClientApplicationConfig(clientId: kClientID, redirectUri: nil, authority: authority)
            self.applicationContext = try MSALPublicClientApplication(configuration: msalConfiguration)
            self.initWebViewParams()
        }
        
        func initWebViewParams()
        {
            webViewParamaters = MSALWebviewParameters(authPresentationViewController: self)
        }

        typealias AccountCompletion = (MSALAccount?) -> Void

        func loadCurrentAccount(completion: AccountCompletion? = nil)
        {
            guard let applicationContext = self.applicationContext else { return }
            
            let msalParameters = MSALParameters()
            msalParameters.completionBlockQueue = DispatchQueue.main
                    
            applicationContext.getCurrentAccount(with: msalParameters, completionBlock: { (currentAccount, previousAccount, error) in
                
                if let error = error {
                    print("Couldn't query current account with error: \(error)")
                    return
                }
                
                if let currentAccount = currentAccount {
                    
                    print("Found a signed in account \(String(describing: currentAccount.username)). Updating data for that account...")
                                    
                    if let completion = completion {
                        completion(self.currentAccount)
                    }
                    
                    return
                }
                
                print("Account signed out. Updating UX")
                self.accessToken = ""
                
                if let completion = completion {
                    completion(nil)
                }
            })
        }
           
        func getGraphEndpoint() -> String
        {
           return kGraphEndpoint.hasSuffix("/") ? (kGraphEndpoint + "v1.0/me/") : (kGraphEndpoint + "/v1.0/me/");
        }
        
        @IBAction func selectEndpointBtnClicked(_ sender: Any) {
            print("selectEndpointBtnClicked")
            let endpointsMenu = UIAlertController(title: nil, message: "Choose Endpoint", preferredStyle: .actionSheet)
                
            let sharepointAction = UIAlertAction(title: "Sharepoint Online", style: .default, handler: {
                (action) -> Void in
                self.selectEndpointBtn.setTitle("Sharepoint Online", for: UIControl.State.normal)
            })
                
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
            
            endpointsMenu.addAction(sharepointAction)
            endpointsMenu.addAction(cancelAction)
            
            self.present(endpointsMenu, animated: true, completion: nil)
        }
        
        func Navigate(_ result: AuthResult? )
        {
            performSegue(withIdentifier: "tokendetailssegue", sender: result)
        }
        
        override func prepare(for segue: UIStoryboardSegue, sender: Any?)
        {
            if segue.destination is TokenDetailsViewController
            {
                let destinationVC = segue.destination as! TokenDetailsViewController
                if sender is AuthResult
                {
                    destinationVC.authResult = sender as? AuthResult
                }
            }
        }
        
        func acquireTokenSilently(_ account : MSALAccount!)
        {
            guard let applicationContext = self.applicationContext else { return }
            
            let parameters = MSALSilentTokenParameters(scopes: kScopes, account: account)
            
            applicationContext.acquireTokenSilent(with: parameters) { (result, error) in
                
                if let error = error {
                    
                    let nsError = error as NSError
                    
                    if (nsError.domain == MSALErrorDomain) {
                        
                        if (nsError.code == MSALError.interactionRequired.rawValue) {
                            
                            DispatchQueue.main.async {
                                self.acquireTokenInteractively()
                            }
                            return
                        }
                    }
                    
                    print("Could not acquire token silently: \(error)")
                    return
                }
                
                guard let result = result else {
                    
                    print("Could not acquire token: No result returned")
                    return
                }
                
                self.accessToken = result.accessToken
                print("Refreshed Access token is \(self.accessToken)")
    //            self.Navigate(result);
            }
        }
        
        func acquireTokenInteractively()
        {
            guard let applicationContext = self.applicationContext else { return }
            guard let webViewParameters = webViewParamaters else { return }
                
            // #1
            let parameters = MSALInteractiveTokenParameters(scopes: kScopes, webviewParameters: webViewParameters)
            parameters.promptType = .selectAccount
                
            // #2
            applicationContext.acquireToken(with: parameters) { (result, error) in
                    
                // #3
                if let error = error {
                        
                    print("Could not acquire token: \(error)")
                    return
                }
                    
                guard let result = result else {
                        
                    print("Could not acquire token: No result returned")
                    return
                }
                
                let converter = MSALResultToAuthResultConverter()
                let authResult : AuthResult = converter.convert(result: result)
                print("AuthResult : \(authResult.accessToken)")
                self.viewTokenBtn.isEnabled = true
                self.tokenStatusLabel.text = "Token received for \(result.account.username ?? "") that expires on \(result.expiresOn)"
                self.authResult = authResult
    //             self.Navigate(result);
            }
        }
        
        @IBAction func GetTokenBtnClicked(_ sender: Any)
        {
            print("GetTokenBtnClicked")
            loadCurrentAccount { (account) in

              guard let currentAccount = account else
              {
                  self.acquireTokenInteractively()
                  return
              }

              self.acquireTokenSilently(currentAccount)
            }
        }
        
        @IBAction func ViewTokenBtnClicked(_ sender: Any)
        {
            performSegue(withIdentifier: "tokendetailssegue", sender: self.authResult)
        }
}
