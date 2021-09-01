//
//  HomeItemCollectionViewCell.swift
//  filRouge
//
//  Created by Anthony on 02/07/2021.
//

import UIKit

protocol HomeItemCellDelegate: AnyObject {
    func redirectTab(index: Int)
}

class HomeItemCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = String(describing: HomeItemCollectionViewCell.self)

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imgIcon: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    
    weak var delegate: HomeItemCellDelegate?
    private var homeItem: HomeItems?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        defineView()
        defineLabel()
    }
    
    private func defineView() {
        self.containerView.layer.cornerRadius = 30
        self.backgroundColor = .clear
    }
    
    private func defineLabel() {
        self.lblTitle.textColor = .middleBlue
    }
    
    func defineCell(with homeItem: HomeItems) {
        self.homeItem = homeItem
        self.imgIcon.image = homeItem.image
        self.lblTitle.text = homeItem.label
    }

    @IBAction func btnGoToTouched(_ sender: Any) {
        if let tab = homeItem?.redirectTab {
            self.delegate?.redirectTab(index: tab)
        }
    }
}
