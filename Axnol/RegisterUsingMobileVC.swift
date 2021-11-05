//
//  RegisterUsingMobileVC.swift
//  Axnol
//
//  Created by TORVIS on 22/01/21.
//

import UIKit
import Alamofire
import SkyFloatingLabelTextField
import Firebase

class RegisterUsingMobileVC: UIViewController {
    
    //Constants
    let userDefault = UserDefaults.standard
    
    let urlVerifyMobile = "http://thescriptstore.in/api/verify_mobile"

    @IBOutlet weak var txtMobileNumber: SkyFloatingLabelTextField!
    @IBOutlet weak var btnSendOTP: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnSendOTP.layer.cornerRadius = 30
        btnSendOTP.clipsToBounds = true

    }
    
    func apiCallVerifyMobile(){
        let parameterVerifyMobile = ["phone": "\(txtMobileNumber.text!)" ]
        
        Alamofire.request(urlVerifyMobile, method: .post, parameters: parameterVerifyMobile, encoding: JSONEncoding.default, headers: nil).responseJSON { (response_) in
            let apiResponse = response_.result.value as! NSDictionary
            print("😢😢😢😢😢😢😢😢😢😢😢😢\(apiResponse)😢😢😢😢😢😢😢😢😢😢😢")
        }
        
    }
    
    func Navigation(){
        let nav = self.storyboard?.instantiateViewController(identifier: "OTPVerificationVC")as! OTPVerificationVC
        self.navigationController?.pushViewController(nav, animated: true)
    }
    
    @IBAction func didTapSendOTP(_ sender: UIButton) {
     //   apiCallVerifyMobile()
        
        guard let phoneNumber = txtMobileNumber.text else { return }
        
       // let phoneNumber =  "+91" + "\(txtMobileNumber.text!)"
        
        
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { (verificationId, error) in
            if error == nil {
                //Do Something
               
                
                let alert = UIAlertController(title: "OTP is sent to your Mobile number", message: nil, preferredStyle: .alert)
                                
                let okButton = UIAlertAction(title: "Ok", style: .cancel) { (obj) in
                    print("🤡🤡🤡🤡🤡🤡🤡🤡🤡")
                    print(verificationId!)
                    print("🤡🤡🤡🤡🤡🤡🤡🤡🤡")
                    guard let verifyId = verificationId  else { return }
                    self.userDefault.setValue(verifyId, forKey: "verificationId")
                    self.userDefault.synchronize()
                    self.Navigation()
                }
                
                
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
                
                
                
            } else {
                print("Unable to get secret verification code from Firebase", error?.localizedDescription)
                
                if error!.localizedDescription == "Invalid format." {
                    let alert = UIAlertController(title: "\(error!.localizedDescription)\n\n Note:Please Enter your Mobile number followed by +91", message: nil, preferredStyle: .alert)
                    
                    let okButton = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                    
                    alert.addAction(okButton)
                    self.present(alert, animated: true, completion: nil)
                }else {
                    let alert = UIAlertController(title: "\(error!.localizedDescription)", message: nil, preferredStyle: .alert)
                    
                    let okButton = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                    
                    alert.addAction(okButton)
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
    @IBAction func didTapHome(_ sender: UIButton) {
        let nav = self.storyboard?.instantiateViewController(identifier: "RegisterVC")as! RegisterVC
        self.navigationController?.pushViewController(nav, animated: true)
        
    }
}
