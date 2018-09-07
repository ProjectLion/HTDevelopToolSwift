//
//  CollectionTagCell.swift
//  HTDevelopTool_Swift
//
//  Created by Ht on 2018/7/26.
//  Copyright © 2018年 HT. All rights reserved.
//

import UIKit

class CollectionTagCell: UICollectionViewCell {
    
    lazy var title = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(title)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
