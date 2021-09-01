//
//  CustomTabBarController.swift
//  filRouge
//
//  Created by Joris Thiery on 09/06/2021.
//

import UIKit

class CustomTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        tabBar.barTintColor = .darkblue
        tabBar.tintColor = .pink

        let homeItem = tabBar.items!.first!
        let eatItem = tabBar.items![1]
        let smileItem = tabBar.items![2]
        let moveItem = tabBar.items![3]

        homeItem.title = "Accueil"
        homeItem.image = UIImage(named: "ico_house_white")

        eatItem.title = "Manger"
        eatItem.image = UIImage(named: "ico_pizza_white")

        smileItem.title = "Rigoler"
        smileItem.image = UIImage(named: "ico_laugh_white")

        moveItem.title = "Bouger"
        moveItem.image = UIImage(named: "ico_car_white")
    }

}
