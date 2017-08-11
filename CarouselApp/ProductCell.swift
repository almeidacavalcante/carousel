//
//  ProductCell.swift
//  CarouselApp
//
//  Created by José de Almeida Cavalcante Neto on 25/07/17.
//  Copyright © 2017 José de Almeida Cavalcante Neto. All rights reserved.
//

import UIKit

protocol ProductCellDelegate {
    func didTapTrashButton(indexPath: IndexPath)
}

class ProductCell : UICollectionViewCell {
    
    //TODO: Create a OBJECT CarouselItem with image, description, etc.
    
    let imageView : UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true 
        return iv
    }()
    
    lazy var trashButton : UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "trash"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(deleteHandler), for: .touchUpInside)
        return button
    }()
    
    lazy var reorderButton : UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "stack"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(reorderHandler), for: .touchUpInside)
        return button
    }()
    
    lazy var isCellEditingAvailable = false
    
    var indexPath : IndexPath?
    
    var delegate : ProductCellDelegate?
    let screenWidth = UIScreen.main.bounds.size.width
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(imageView)
        
        self.imageView.anchor(top: topAnchor, left: leftAnchor, botton: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: screenWidth, height: 0)
        
        self.showEditingViews()
    }
    
    func showEditingViews(){
        print("isEditAvailable: ", self.isCellEditingAvailable)
        if self.isCellEditingAvailable {
            addSubview(trashButton)
            addSubview(reorderButton)
            trashButton.anchor(top: topAnchor, left: nil, botton: nil, right: rightAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 8, width: 50, height: 50)
            reorderButton.anchor(top: topAnchor, left: leftAnchor, botton: nil, right: nil, paddingTop: 8, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 50, height: 50)
            
        }else{
            print("EDIT NOT AVAILABLE!")
            trashButton.removeFromSuperview()
            reorderButton.removeFromSuperview()
        }
    }
    override func prepareForReuse() {
        imageView.image = nil
        print("Preparing for reuse...")
    }
    
    func reorderHandler(){
        print("reorderHandler")
    }
    
    func deleteHandler(){
        print("deleteHandler")
        guard let indexPath = self.indexPath else {return}
        self.delegate?.didTapTrashButton(indexPath: indexPath)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
