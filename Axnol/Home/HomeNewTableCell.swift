//
//  HomeNewTableCell.swift
//  Axnol
//
//  Created by TORVIS on 24/01/21.
//

import UIKit
import Alamofire
import SDWebImage

class HomeNewTableCell: UITableViewCell {
    
    let urlBuySellList = "http://thescriptstore.in/api/buy_sell_list"
    
    var status_ = String()
    var sell_ = NSArray()
    let something = NSArray()
    var title_ = [String]()
    var location_ = [String]()
    var price_ = [String]()
    var featured_image_ = [String]()
    
    @IBOutlet weak var lblOutlet: UILabel!
    @IBOutlet weak var btnRightArrow: UIButton!
    @IBOutlet weak var btnLeftArrow: UIButton!
    @IBOutlet weak var collectionVw: UICollectionView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        apiCallVerifyMobile()
        
        btnLeftArrow.layer.cornerRadius = 15
        btnLeftArrow.backgroundColor = #colorLiteral(red: 0.8700578809, green: 0.8863193989, blue: 0.8904320002, alpha: 1)
        btnRightArrow.layer.cornerRadius = 15
        btnRightArrow.backgroundColor = #colorLiteral(red: 0.8700578809, green: 0.8863193989, blue: 0.8904320002, alpha: 1)
        clipsToBounds = true
        
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

            self.collectionVw.reloadData()
            
        }
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        collectionVw.dataSource = self
        collectionVw.delegate = self
    }
    
    
    func moveCollectionToFrame(contentOffset : CGFloat) {

               let frame: CGRect = CGRect(x : contentOffset ,y : self.collectionVw.contentOffset.y ,width : self.collectionVw.frame.width,height : self.collectionVw.frame.height)
               self.collectionVw.scrollRectToVisible(frame, animated: true)
           }

    
    @IBAction func didTapScrollLeft(_ sender: UIButton) {
        
        let collectionBounds = self.collectionVw.bounds
                   let contentOffset = CGFloat(floor(self.collectionVw.contentOffset.x - collectionBounds.size.width))
                   self.moveCollectionToFrame(contentOffset: contentOffset)

    }
    
    @IBAction func didTapScrollRight(_ sender: UIButton) {
        
        let collectionBounds = self.collectionVw.bounds
               let contentOffset = CGFloat(floor(self.collectionVw.contentOffset.x + collectionBounds.size.width))
               self.moveCollectionToFrame(contentOffset: contentOffset)

    }
    
}

extension HomeNewTableCell:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return title_.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeNewCollectionCell", for: indexPath)as! HomeNewCollectionCell
        
        //⚠️⚠️⚠️⚠️Write condition here to show that tag like in the photo
        cell.lblContent.text = "\(self.title_[indexPath.item])"
        
        cell.imgContent.sd_setImage(with: URL(string: "\(featured_image_[indexPath.item])"), placeholderImage:#imageLiteral(resourceName: "Graph img"))
        
        cell.lblPlace.text = "\(self.location_[indexPath.item])"
        
        cell.lblPrice.text = "$" + "\(self.price_[indexPath.item])"
        
        cell.shadowVw.layer.cornerRadius = 8
        cell.shadowVw.layer.masksToBounds = true
        cell.shadowVw.layer.masksToBounds = false
        cell.shadowVw.layer.shadowOffset = CGSize(width: 0, height: 0)//CGSizeMake(0, 0)
        cell.shadowVw.layer.shadowColor = UIColor.black.cgColor
        cell.shadowVw.layer.shadowOpacity = 0.23
        cell.shadowVw.layer.shadowRadius = 4

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: 228, height: 259)
        return CGSize(width: 181, height: 240)

    }
    
}
