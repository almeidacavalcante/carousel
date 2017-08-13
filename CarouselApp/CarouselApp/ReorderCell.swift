//
//  ReorderCell.swift
//  CarouselApp
//
//  Created by José de Almeida Cavalcante Neto on 12/08/17.
//  Copyright © 2017 José de Almeida Cavalcante Neto. All rights reserved.
//

import UIKit

class ReorderCell: UICollectionViewCell {
    
    //TODO: Create a OBJECT CarouselItem with image, description, etc
    let imageView : UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    var indexPath : IndexPath?
    let screenWidth = UIScreen.main.bounds.size.width
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(imageView)
        
        self.imageView.anchor(top: topAnchor, left: leftAnchor, botton: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: screenWidth, height: 0)

    }
        override func prepareForReuse() {
        imageView.image = nil
        print("Preparing for reuse...")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
