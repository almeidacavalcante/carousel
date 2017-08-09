//
//  ViewController.swift
//  CarouselApp
//
//  Created by José de Almeida Cavalcante Neto on 21/07/17.
//  Copyright © 2017 José de Almeida Cavalcante Neto. All rights reserved.
//

import UIKit

class ProductViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UIPageViewControllerDelegate, ProductCellDelegate {

//    var productPhotos : [UIColor?] = [UIColor]()
    var productPhotos : [UIImage?] = [UIImage]()
    let screenWidth = UIScreen.main.bounds.size.width
    let cellId = "cellId"
    
    let pageControl = UIPageControl()
    
    let plusButton : UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "circleplus"), for: .normal)
        button.addTarget(self, action: #selector(addPhotoHandler), for: .touchUpInside)
        button.tintColor = .black
        return button
    }()
    
    lazy var editSwitcher : UISwitch = {
        let switcher = UISwitch()
        switcher.isOn = false
        switcher.addTarget(self, action: #selector(handleSwitch), for: .valueChanged)
        return switcher
    }()
    
    let editLabel : UILabel = {
        let label = UILabel()
        label.text = "EDIT"
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor = UIColor.rgb(red: 188, green: 188, blue: 188)
        
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupCollectionView()
        self.view.backgroundColor = .white
        
        view.addSubview(editLabel)
        view.addSubview(editSwitcher)
        
        editLabel.anchor(top: self.collectionView?.bottomAnchor, left: nil, botton: nil, right: nil, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        editLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        editSwitcher.anchor(top: editLabel.bottomAnchor, left: nil, botton: nil, right: nil, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        editSwitcher.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

        let numberOfCells = 3
        self.insertAssets(times: numberOfCells)
        
        setupPageControl(currentPage: 0)
        setupStackView()
        
    }
    
//    let stackView : UIStackView = {
//        let sv = UIStackView()
//        sv.axis = .horizontal
//        sv.distribution = .fillEqually
//        sv.backgroundColor = .gray
//        
//        return sv
//    }()
    
    
    func handleSwitch(){
        let value = self.editSwitcher.isOn
        print("Switcher: ", value)
        self.editSwitcher.setOn(!value, animated: true)
        self.collectionView?.reloadData()
        
    }
    
    
    
    func addPhotoHandler(){
        print("Adding photo!")
        
        let layout =  UICollectionViewFlowLayout()
        let photoSelectorController = PhotoSelectorController(collectionViewLayout: layout)
        
        photoSelectorController.productViewController = self
        
        present(photoSelectorController, animated: true, completion: nil)
    }
    
    func didTapTrashButton(indexPath: IndexPath) {
        self.productPhotos.remove(at: indexPath.item)
        self.collectionView?.reloadData()
        self.pageControl.numberOfPages = self.pageControl.numberOfPages-1
    }
    
    func setupStackView(){
        let stackView = UIStackView(arrangedSubviews: [plusButton])
        
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        
        view.addSubview(stackView)
        stackView.anchor(top: nil, left: self.view.leftAnchor, botton: self.view.bottomAnchor, right: self.view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 50)
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
    
    func setupPageControl(currentPage: Int){
        pageControl.currentPage = currentPage
        pageControl.numberOfPages = productPhotos.count
        pageControl.hidesForSinglePage = true
        view.addSubview(pageControl)
        pageControl.anchor(top: nil, left: collectionView?.leftAnchor, botton: collectionView?.bottomAnchor, right: collectionView?.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 50)
        
        pageControl.addTarget(self, action: #selector(pageChanged), for: .valueChanged)
    }
    
    
    
    func pageChanged(){
        print(pageControl.currentPage)
        let page = pageControl.currentPage
        let indexPath = IndexPath(item: page, section: 0)
        
        self.collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        
    }
    
    
    func insertAssets(times : Int){
        for i in 1...times {
            self.productPhotos.append(UIImage(named: "image\(i)"))
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.productPhotos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.screenWidth, height: self.screenWidth)
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ProductCell
        
        cell.delegate = self
        cell.indexPath = indexPath
        cell.isEditAvailable = self.editSwitcher.isOn
        cell.showTrashButton()
        cell.imageView.image = productPhotos[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }


}

