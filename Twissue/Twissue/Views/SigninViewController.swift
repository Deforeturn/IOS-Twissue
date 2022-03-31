//
//  LoginViewController.swift
//  Twissue
//
//  Created by Deforeturn on 2/14/22.
//

import UIKit
import OAuthSwift
import FirebaseAuth

//MARK: - Circle
class SigninViewController: UIViewController {
    var signBackCV:SigninBackgroundViewController!
    let provider = OAuthProvider(providerID: "twitter.com")
    
    @IBOutlet var loginBtn:UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.isModalInPresentation = true
        self.loginBtn.layer.cornerRadius = 12.5
        self.loginBtn.clipsToBounds = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
}


//MARK: - Custom
extension SigninViewController{
    @IBAction func loginBtnAction(_ sender:UIButton){
        self.provider.getCredentialWith(nil) { credential, error in
            if error != nil {print(error!)}
            if credential != nil {
                Auth.auth().signIn(with: credential!) { authResult, error in
                    if error != nil {print(error as Any)}
                    if let credent = authResult?.credential as? OAuthCredential{
                        UserDefaults.standard.setValue(credent.accessToken!, forKey: "oauthToken")
                        UserDefaults.standard.setValue(credent.secret!, forKey: "oauthTokenSecret")
                        self.dismiss(animated: true, completion: nil)
                        self.signBackCV.signinCheck()
                    }
                }
            }
        }
    }
}
