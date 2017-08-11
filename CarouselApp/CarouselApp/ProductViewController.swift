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
    var photos : [UIImage?] = [UIImage]()
    let screenWidth = UIScreen.main.bounds.size.width
    let cellId = "cellId"
    var isEditingMode = false
    let pageControl = UIPageControl()
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    let addButton : UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "circleplus"), for: .normal)
        button.addTarget(self, action: #selector(addPhotoHandler), for: .touchUpInside)
        button.tintColor = .black
        return button
    }()

    lazy var editButton : UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "edit").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleEdit), for: .touchUpInside)
        return button
    }()
    
    lazy var finishEditModeButton : UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "check"), for: .normal)
        button.addTarget(self, action: #selector(handleFinishEditMode), for: .touchUpInside)
        button.tintColor = UIColor.rgb(red: 136, green: 196, blue: 37)
        return button
    }()
    
    let containerView : UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var orderingButton : UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "stack"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(orderingHandler), for: .touchUpInside)
        return button
    }()
    
    var captionField : UITextView = {
        let tv = UITextView()
        tv.backgroundColor = UIColor.rgb(red: 220, green: 220, blue: 220)
        return tv
    }()
    
    let captionFieldLine : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.rgb(red: 200, green: 200, blue: 200)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupCollectionView()
        setupCaptionField()
        let numberOfCells = 3
        insertAssets(times: numberOfCells)
        setupPageControl(currentPage: 0)
        setupContainerView()
        finishEditModeButton.isHidden = true
        addButton.isHidden = true
    }
    
    func setupCaptionField(){
        view.addSubview(captionField)
        view.addSubview(captionFieldLine)
        
        captionField.anchor(top: collectionView?.bottomAnchor, left: view.leftAnchor, botton: nil, right: view.rightAnchor, paddingTop: 1, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 60)
        captionFieldLine.anchor(top: captionField.bottomAnchor, left: view.leftAnchor, botton: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 1)
    }

    func setupContainerView(){
        view.addSubview(containerView)
        containerView.addSubview(editButton)
        containerView.addSubview(addButton)
        containerView.addSubview(finishEditModeButton)
        
        containerView.anchor(top: nil, left: nil, botton: self.view.bottomAnchor, right: self.view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 8, paddingRight: 8, width: screenWidth/2+16, height: 50)
        editButton.anchor(top: containerView.topAnchor, left: nil, botton: nil, right: containerView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 50, height: 50)
        addButton.anchor(top: containerView.topAnchor, left: containerView.leftAnchor, botton: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 50, height: 50)
        finishEditModeButton.anchor(top: containerView.topAnchor, left: nil, botton: nil, right: containerView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 50, height: 50)
    }
    
    func handleEdit(){
        print("Edit mode!")
        isEditingMode = true
        collectionView?.reloadData()
        editButton.isHidden = true
        finishEditModeButton.isHidden = false
        addButton.isHidden = false
    }
    
    func handleFinishEditMode(){
        isEditingMode = false
        collectionView?.reloadData()
        finishEditModeButton.isHidden = true
        editButton.isHidden = false
        addButton.isHidden = true
    }
    
    func orderingHandler(){
        print("Ordering mode!")
    }
    
    func addPhotoHandler(){
        let layout =  UICollectionViewFlowLayout()
        let photoSelectorController = PhotoSelectorController(collectionViewLayout: layout)
        photoSelectorController.productViewController = self
        present(photoSelectorController, animated: true, completion: nil)
    }
    
    func didTapTrashButton(indexPath: IndexPath) {
        photos.remove(at: indexPath.item)
        collectionView?.reloadData()
        pageControl.numberOfPages = self.pageControl.numberOfPages-1
    }
    
    lazy var stackView = UIStackView()
    
    func setupStackView(subviews: [UIView]){
        stackView = UIStackView(arrangedSubviews: subviews)
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        let screenWidth = view.frame.width
        view.addSubview(stackView)
        stackView.anchor(top: nil, left: nil, botton: self.view.bottomAnchor, right: self.view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 8, paddingRight: 8, width: screenWidth/2, height: 50)
    }
    
    func setupCollectionView(){
        collectionView?.delegate = self
        collectionView?.register(ProductCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.backgroundColor = .white
        collectionView?.isPagingEnabled = true
//        collectionView?.anchor(top: view.topAnchor, left: view.leftAnchor, botton: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: screenWidth)
        
        collectionView?.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView?.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        collectionView?.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        collectionView?.widthAnchor.constraint(equalToConstant: 0).isActive = true
        collectionView?.heightAnchor.constraint(equalToConstant: screenWidth).isActive = true
        collectionView?.translatesAutoresizingMaskIntoConstraints = false
        
        
    }
    
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = scrollView.contentOffset.x / screenWidth
        pageControl.currentPage = Int(pageNumber)
    }
    
    func setupPageControl(currentPage: Int){
        pageControl.currentPage = currentPage
        pageControl.numberOfPages = photos.count
        pageControl.hidesForSinglePage = true
        
        view.addSubview(pageControl)
        pageControl.anchor(top: nil, left: collectionView?.leftAnchor, botton: collectionView?.bottomAnchor, right: collectionView?.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 50)
        pageControl.addTarget(self, action: #selector(pageChanged), for: .valueChanged)
    }
    
    func pageChanged(){
        let page = pageControl.currentPage
        let indexPath = IndexPath(item: page, section: 0)
        collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    func insertAssets(times : Int){
        for i in 1...times {
            self.photos.append(UIImage(named: "image\(i)"))
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.screenWidth, height: self.screenWidth)
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ProductCell
        cell.delegate = self
        cell.indexPath = indexPath
        cell.isCellEditingAvailable = self.isEditingMode
        cell.showEditingViews()
        cell.imageView.image = photos[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    //    lazy var editSwitcher : UISwitch = {
    //        let switcher = UISwitch()
    //        switcher.isOn = false
    //        switcher.addTarget(self, action: #selector(handleSwitch), for: .valueChanged)
    //        return switcher
    //    }()
    
    //    let editLabel : UILabel = {
    //        let label = UILabel()
    //        label.text = "EDIT"
    //        label.font = UIFont.boldSystemFont(ofSize: 12)
    //        label.textColor = UIColor.rgb(red: 188, green: 188, blue: 188)
    //
    //        return label
    //    }()
    
    //    let stackView : UIStackView = {
    //        let sv = UIStackView()
    //        sv.axis = .horizontal
    //        sv.distribution = .fillEqually
    //        sv.backgroundColor = .gray
    //
    //        return sv
    //    }()
    
    
    //    func handleSwitch(){
    //        let value = self.editSwitcher.isOn
    //        print("Switcher: ", value)
    //        self.editSwitcher.setOn(!value, animated: true)
    //        self.collectionView?.reloadData()
    //    }

}

