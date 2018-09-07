//
//  TagCell.swift
//  HTDevelopTool_Swift
//
//  Created by Ht on 2018/7/26.
//  Copyright © 2018年 HT. All rights reserved.
//

import UIKit

class TagCell: UITableViewCell {
    
    public var dataDict: Dictionary<String, Any> = [:] {
        didSet {
            collection.reloadData()
        }
    }
    
    public var themColor: UIColor = .white {
        didSet {
            
        }
    }
    
    lazy var titleLabel = UILabel()
    
    var collection: UICollectionView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        titleLabel.frame = CGRect(x: 24, y: 10, width: 100, height: 100)
        titleLabel.layer.cornerRadius = 5
        titleLabel.clipsToBounds = true
        titleLabel.text = ""
        titleLabel.sizeToFit()
        contentView.addSubview(titleLabel)
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.estimatedItemSize = CGSize(width: SCREEN_W, height: 100)
        flowLayout.minimumInteritemSpacing = 5
        flowLayout.minimumLineSpacing = 5
        flowLayout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        
        collection = UICollectionView(frame: CGRect(x: 80, y: 0, width: SCREEN_W - 180, height: 1000), collectionViewLayout: flowLayout)
        collection.contentInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        collection.register(CollectionTagCell.self, forCellWithReuseIdentifier: "tagCell")
        collection.delegate = self
        collection.dataSource = self
        contentView.addSubview(collection)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension TagCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let model = dataDict["tagArr"] as! Array<String>
        return model.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collection.dequeueReusableCell(withReuseIdentifier: "tagCell", for: indexPath)
        
        return cell
    }
    
    
    
    
}
