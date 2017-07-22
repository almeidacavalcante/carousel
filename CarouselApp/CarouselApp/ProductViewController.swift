//
//  ViewController.swift
//  CarouselApp
//
//  Created by José de Almeida Cavalcante Neto on 21/07/17.
//  Copyright © 2017 José de Almeida Cavalcante Neto. All rights reserved.
//

import UIKit

class ProductViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var productPhotos : [UIImage?] = [UIImage]()
    var productFakeColors : [UIColor?] = [UIColor]()
    let screenWidth = UIScreen.main.bounds.size.width
    let cellId = "cellId"
    
     

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.backgroundColor = .white
        collectionView?.isPagingEnabled = true
        collectionView?.anchor(top: view.topAnchor, left: view.leftAnchor, botton: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: self.screenWidth)
        
        self.randomColorArray(times: 10)

        
    }
    
    func randomColorArray(times: Int){
        var red : CGFloat = 100
        var blue : CGFloat = 100
        var green : CGFloat = 100

        
        for i in 0...times {
            red = CGFloat(arc4random_uniform(254)+1)
            green = CGFloat(arc4random_uniform(254)+1)
            blue = CGFloat(arc4random_uniform(254)+1)
            
            self.productFakeColors.append(UIColor.rgb(red: red, green: green, blue: blue))
        }
    }

    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.productFakeColors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.screenWidth, height: self.screenWidth)
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        cell.backgroundColor = productFakeColors[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }


}

