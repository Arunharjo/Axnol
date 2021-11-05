//
//  OTPVerificationVC.swift
//  Axnol
//
//  Created by TORVIS on 22/01/21.
//

import UIKit
import Firebase
import SkyFloatingLabelTextField

class OTPVerificationVC: UIViewController {

    
    @IBOutlet weak var btnVerifyOTP: UIButton!
    //Constants
    
    let userDefault = UserDefaults.standard
    
    
    @IBOutlet weak var txtOTPCode: SkyFloatingLabelTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnVerifyOTP.layer.cornerRadius = 30
        btnVerifyOTP.clipsToBounds = true

    }
    @IBAction func didTapVerifyOTP(_ sender: UIButton) {
     //   let nav = self.storyboard?.instantiateViewController(identifier: "EditRegisterVC")as! EditRegisterVC
    //    self.navigationController?.pushViewController(nav, animated: true)

        guard let otpCode = txtOTPCode.text else { return }
        
        guard let verificationId = userDefault.string(forKey: "verificationId") else { return }
        
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationId, verificationCode: otpCode)
        
        Auth.auth().signInAndRetrieveData(with: credential) { (success, error) in
            if error == nil {
                let alert = UIAlertController(title: "Login Success!", message: nil, preferredStyle: .alert)
                
                let okButton = UIAlertAction(title: "Ok", style: .cancel) { (obj) in
                    print(success)
                    print("User Signed in...")
                    //Perform segue to signedVC
                      let nav = self.storyboard?.instantiateViewController(identifier: "HomeNewVC")as! HomeNewVC
                    self.navigationController?.pushViewController(nav, animated: true)
                    
                }
                
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
                
        
            } else {
                print("Something went wrong...\(error?.localizedDescription)")
                let alert = UIAlertController(title: "\(error!.localizedDescription)", message: nil, preferredStyle: .alert)
                
                let okButton = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
            }
        }
        
        
    }
    @IBAction func didTapLogin(_ sender: UIButton) {
        let nav = self.storyboard?.instantiateViewController(identifier: "RegisterUsingMobileVC")as! RegisterUsingMobileVC
        self.navigationController?.pushViewController(nav, animated: true)
    }
}
