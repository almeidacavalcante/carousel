//
//  ViewController.swift
//  CarouselApp
//
//  Created by José de Almeida Cavalcante Neto on 21/07/17.
//  Copyright © 2017 José de Almeida Cavalcante Neto. All rights reserved.
//

import UIKit

class ProductViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UIPageViewControllerDelegate {

//    var productPhotos : [UIColor?] = [UIColor]()
    var productPhotos : [UIImage?] = [UIImage]()
    let screenWidth = UIScreen.main.bounds.size.width
    let cellId = "cellId"
    
    let pageControl = UIPageControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupCollectionView()
        self.view.backgroundColor = .white

        let numberOfCells = 5
        self.insertAssets(times: numberOfCells)
        
        setupPageControl()
        
    }
    
    func setupCollectionView(){
        collectionView?.delegate = self
        collectionView?.register(ProductCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.backgroundColor = .white
        collectionView?.isPagingEnabled = true
        collectionView?.anchor(top: view.topAnchor, left: view.leftAnchor, botton: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: self.screenWidth)
        
    }
    
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = scrollView.contentOffset.x / screenWidth
        pageControl.currentPage = Int(pageNumber)
    }
    
    func setupPageControl(){
        pageControl.currentPage = 0
        pageControl.numberOfPages = productPhotos.count
        pageControl.hidesForSinglePage = true
        view.addSubview(pageControl)
        pageControl.anchor(top: nil, left: collectionView?.leftAnchor, botton: collectionView?.bottomAnchor, right: collectionView?.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 50)
        
        pageControl.addTarget(self, action: #selector(pageChanged), for: .valueChanged)
        
    }
    
    func pageChanged(){
        print(pageControl.currentPage)
        
    }
    
    func insertAssets(times : Int){
        for i in 1...times {
            self.productPhotos.append(UIImage(named: "Image\(i)"))
        }
    }
    
    
//    func randomColorArray(times: Int){
//        var red : CGFloat = 100
//        var blue : CGFloat = 100
//        var green : CGFloat = 100
//
//        
//        for _ in 0...times {
//            red = CGFloat(arc4random_uniform(254)+1)
//            green = CGFloat(arc4random_uniform(254)+1)
//            blue = CGFloat(arc4random_uniform(254)+1)
//            
////            self.productPhotos.append(UIColor.rgb(red: red, green: green, blue: blue))
//        }
//    }

    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.productPhotos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.screenWidth, height: self.screenWidth)
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ProductCell
        cell.imageView.image = productPhotos[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }


}

