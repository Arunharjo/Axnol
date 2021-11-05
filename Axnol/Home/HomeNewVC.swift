//
//  HomeNewVC.swift
//  Axnol
//
//  Created by TORVIS on 24/01/21.
//

import UIKit

class HomeNewVC: UIViewController {

    @IBOutlet weak var btnSideMenu: UIButton!
    @IBOutlet weak var tbleVw: UITableView!
    
    var headingArray = ["BUY SELL Ads", "Service Ads", "BUY SELL Ads", "Service Ads"]

    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    @IBAction func didTapSideMenu(_ sender: UIButton) {
        btnSideMenu.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        
        revealViewController().rearViewRevealWidth = 275
        
        view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
    }
}

extension HomeNewVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return headingArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeNewTableCell")as! HomeNewTableCell
        cell.lblOutlet.text = "\(headingArray[indexPath.row])"
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 321
    }
    
}
