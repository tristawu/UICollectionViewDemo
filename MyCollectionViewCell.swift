//
//  MyCollectionViewCell.swift
//  UICollectionViewDemo
//
//  Created by Trista on 2021/2/5.
//

import UIKit

//自定義的 UICollectionViewCell 類別 
class MyCollectionViewCell: UICollectionViewCell {
    
    //加入需要顯示的元件
    var imageView:UIImageView!
    var titleLabel:UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        //取得螢幕寬度
        let w = Double(UIScreen.main.bounds.size.width)
        
        //建立一個 UIImageView
        imageView = UIImageView(frame: CGRect(
              x: 0, y: 0,
              width: w/3 - 10.0, height: w/3 - 10.0))
            
        self.addSubview(imageView)

            
        //建立一個 UILabel
        titleLabel = UILabel(frame:CGRect(
              x: 0, y: 0, width: w/3 - 10.0, height: 40))
        titleLabel.textAlignment = .center
        titleLabel.textColor = UIColor.orange
            
        self.addSubview(titleLabel)
        
    }

    /*
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    */
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
