//
//  ProductCell.swift
//  CarouselApp
//
//  Created by José de Almeida Cavalcante Neto on 25/07/17.
//  Copyright © 2017 José de Almeida Cavalcante Neto. All rights reserved.
//

import UIKit

class ProductCell : UICollectionViewCell {
    
    let imageView : UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    let screenWidth = UIScreen.main.bounds.size.width
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(imageView)
        self.imageView.anchor(top: topAnchor, left: leftAnchor, botton: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: screenWidth, height: 0)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
