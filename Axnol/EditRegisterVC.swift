//
//  EditRegisterVC.swift
//  Axnol
//
//  Created by TORVIS on 22/01/21.
//

import UIKit
import Alamofire
import SkyFloatingLabelTextField

class EditRegisterVC: UIViewController {
    
    let urlSignup = "http://thescriptstore.in/api/sign_up"
    
    var message = String()
    
    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var txtMobileNumber: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var btnRegister: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnRegister.layer.cornerRadius = 30
        btnRegister.clipsToBounds = true
    }
    
    func apiCallSignup(){
        
        let parameterSignup = ["first_name":"\(txtFirstName.text!)",
                               "service_id":"1",
                               "mail":"\(txtEmail.text!)",
                               "phone":"\(txtMobileNumber.text!)",
                               "password": "\(txtPassword.text!)",
                               "confirm_password":"\(txtPassword.text!)",
                               "is_terms": "1",
                               "user_type": "3",
                               "Phone_code":"+91"]
        
        Alamofire.request(urlSignup, method: .post, parameters: parameterSignup, encoding: JSONEncoding.default, headers: nil).responseJSON { (response_) in
            let apiResponse = response_.result.value as! NSDictionary
            
            self.message = apiResponse.value(forKey: "msg")as? String ?? ""
            
            if self.message == "Registered Successfully" {
                let alert = UIAlertController(title: "Alert", message: "\(self.message)", preferredStyle: .alert)
                
                let okButton = UIAlertAction(title: "Ok", style: .cancel) { (obj) in
                    let nav = self.storyboard?.instantiateViewController(identifier: "RegisterVC")as! RegisterVC
                    self.navigationController?.pushViewController(nav, animated: true)
                }
                
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
    
            } else {
                let alert = UIAlertController(title: "Alert", message: "\(self.message)", preferredStyle: .alert)
                
                let okButton = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
            }
            
            
            
            print("✅✅✅✅✅✅✅✅✅✅\(apiResponse)✅✅✅✅✅✅✅✅✅✅")
        }
        
        
        
    }

    @IBAction func didTapRegister(_ sender: UIButton) {
        
        if txtFirstName.text != "" && txtMobileNumber.text != "" && txtEmail.text != "" && txtPassword.text != "" {
            apiCallSignup()
        } else {
            let alert = UIAlertController(title: "Alert", message: "Please Enter all the fields", preferredStyle: .alert)
            
            let okButton = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            
            alert.addAction(okButton)
            self.present(alert, animated: true, completion: nil)
            
        }
    }
    @IBAction func didTapLogin(_ sender: UIButton) {
        let nav = self.storyboard?.instantiateViewController(identifier: "RegisterUsingMobileVC")as! RegisterUsingMobileVC
        self.navigationController?.pushViewController(nav, animated: true)
    }
}
