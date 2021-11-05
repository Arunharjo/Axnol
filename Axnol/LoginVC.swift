//
//  LoginVC.swift
//  Axnol
//
//  Created by TORVIS on 22/01/21.
//

import UIKit
import Alamofire
import SkyFloatingLabelTextField


class LoginVC: UIViewController {
    
    let urlVerifyMobile = "http://thescriptstore.in/api/verify_mobile"

    @IBOutlet weak var txtMobileNumber: SkyFloatingLabelTextField!
    @IBOutlet weak var btnLogin: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnLogin.layer.cornerRadius = 25
        btnLogin.clipsToBounds = true
    }
    
    func apiCallVerifyMobile(){
        let parameterVerifyMobile = ["phone": "\(txtMobileNumber.text!)" ]
        
        Alamofire.request(urlVerifyMobile, method: .post, parameters: parameterVerifyMobile, encoding: JSONEncoding.default, headers: nil).responseJSON { (response_) in
            let apiResponse = response_.result.value as! NSDictionary
            print("🥶🥶🥶🥶🥶🥶🥶🥶\(apiResponse)🥶🥶🥶🥶🥶🥶🥶🥶")
        }
        
        
    }
    
    @IBAction func didTapLogin(_ sender: UIButton) {
        let nav = self.storyboard?.instantiateViewController(identifier: "HomeNewVC")as! HomeNewVC
        self.navigationController?.pushViewController(nav, animated: true)
        apiCallVerifyMobile()
    }
}
