//
//  TagCollectionView.swift
//  HTDevelopTool_Swift
//
//  Created by Ht on 2018/7/26.
//  Copyright © 2018年 HT. All rights reserved.
//

import UIKit

class TagCollectionView: UIView {
    
    var tagLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        tagLabel.font = ht_fontW(14)
    }
    
    public func configTag(dict: Dictionary<String, Any>) {
//        tagLabel.text = dict[""]
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
