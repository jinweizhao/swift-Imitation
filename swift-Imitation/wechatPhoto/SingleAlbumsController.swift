//
//  SingleAlbumsController.swift
//  swift-Imitation
//
//  Created by KDB on 2017/2/17.
//  Copyright © 2017年 Will-Z. All rights reserved.
//

import UIKit

class SingleAlbumsController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {

    var photosCollectionView : UICollectionView! = nil
    var flowLayout : UICollectionViewFlowLayout! = nil
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        flowLayout = UICollectionViewFlowLayout()
        let screentWidth = UIScreen.main.bounds.width
        flowLayout.minimumLineSpacing = 2
        flowLayout.minimumInteritemSpacing = 2
        flowLayout.sectionInset = UIEdgeInsetsMake(2, 2, 2, 2)
        let itemWidth = (screentWidth - 2 - 2 - 3 * 2) / 4
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth)
        
        
        photosCollectionView = UICollectionView(frame: CGRect.init(x: 0, y: 0, width: screentWidth, height: UIScreen.main.bounds.height - 44), collectionViewLayout: flowLayout)
        photosCollectionView.delegate = self
        photosCollectionView.dataSource = self
        photosCollectionView.backgroundColor = UIColor.white
        photosCollectionView.register(UINib.init(nibName: "ThumbnailCell", bundle: nil), forCellWithReuseIdentifier: "ThumbnailCell")
        self.view.addSubview(photosCollectionView)
        
        let toolBar = UIToolbar.init(frame: CGRect(x: 0, y: photosCollectionView.frame.maxY, width: screentWidth, height: 44))
        toolBar.backgroundColor = UIColor.lightGray
        self.view.addSubview(toolBar)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing :ThumbnailCell.self) , for: indexPath) as? ThumbnailCell else {
            fatalError("fatalerror-cell")
        }
            
            
            
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    

}
