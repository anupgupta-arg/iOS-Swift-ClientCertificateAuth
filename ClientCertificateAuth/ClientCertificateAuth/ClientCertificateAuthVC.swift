//
//  ClientCertificateAuthVC.swift
//  ClientCertificateAuth
//
//  Created by Anup Gupta on 23/03/22.
//

import UIKit

class ClientCertificateAuthVC: UIViewController {
    
    @IBOutlet weak var urlTextField: UITextField!
    @IBOutlet weak var segementControl: UISegmentedControl!
    @IBOutlet weak var certificateSwitch: UISwitch!
    @IBOutlet weak var goButton: UIButton!
    var selectedNavLink = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        urlTextField.text = "https://client.badssl.com/";
        
    }
    
    @IBAction func segementSelection(_ sender: Any) {
        
        switch segementControl.selectedSegmentIndex {
            case 0:
                print("URL Session");
                
            case 1:
                print("Web View");
                
            case 2:
                print("Safari VC");
                
            case 3:
                print("Browser");
                
            default:
                print("default");
        }
    }
    
    @IBAction func goButtonAction(_ sender: Any) {
        switch segementControl.selectedSegmentIndex {
            case 0:
                print(" open URL Session");
                
                let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
                let vc = storyBoard.instantiateViewController(identifier: "URLSessionVCID") as! URLSessionVC
                vc.isUseCertificate = certificateSwitch.isOn ? true : false;
                vc.sslUrl = urlTextField.text!;
                navigationController?.pushViewController(vc, animated: true);
            case 1:
                print("open Web View");
                
                let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
                let vc = storyBoard.instantiateViewController(identifier: "WkWebViewVCID") as! WkWebViewVC
                vc.isUseCertificate = certificateSwitch.isOn ? true : false;
                vc.sslUrl = urlTextField.text!;
                navigationController?.pushViewController(vc, animated: true);
                
            case 2:
                print("Open Safari VC");
                
            case 3:
                print("open Browser");
                
            default:
                print("open default nothing ");
        }
        
    }
    
}
