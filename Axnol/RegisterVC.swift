//
//  RegisterVC.swift
//  Axnol
//
//  Created by TORVIS on 21/01/21.
//

import UIKit

class RegisterVC: UIViewController {

    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnSignup: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        btnLogin.layer.cornerRadius = 30
        btnLogin.clipsToBounds = true

        btnSignup.layer.cornerRadius = 30
        btnLogin.clipsToBounds = true
        btnSignup.layer.borderWidth = 4.0
        btnSignup.layer.borderColor = #colorLiteral(red: 0.9921568627, green: 0.5019607843, blue: 0, alpha: 1)

    }
    
    @IBAction func didTapLogin(_ sender: UIButton) {
        /*
        let nav = self.storyboard?.instantiateViewController(identifier: "RegisterUsingMobileVC")as! RegisterUsingMobileVC
        self.navigationController?.pushViewController(nav, animated: true)
        */
        let nav = self.storyboard?.instantiateViewController(identifier: "HomeNewVC")as! HomeNewVC
      self.navigationController?.pushViewController(nav, animated: true)
    }
    
    @IBAction func didTapSignup(_ sender: UIButton) {
        let nav = self.storyboard?.instantiateViewController(identifier: "EditRegisterVC")as! EditRegisterVC
        self.navigationController?.pushViewController(nav, animated: true)
        
        
    }
}
