//
//  EatViewController.swift
//  filRouge
//
//  Created by Joris Thiery on 09/06/2021.
//

import UIKit
import MapKit
import Alamofire
import AlamofireImage

class EatViewController: UIViewController {

    
    @IBOutlet weak var testImage: UIImageView!
    
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var viewUnderTable: UIView!
    @IBOutlet weak var tableView: UITableView!
    var eats = [Resto()]
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Manger"
        EatService.shared.eats { eats in
            if let eats = eats {
                self.eats = eats
                print(eats.count)
                self.tableView.reloadData()
            }
            
        }
        if  let urlString = eats[0].image_url{
           if let url = URL(string: urlString){
            testImage.af.setImage(withURL: url)
         }
        }
  
        setupTableView()
    }
    
    func setupTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "EatTableViewCell", bundle: nil), forCellReuseIdentifier: "EatTableViewCell")
        tableView.backgroundColor = .gray
        
    }

}

extension EatViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(eats)
       return  eats.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EatTableViewCell", for: indexPath) as! EatTableViewCell
        cell.layer.cornerRadius = 8
        if  let urlString = eats[indexPath.row].image_url{
            let size = CGSize(width: 157, height: 198)
            let sizeRadius = RoundedCornersFilter(radius: 60)



            let filter = AspectScaledToFillSizeFilter(size: size)
           if let url = URL(string: urlString){
            cell.imageResto.af.setImage(withURL: url, filter: sizeRadius)
            
         }
        }
        
        cell.nomResto.text = eats[indexPath.row].alias?.uppercased()
        //print(cell.nomResto.text)
        cell.type.text = eats[indexPath.row].categories?[0].title
        cell.type.textColor = .red
        cell.type.sizeFont(10)
        cell.iconeLocalisation.image = UIImage(named: "endroit")
        
        cell.iconeEnter.image = UIImage(named: "icoArrowRightRose")
        cell.ville.text = eats[indexPath.row].location?.city
        
        return cell
    }
    
    
}

extension UILabel{
    func sizeFont(_ size: CGFloat){
        self.font = self.font.withSize(size)
    }
}
