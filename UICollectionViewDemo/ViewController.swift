//
//  ViewController.swift
//  UICollectionViewDemo
//
//  Created by Trista on 2021/2/5.
//

import UIKit

//遵守委任需要的協定：UICollectionViewDelegate, UICollectionViewDataSource
class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    //取得螢幕的尺寸
    let fullScreenSize = UIScreen.main.bounds.size
    
    //遵守協定：UICollectionViewDelegate, UICollectionViewDataSource必須實作的方法
    //每一組有幾個 cell
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 18
    }
    
    //遵守協定：UICollectionViewDelegate, UICollectionViewDataSource必須實作的方法
    //每個 cell 要顯示的內容
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //依據前面註冊設置的識別名稱 "Cell" 取得目前使用的 cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! MyCollectionViewCell

        //設置 cell 內容 (即自定義元件裡 增加的圖片與文字元件)
        cell.imageView.image = UIImage(named: "\(indexPath.item + 1).jpg")
        cell.titleLabel.text = "\(indexPath.item + 1)"
   
        return cell
    }
    
    //遵守協定：UICollectionViewDelegate, UICollectionViewDataSource可選擇實作的方法
    //有幾個 section
    func numberOfSections(in collectionView: UICollectionView) -> Int{
        return 3
    }
    
    //遵守協定：UICollectionViewDelegate, UICollectionViewDataSource可選擇實作的方法
    //點選 cell 後執行的動作
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("你選擇了第 \(indexPath.section + 1) 組的")
        print("第 \(indexPath.item + 1) 張圖片")
    }
    
    //遵守協定：UICollectionViewDelegate, UICollectionViewDataSource可選擇實作的方法
    //設置 reuse 的 section 的 header 或 footer
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        //因為 header 與 footer 是共用一個方法，且都是屬於UICollectionReusableView元件，所以需要先建立一個UICollectionReusableView元件
        //建立 UICollectionReusableView
        var reusableView = UICollectionReusableView()

        //顯示文字
        let label = UILabel(frame: CGRect(
          x: 0, y: 0,
          width: fullScreenSize.width, height: 40))
        label.textAlignment = .center

        //因為 header 與 footer 是共用一個方法，且都是屬於UICollectionReusableView元件，所以需要先建立一個UICollectionReusableView元件，並使用kind參數來分辨是要設置 header 或 footer
        //header
        if kind == UICollectionView.elementKindSectionHeader {
            //依據前面註冊設置的識別名稱 "Header" 取得目前使用的 header
            reusableView =
                collectionView.dequeueReusableSupplementaryView(
                    ofKind: UICollectionView.elementKindSectionHeader,
                    withReuseIdentifier: "Header",
                    for: indexPath)
            
            //設置 header 的內容
            reusableView.backgroundColor =
                UIColor.cyan
            label.text = "Header";
            label.textColor = UIColor.black

        }
        //footer
        else if kind ==
                    UICollectionView.elementKindSectionFooter {
            //依據前面註冊設置的識別名稱 "Footer" 取得目前使用的 footer
            reusableView =
                collectionView.dequeueReusableSupplementaryView(
                    ofKind: UICollectionView.elementKindSectionFooter,
                    withReuseIdentifier: "Footer",
                    for: indexPath)
            
            //設置 footer 的內容
            reusableView.backgroundColor =
                UIColor.lightGray
            label.text = "Footer";
            label.textColor = UIColor.darkGray

        }

        reusableView.addSubview(label)
        return reusableView
    
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //設置底色
        self.view.backgroundColor = UIColor.white
        
        //1.建立 UICollectionViewFlowLayout用來自定義呈現的樣式，再交給建立 UICollectionView 元件時的函式使用
        let layout = UICollectionViewFlowLayout()

        //設置 section 的間距 四個數值分別代表 上、左、下、右 的間距
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5);

        //設置每一行的間距
        layout.minimumLineSpacing = 5

        //設置每個 cell 的尺寸
        layout.itemSize = CGSize(
            width: CGFloat(fullScreenSize.width)/3 - 10.0,
            height: CGFloat(fullScreenSize.width)/3 - 10.0)

        //設置 header 及 footer 的尺寸
        layout.headerReferenceSize = CGSize(
          width: fullScreenSize.width, height: 40)
        layout.footerReferenceSize = CGSize(
          width: fullScreenSize.width, height: 40)
        
        
        //2.建立 UICollectionView，除了要註冊 cell 之外，要自定義每個 section 的 header 或 footer 時，也必須註冊 header 或 footer ，以供後續重複使用。
        let myCollectionView = UICollectionView(frame: CGRect(
              x: 0, y: 20,
              width: fullScreenSize.width,
              height: fullScreenSize.height - 20),
            collectionViewLayout: layout)

        //註冊 cell 以供後續重複使用
        //UICollectionView 的 cell 需要自定義一個繼承自 UICollectionViewCell 的類別 MyCollectionViewCell，用來加上需要的元件
        myCollectionView.register(
          MyCollectionViewCell.self,
          forCellWithReuseIdentifier: "Cell")

        //註冊 section 的 header 跟 footer 以供後續重複使用
        //section 的 header 與 footer 都是屬於 UICollectionReusableView 類別，所以註冊時就是使用這個類別註冊
        myCollectionView.register(
          UICollectionReusableView.self,
          forSupplementaryViewOfKind:
            UICollectionView.elementKindSectionHeader,
          withReuseIdentifier: "Header")
        myCollectionView.register(
          UICollectionReusableView.self,
          forSupplementaryViewOfKind:
            UICollectionView.elementKindSectionFooter,
          withReuseIdentifier: "Footer")

        //設置委任對象
        myCollectionView.delegate = self
        myCollectionView.dataSource = self

        //加入畫面中
        self.view.addSubview(myCollectionView)
        
    }


}

