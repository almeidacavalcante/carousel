//
//  HeaderPhotoSelectorCell.swift
//  CarouselApp
//
//  Created by José de Almeida Cavalcante Neto on 02/08/17.
//  Copyright © 2017 José de Almeida Cavalcante Neto. All rights reserved.
//

import UIKit

protocol HeaderPhotoSelectorCellDelegate {
    func didTapAddButton()
    func didTapBackButton()
}

class HeaderPhotoSelectorCell : UICollectionViewCell {
    
    var delegate : HeaderPhotoSelectorCellDelegate?
    
    let imageView : UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .white
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    lazy var backButton : UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "arrow"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(handleBackButton), for: .touchUpInside)
        return button
    }()
    
    lazy var addButton : UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "circleplus"), for: .normal)
        button.addTarget(self, action: #selector(handleAddButton), for: .touchUpInside)
        button.tintColor = .white

        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(imageView)
        addSubview(addButton)
        addSubview(backButton)
        
        imageView.anchor(top: topAnchor, left: leftAnchor, botton: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        addButton.anchor(top: topAnchor, left: nil, botton: nil, right: rightAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 8, width: 50, height: 50)
        backButton.anchor(top: topAnchor, left: leftAnchor, botton: nil, right: nil, paddingTop: 8, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 50, height: 50)
        
        
    }
    
    func handleAddButton(){
        print("HEADER CELL: handleAddButton()")
        delegate?.didTapAddButton()
    }
    
    func handleBackButton(){
        print("HEADER CELL: handleBackButton()")
        delegate?.didTapBackButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
