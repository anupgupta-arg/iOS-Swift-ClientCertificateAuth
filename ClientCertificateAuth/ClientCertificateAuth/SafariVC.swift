//
//  SafariVC.swift
//  ClientCertificateAuth
//
//  Created by Anup Gupta on 23/03/22.
//

import UIKit
import SafariServices

class SafariVC: UIViewController, SFSafariViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
    

}
