//
//  PresentManager.swift
//  FirstTable
//
//  Created by Harapriya on 26/04/23.
//

import UIKit
import Foundation

final class PresentManager {
    
    static func jumpToVC<T: UIViewController>(storyboard: String, from viewController: UIViewController, withVCClass VCClass: T.Type, andData data: Any?) {
        let storyboard = UIStoryboard(name: storyboard, bundle: nil)
        let VC = storyboard.instantiateViewController(withIdentifier: String(describing: VCClass)) as! T
        VC.modalTransitionStyle = .crossDissolve
        VC.modalPresentationStyle = .fullScreen
        if let data = data, var dataReceiverVC = VC as? DataReceiver {
            dataReceiverVC.receivedData = data
        }
        viewController.present(VC, animated: true, completion: nil)
    }
    
    static func segue(vc: UIViewController, identifier: String) {
        vc.performSegue(withIdentifier: "ShowTest", sender: nil)
    }
}

protocol DataReceiver {
    var receivedData: Any? { get set }
}
