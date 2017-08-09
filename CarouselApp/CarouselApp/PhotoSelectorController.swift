//
//  PhotoSelectorController.swift
//  CarouselApp
//
//  Created by José de Almeida Cavalcante Neto on 02/08/17.
//  Copyright © 2017 José de Almeida Cavalcante Neto. All rights reserved.
//

import UIKit
import Photos

class PhotoSelectorController: UICollectionViewController, UICollectionViewDelegateFlowLayout, HeaderPhotoSelectorCellDelegate {
    
    let headerId = "headerId"
    let cellId = "cellId"
    
    var productViewController : ProductViewController?
    
    var assets = [PHAsset]()
    var images = [UIImage]()
    var selectedAsset: PHAsset?
    var selectedImage: UIImage?
    
    override func viewDidLoad() {
        
        collectionView?.backgroundColor = .white
        
        collectionView?.register(HeaderPhotoSelectorCell.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerId)
        
        collectionView?.register(PhotoSelectorCell.self, forCellWithReuseIdentifier: cellId)
        
        fetchImages()
    }
    
    func didTapAddButton() {
        print("Adding some photo!")
        
        guard let productViewController = productViewController else {return}
        
        productViewController.productPhotos.append(selectedImage)
        print("PRODUCT PHOTOS: ", productViewController.productPhotos, "PRODUCT PHOTOS - END!")
        
        self.dismiss(animated: true) { 
            productViewController.setupPageControl(currentPage: productViewController.pageControl.currentPage)
            productViewController.collectionView?.reloadData()
        }

    }
    
    func didTapBackButton() {
        self.dismiss(animated: true) {
            print("Dismissing the Photo Selector!")
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Item selected: ", indexPath)
        self.selectedImage = images[indexPath.item]
        self.collectionView?.reloadData()
        
        //scrolls up
        let idx = IndexPath(item: 0, section: 0)
        collectionView.scrollToItem(at: idx, at: .bottom, animated: true)
        
    }
    
    fileprivate func assetsFetchOptions() -> PHFetchOptions {
        let fetchOptions = PHFetchOptions()
        fetchOptions.fetchLimit = 30
        let sortDescriptor = NSSortDescriptor(key: "creationDate", ascending: false)
        fetchOptions.sortDescriptors = [sortDescriptor]
        return fetchOptions
    }
    
    fileprivate func imageRequestOptions() -> PHImageRequestOptions {
        let requestOption = PHImageRequestOptions()
        requestOption.deliveryMode = .highQualityFormat
        return requestOption
    }
    
    fileprivate func fetchImages(){
        
        let fetchOptions = assetsFetchOptions()
        let allPhotos = PHAsset.fetchAssets(with: .image, options: fetchOptions)
        
        allPhotos.enumerateObjects({ (asset, index, stop) in

            let imageManager = PHImageManager.default()
            let targetSize = CGSize(width: 200, height: 200)
            
            imageManager.requestImage(for: asset, targetSize: targetSize, contentMode: .aspectFit, options: self.imageRequestOptions(), resultHandler: { (image, info) in
                
                if let image = image {
                    self.images.append(image)
                    self.assets.append(asset)
                    
                    if self.selectedImage == nil {
                        self.selectedImage = image
                    }
                }
                
                if index == allPhotos.count - 1 {
                    self.collectionView?.reloadData()
                }
            })
        })
    }
    
    func cancelHandler(){
        navigationController?.dismiss(animated: true, completion: { 
            print("Dismissing the Photo Picker!")
            
        })
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let screenWidth = view.frame.width
        
        let cellWidth = (screenWidth - 2)/3
        
        return CGSize(width: cellWidth, height: cellWidth)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerId, for: indexPath) as! HeaderPhotoSelectorCell
        
        header.delegate = self
        
        header.imageView.image = selectedImage
        
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        let side = view.frame.width
        
        return CGSize(width: side, height: side)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 1, left: 0, bottom: 0, right: 0)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! PhotoSelectorCell
        
//        let r = randomNumber(max: 255)
//        let g = randomNumber(max: 255)
//        let b = randomNumber(max: 255)
//        
//        cell.backgroundColor = UIColor.rgb(red: r, green: g, blue: b)

//        cell.imageView.image = images[indexPath.item]
        
        
        cell.imageView.image = images[indexPath.item]
        print("INDEXPATH ", indexPath.item)
        
        return cell
    }
    
    func randomNumber(max: Int) -> CGFloat{
        let random = arc4random_uniform(UInt32(max))
        
        return CGFloat(random)
    }
    
    
}
