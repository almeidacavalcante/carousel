//
//  ReorderViewController.swift
//  CarouselApp
//
//  Created by José de Almeida Cavalcante Neto on 11/08/17.
//  Copyright © 2017 José de Almeida Cavalcante Neto. All rights reserved.
//

import UIKit

class ReorderViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UIGestureRecognizerDelegate {

    let cellId = "reorderCell"
    var photos : [UIImage?] = [UIImage]()
    
    fileprivate var longPressGesture : UILongPressGestureRecognizer!
    var productViewController : ProductViewController?
    
    let saveButton : UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "check"), for: .normal)
        button.addTarget(self, action: #selector(handleSave), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupSaveButton()
    }
    
    func setupSaveButton(){
        view.addSubview(saveButton)
        saveButton.anchor(top: nil, left: nil, botton: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 8, paddingRight: 8, width: 50, height: 50)
    }
    
    func setupCollectionView(){
        view.backgroundColor = .white
        
        collectionView?.register(ReorderCell.self, forCellWithReuseIdentifier: cellId)
        
        collectionView?.backgroundColor = UIColor.rgb(red: 233, green: 233, blue: 233)

        anchorCollectionView()
        
        longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(self.handleLongGesture(_:)))
        longPressGesture.minimumPressDuration = 0.1
        longPressGesture.delegate = self
        
        collectionView?.gestureRecognizerShouldBegin(longPressGesture)
        
        self.collectionView?.addGestureRecognizer(longPressGesture!)
        
        
        
        for gr in (collectionView?.gestureRecognizers)! {
            if gr.self === UILongPressGestureRecognizer.self {
                print("Long Press!")
            }
        }
        
        print("LONGPRESS????")
    }
    
    func handleSave(){
        productViewController?.photos = self.photos
        productViewController?.pageControl.reloadInputViews()
        productViewController?.collectionView?.reloadData()
        self.dismiss(animated: true) { 
            print("Dismissing the Reordering page!")
        }
    }
    

    func handleLongGesture(_ gesture : UILongPressGestureRecognizer){
        print("Handling long press gesture!")
        
        switch gesture.state {
            
        case UIGestureRecognizerState.began:
            print("began")
            guard let selectedIndexPath = collectionView?.indexPathForItem(at: gesture.location(in: collectionView)) else {
                break
            }
            collectionView?.beginInteractiveMovementForItem(at: selectedIndexPath)

        case UIGestureRecognizerState.changed:
            print("changed")
            collectionView?.updateInteractiveMovementTargetPosition(gesture.location(in: gesture.view!))
            
            
        case UIGestureRecognizerState.ended:
            print("ended")
            collectionView?.endInteractiveMovement()
            
            
            
        default:
            collectionView?.cancelInteractiveMovement()
        }
    }

}

extension ReorderViewController {
    
    public override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ReorderCell

        cell.indexPath = indexPath
        cell.imageView.image = photos[indexPath.item]
        
//        let r = CGFloat(arc4random_uniform(256))
//        let g = CGFloat(arc4random_uniform(256))
//        let b = CGFloat(arc4random_uniform(256))
//        cell.backgroundColor = UIColor.rgb(red: r, green: g, blue: b)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let side = (view.frame.width-2)/3
//        resizeCollectionView()
        
        return CGSize(width: side, height: side)
    }
    
    func anchorCollectionView(){
        let side = (view.frame.width-3)/3
        var lines = CGFloat(photos.count)/3
        lines = CGFloat(Float(lines).roundUp())
        
        let height = CGFloat(CGFloat(side) * lines) + CGFloat(lines-1)
        
        collectionView?.anchor(top: view.topAnchor, left: view.leftAnchor, botton: nil, right: view.rightAnchor, paddingTop: 16, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }

    
    override func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        let tempPhoto = photos.remove(at: sourceIndexPath.item)
        photos.insert(tempPhoto, at: destinationIndexPath.item)
    }
}

