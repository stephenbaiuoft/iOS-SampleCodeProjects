//
//  VillainCollectionViewController.swift
//  BondVillains
//
//  Created by Gabrielle Miller-Messner on 2/3/15.
//  Copyright (c) 2015 Udacity. All rights reserved.
//

import Foundation
import UIKit

// MARK: - VillainCollectionViewController: UICollectionViewController

class VillainCollectionViewController: UICollectionViewController {
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    var numCell: CGFloat = 3.0
    var space: CGFloat = 3.0
    
    // MARK: Properties
    func initFlowLayout(viewSize: CGFloat, _ isLanscape:Bool){
        var numCellTmp = numCell
        if(isLanscape){
            numCellTmp = numCellTmp * 2
        }
        
        let cellSize = ( viewSize - (2 * space)) / numCellTmp
        
        flowLayout.minimumLineSpacing = space
        flowLayout.minimumInteritemSpacing = space
        flowLayout.itemSize = CGSize(width: cellSize, height: cellSize)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator){
        let isLanscape = size.width > size.height
        initFlowLayout(viewSize: size.width, isLanscape )
        
    }
    // TODO: Add outlet to flowLayout here.
    
    // Get ahold of some villains, for the table
    // This is an array of Villain instances
    let allVillains = Villain.allVillains
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initFlowLayout(viewSize: (self.view.frame.width < self.view.frame.height) ? self.view.frame.width : self.view.frame.height, self.view.frame.width > self.view.frame.height)
//        initFlowLayout(viewSize: self.view.frame.width)
        
        //TODO: Implement flowLayout here.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    // MARK: Collection View Data Source
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.allVillains.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VillainCollectionViewCell", for: indexPath) as! VillainCollectionViewCell
        let villain = self.allVillains[(indexPath as NSIndexPath).row]
        
        // Set the name and image
        cell.nameLabel.text = villain.name
        cell.villainImageView?.image = UIImage(named: villain.imageName)
        //cell.schemeLabel.text = "Scheme: \(villain.evilScheme)"
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath:IndexPath) {
        
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "VillainDetailViewController") as! VillainDetailViewController
        detailController.villain = self.allVillains[(indexPath as NSIndexPath).row]
        self.navigationController!.pushViewController(detailController, animated: true)
        
    }
}
