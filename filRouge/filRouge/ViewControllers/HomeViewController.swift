//
//  HomeViewController.swift
//  filRouge
//
//  Created by Joris Thiery on 09/06/2021.
//

import UIKit

struct HomeItems {
    var image: UIImage?
    var label: String
    var redirectTab: Int
}

class HomeViewController: UIViewController {

    @IBOutlet weak var collectionItems: UICollectionView!
    @IBOutlet weak var pager: UIPageControl!
    @IBOutlet weak var imgCharacter: UIImageView!
    @IBOutlet weak var imgBubble: UIImageView!
    @IBOutlet weak var bubbleView: UIView!
    @IBOutlet weak var lblHello: UILabel!
    @IBOutlet weak var lblName: UILabel!
    
    private var currentPage: Int = 0 // index of current item in collectionView
    private var items: [HomeItems] = [] // list of items for collectionView
    private var collectionViewFlowLayout: UICollectionViewFlowLayout? { // collectioViewLayout
        return self.collectionItems.collectionViewLayout as? UICollectionViewFlowLayout
    }
    
    // turn status bar to white
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setInterface()
        setLabel()
    }
    
    private func setInterface() {
        self.view.backgroundColor = .darkblue
        
        // rotate image of character and bubble
        self.imgCharacter.transform = CGAffineTransform(rotationAngle: -(.pi/6))
        self.imgBubble.transform = CGAffineTransform(rotationAngle: -(.pi/2))
        
        self.bubbleView.layer.cornerRadius = 20
        self.pager.currentPageIndicatorTintColor = .pink
    }
    
    private func setLabel() {
        self.lblName.text = NSLocalizedString("home_name", comment: "")
        self.lblName.textColor = .pink
        
        self.lblHello.text = NSLocalizedString("home_hello", comment: "")
        self.lblHello.textColor = .middleBlue
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        defineCollectionView()
        defineCells()
    }
    
    private func defineCells() {
        items.removeAll()
        
        items.append(HomeItems(image: UIImage(named: "bgWolf"),
                               label: NSLocalizedString("home_item_eat", comment: ""),
                               redirectTab: 1))
        items.append(HomeItems(image: UIImage(named: "bgClown"),
                               label: NSLocalizedString("home_item_happy", comment: ""),
                               redirectTab: 2))
        items.append(HomeItems(image: UIImage(named: "bgTree"),
                               label: NSLocalizedString("home_item_move", comment: ""),
                               redirectTab: 3))
        
        self.collectionItems.reloadData()
        configureCollectionViewLayoutItemSize()
    }
    
    @IBAction func pageValueChanged(_ sender: Any) {
        // scroll to item
        let indexPath = IndexPath(row: self.pager.currentPage, section: 0)
        collectionViewFlowLayout?.collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        
        self.currentPage = pager.currentPage
    }
}

extension HomeViewController {
    // get index of the nearest cell
    private func indexOfMajorCell() -> Int {
        let itemWidth = collectionViewFlowLayout?.itemSize.width ?? 0
        let proportionalOffset = (collectionViewFlowLayout?.collectionView?.contentOffset.x ?? 0) / itemWidth
        let index = Int(round(proportionalOffset))
        let numberOfItems = collectionItems.numberOfItems(inSection: 0)
        let safeIndex = max(0, min(numberOfItems - 1, index))
        return safeIndex
    }
    
    // calcul item size -> all collectionwidth - 50px margin left - 50px margin right
    private func configureCollectionViewLayoutItemSize() {
        let inset: CGFloat = 50
        collectionViewFlowLayout?.sectionInset = UIEdgeInsets(top: 0, left: inset, bottom: 0, right: inset)
        
        collectionViewFlowLayout?.itemSize = CGSize(width: (self.collectionViewFlowLayout?.collectionView?.frame.size.width ?? 0) - inset * 2,
                                                    height: collectionViewFlowLayout?.collectionView?.frame.size.height ?? 0)
    }
    
    private func defineCollectionView() {
        self.collectionItems.backgroundColor = .clear
        self.collectionItems.delegate = self
        self.collectionItems.dataSource = self
        
        // define horizontal scroll without indicator
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        self.collectionItems.collectionViewLayout = layout
        self.collectionItems.showsHorizontalScrollIndicator = false
        
        // register custom cell
        self.collectionItems.register(UINib(nibName: HomeItemCollectionViewCell.reuseIdentifier, bundle: nil),
                                      forCellWithReuseIdentifier: HomeItemCollectionViewCell.reuseIdentifier)
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeItemCollectionViewCell.reuseIdentifier, for: indexPath) as? HomeItemCollectionViewCell {
            cell.defineCell(with: items[indexPath.row])
            cell.delegate = self
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        // Stop scrollView sliding:
        targetContentOffset.pointee = scrollView.contentOffset
        
        // calculate where collectionView should snap to:
        let indexOfMajorCell = self.indexOfMajorCell()

        // scroll to item
        let indexPath = IndexPath(row: indexOfMajorCell, section: 0)
        collectionViewFlowLayout?.collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        
        //update pager
        self.pager.currentPage = indexPath.row
        self.currentPage = pager.currentPage
    }
}

extension HomeViewController: HomeItemCellDelegate {
    func redirectTab(index: Int) {
        // change tab when user select an item
        self.tabBarController?.selectedIndex = index
    }
}
