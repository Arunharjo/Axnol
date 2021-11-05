//
//  SidemenuTableC.swift
//  Axnol
//
//  Created by TORVIS on 24/01/21.
//

import UIKit

class SideMenuTableVC: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuSetup()
    }
    
    func menuSetup() {
        if self.revealViewController() != nil {
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
      
        let revealViewController:SWRevealViewController = self.revealViewController()

               if indexPath.row == 0 {
                
                let alert = UIAlertController(title: "Are you sure you want to logout?", message: nil, preferredStyle: .alert)
                
                
                let yesButton = UIAlertAction(title: "Yes", style: .destructive) { (obj) in
                    let mainStoryBoard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let desViewController = mainStoryBoard.instantiateViewController(withIdentifier: "RegisterVC") as! RegisterVC
                    let newFrontViewController = UINavigationController.init(rootViewController:desViewController)
                    revealViewController.pushFrontViewController(newFrontViewController, animated: true)

                }
                
                let noButton = UIAlertAction(title: "No", style: .cancel, handler: nil)
                alert.addAction(yesButton)
                alert.addAction(noButton)
                self.present(alert, animated: true, completion: nil)
  
               }
  
    }
    
    
}
