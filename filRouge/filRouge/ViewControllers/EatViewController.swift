//
//  EatViewController.swift
//  filRouge
//
//  Created by Joris Thiery on 09/06/2021.
//

import UIKit
import MapKit

class EatViewController: UIViewController {

    
    
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
            }
            
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
/*extension EatViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    
}*/
