//
//  WkWebViewVC.swift
//  ClientCertificateAuth
//
//  Created by Anup Gupta on 23/03/22.
//

import UIKit
import WebKit
class WkWebViewVC: UIViewController, WKNavigationDelegate {

    var sslUrl : String = ""
    var isUseCertificate : Bool = false;
    var webView: WKWebView!
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let url = URL(string: sslUrl)!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }
    
    func webView(_: WKWebView, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        guard isUseCertificate else {
            completionHandler(.performDefaultHandling, .none)
            return
        }

        let method = challenge.protectionSpace.authenticationMethod

        switch method {
        case NSURLAuthenticationMethodClientCertificate:

            guard let credential = ClientCertificateDetails.urlCredential(for: Bundle.main.userCertificateForBadSSLWebsite) else {
                challenge.sender?.cancel(challenge)
                return completionHandler(.rejectProtectionSpace, .none)
            }

            return completionHandler(.useCredential, credential)

        default:
            completionHandler(.performDefaultHandling, .none)
        }
    }

}
