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

class VillainCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    
    // MARK: Properties
    
    // TODO: Add outlet to flowLayout here.
    
    // Get ahold of some villains, for the table
    // This is an array of Villain instances
    let allVillains = Villain.allVillains
    var widthPerItem:CGFloat = 0.0
    
    let cellSpace:CGFloat = 10.0
    var sectionInsets: UIEdgeInsets!
    let itemsPerRow: CGFloat = 3
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //TODO: Implement flowLayout here.
        
        sectionInsets = UIEdgeInsets(top: cellSpace, left: cellSpace, bottom: cellSpace, right: cellSpace)
        flowLayout.sectionInset = sectionInsets
        setEqualSpacing(size: self.view.frame.width, ratio: 0.5)
    }
    
    // if should re-set for lanscape mode
    func setEqualSpacing( size: CGFloat, ratio: CGFloat ){
        
        let xNum:CGFloat = 3.0
        var dimension:CGFloat = 0.0
        // portrait
        if(ratio < 1){
            dimension = (size - cellSpace * (xNum + 2 )) / xNum
        }
        // lanscape
        else{
            var yNum = xNum * ratio
            yNum.round(FloatingPointRoundingRule.down)
            print("yNum is: ", yNum)
            dimension = (size - cellSpace * (yNum + 2)) / yNum
        }

        flowLayout.minimumInteritemSpacing = cellSpace
        flowLayout.minimumLineSpacing = cellSpace
        flowLayout.itemSize = CGSize(width: dimension, height: dimension)
        
        
        print("dimension: ", dimension)
        print("Finished: In EqualSpacing")
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        if(UIDevice.current.orientation.isLandscape){
            print("Current Lanscape ")
            print("self.frame size: ", self.view.frame.width, " height: ",self.view.frame.height)
            print("to Size: ", size.width, " height: ",size.height)
            
        }else{
            print("Portrait")
            print("self.frame size: ", self.view.frame.width, " height: ",self.view.frame.height)
            print("to Size: ", size.width, " height: ",size.height)
        }
        
        print("setting EqualSpacing with size:", size.width, "setLandscape: ",size.width > size.height )
        
        let ratio = size.width / size.height
        setEqualSpacing (size: size.width, ratio: ratio )
        print("Done setting EqualSpacing")
        
        
        super.viewWillTransition(to: size, with: coordinator)
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
