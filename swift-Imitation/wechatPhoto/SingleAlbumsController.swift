//
//  SingleAlbumsController.swift
//  swift-Imitation
//
//  Created by KDB on 2017/2/17.
//  Copyright © 2017年 Will-Z. All rights reserved.
//

import UIKit
import Photos


class SingleAlbumsController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {

    var photosCollectionView : UICollectionView! = nil
    var flowLayout : UICollectionViewFlowLayout! = nil
    
    
    var fetchResult : PHFetchResult<PHAsset>?
    var itemSize : CGSize = CGSize.zero
    fileprivate let imageManager = PHCachingImageManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if fetchResult == nil {
            let allPhotosOptions = PHFetchOptions()
            allPhotosOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
            fetchResult = PHAsset.fetchAssets(with: allPhotosOptions)
        }
        
        setRightNav()
        
        flowLayout = UICollectionViewFlowLayout()
        let screentWidth = UIScreen.main.bounds.width
        flowLayout.minimumLineSpacing = 2
        flowLayout.minimumInteritemSpacing = 2
        flowLayout.sectionInset = UIEdgeInsetsMake(2, 2, 2, 2)
        let itemWidth = (screentWidth - 2 - 2 - 3 * 2) / 4
        self.itemSize = CGSize(width: itemWidth, height: itemWidth)
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth)
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        photosCollectionView = UICollectionView(frame: CGRect.init(x: 0, y: 64, width: screentWidth, height: UIScreen.main.bounds.height - 44 - 64), collectionViewLayout: flowLayout)
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
        
        let item = self.fetchResult?[indexPath.row]
        
        if item?.mediaType == .video {
            
            cell.typeLabel.isHidden = false
            
            cell.typeLabel.text = "Au" + (item?.duration.description)!
            
            
        } else if item?.mediaType == .image {
            
            cell.typeLabel.isHidden = true
            
        }
        
        imageManager.requestImage(for: item!, targetSize: self.itemSize, contentMode: .aspectFill, options: nil) { (image, _) in
            cell.imgView.image = image
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (self.fetchResult?.count)!
    }
    
    func setRightNav() {
        
        let rightItem = UIBarButtonItem(title: "Dismiss", style: .plain, target: self, action: #selector(close))
        self.navigationItem.rightBarButtonItem = rightItem
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.photosCollectionView .scrollToItem(at: NSIndexPath.init(item: (self.fetchResult?.count)! - 1, section: 0) as IndexPath, at: .bottom, animated: false)
    }
    func close() {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
}
