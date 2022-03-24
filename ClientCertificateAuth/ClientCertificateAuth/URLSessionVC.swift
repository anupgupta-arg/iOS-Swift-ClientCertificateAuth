//
//  URLSessionVC.swift
//  ClientCertificateAuth
//
//  Created by Anup Gupta on 23/03/22.
//

import UIKit

class URLSessionVC: UIViewController {
    
    @IBOutlet weak var resultLabel: UILabel!
    var sslUrl : String = ""
    var isUseCertificate : Bool = false;
    override func viewDidLoad()  {
        super.viewDidLoad()
        
        Task {
            await loadData();
        }
        
    }
    
    
    func loadData() async{
        
        let result = await sendHTTPRequest(URL(string: sslUrl)!, useCertificate: isUseCertificate)
        print("Reslut >> ", result);
        
        DispatchQueue.main.async {
            self.resultLabel.text = result;
        }
        
    }
    
    func sendHTTPRequest(_ url: URL, useCertificate: Bool) async -> String {
        let session = URLSession(configuration: .default, delegate: useCertificate ? URLSesionClientCertificateHandling() : nil, delegateQueue: nil)
        do {
            let (_, response) = try await session.data(from: url, delegate: nil)
            guard let httpResponse = response as? HTTPURLResponse else { return "" }
            return "HTTP Status Code \(httpResponse.statusCode)"
        } catch {
            return error.localizedDescription
        }
    }
}

public class URLSesionClientCertificateHandling: NSObject, URLSessionDelegate {
    public func urlSession(_: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        guard challenge.protectionSpace.authenticationMethod
                == NSURLAuthenticationMethodClientCertificate
        else {
            completionHandler(.performDefaultHandling, nil)
            return
        }
        
        guard let credential = ClientCertificateDetails.urlCredential(for: Bundle.main.userCertificateForBadSSLWebsite) else {
            completionHandler(.performDefaultHandling, nil)
            return
        }
        
        challenge.sender?.use(credential, for: challenge)
        completionHandler(.useCredential, credential)
    }
}
