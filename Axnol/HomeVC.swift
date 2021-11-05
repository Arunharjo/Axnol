//
//  HomeVC.swift
//  Axnol
//
//  Created by TORVIS on 23/01/21.
//

import UIKit
import Alamofire
import SDWebImage

class HomeVC: UIViewController {
    
    let urlBuySellList = "http://thescriptstore.in/api/buy_sell_list"
    
    var status_ = String()
    var sell_ = NSArray()
    let something = NSArray()
    var title_ = [String]()
    var location_ = [String]()
    var price_ = [String]()
    var featured_image_ = [String]()
    
    @IBOutlet weak var VwCollection: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        apiCallVerifyMobile()
    }
    
    func apiCallVerifyMobile(){
        let parameterBuySellList = ["token":"16102001975ff9b4851a2ed",
                                    "user_id":"5" ]
        
        Alamofire.request(urlBuySellList, method: .post, parameters: parameterBuySellList, encoding: JSONEncoding.default, headers: nil).responseJSON { (response_) in
            let apiResponse = response_.result.value as! NSDictionary
            
            self.status_ = apiResponse.value(forKey: "status")as! String
            
            
            print("Status = \(self.status_) \n\n")
            
            self.sell_ = apiResponse.value(forKey: "sell") as! NSArray
 
//            print("Sell = \(self.sell_) \n\n")
            
            self.title_ = self.sell_.value(forKey: "title") as! [String]
            
            print("title_ = \(self.title_) \n\n")
            
            self.featured_image_ = self.sell_.value(forKey: "featured_image") as! [String]
            self.price_ = self.sell_.value(forKey: "price") as! [String]
            self.location_ = self.sell_.value(forKey: "location") as! [String]

            self.VwCollection.reloadData()
            
        }
        
    }
}
    
    extension HomeVC:UICollectionViewDelegate,UICollectionViewDataSource{
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return title_.count
        }

        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCell", for: indexPath)as! HomeCell
            
            cell.lblContent.text = "\(self.title_[indexPath.item])"
            
            cell.imgContent.sd_setImage(with: URL(string: "\(featured_image_[indexPath.item])"), placeholderImage:#imageLiteral(resourceName: "Graph img"))
            
            cell.lblPlace.text = "\(self.location_[indexPath.item])"
            
            cell.lblPrice.text = "\(self.price_[indexPath.item])"

            
            
            
            return cell
        }


    }
