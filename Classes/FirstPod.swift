//
//  FirstPod.swift
//  FirstPod
//
//  Created by Leeladevi Balasundaram on 5/5/20.
//

import UIKit

public class FirstPod: NSObject
{
    public func performSegueToFirspodEntryViewController(caller: UIViewController)
    {
        let storyboard = UIStoryboard(name: "TokenGenerator", bundle: Bundle(for: DeveloperOptionsViewController.self))
        let vc = storyboard.instantiateViewController(withIdentifier: "DeveloperOptionsVC")
        caller.show(vc, sender: nil)
    }
}
