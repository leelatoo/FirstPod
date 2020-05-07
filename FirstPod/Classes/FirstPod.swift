//
//  FirstPod.swift
//  FirstPod
//
//  Created by Leeladevi Balasundaram on 5/5/20.
//

import UIKit

public class FirstPod: NSObject
{
    public static var kClientID = "852e8054-ba53-4814-ae1c-6901166d0a06"
    public static var kGraphEndpoint = "https://sites.ey.com"
    public static var kAuthority = "https://login.microsoftonline.com/5b973f99-77df-4beb-b27d-aa0c70b8482c/"
    public static var kScopes: [String] = ["user.read"]
    public static var redirectUri = "msauth.com.eygsl.ctmob.xformsrefdebug"
    
    public static func performSegueToFirspodEntryViewController(caller: UIViewController)
    {
         let frameworkBundle = Bundle(for: Logger.self)
         let path = frameworkBundle.path(forResource: "Resources", ofType: "bundle")
         let resourcesBundle = Bundle(url: URL(fileURLWithPath: path!))

         let storyboard = UIStoryboard(name: "TokenGenerator", bundle: resourcesBundle)
         let vc = storyboard.instantiateViewController(withIdentifier: "DeveloperOptionsVC")
         caller.show(vc, sender: nil)
    }
}
