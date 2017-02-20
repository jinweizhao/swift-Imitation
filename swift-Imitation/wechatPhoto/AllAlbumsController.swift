//
//  AllAlbumsController.swift
//  swift-Imitation
//
//  Created by KDB on 2017/2/17.
//  Copyright © 2017年 Will-Z. All rights reserved.
//

import UIKit
import Photos



class AlbumItem : NSObject {
    
    var title : String?
    
    var image : UIImage?
    
    var photosCount : NSInteger = 0
    
    var fetchResult : PHFetchResult<PHAsset>?
    
    
    init(title : String , fetchResult : PHFetchResult<PHAsset>) {
        
        super.init()
        
        self.title = title
        self.fetchResult = fetchResult
        
        if fetchResult.count > 0 {
            self.photosCount = fetchResult.count
            let asset = fetchResult.firstObject
            
            PHCachingImageManager().requestImage(for: asset!, targetSize: CGSize.init(width: 44, height: 44), contentMode: .aspectFill, options: nil, resultHandler: { [weak self] (getImage, _) in
                self?.image = getImage
            })
        }
        
    }
    
}


class AllAlbumsController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    var tableView : UITableView?
    var items : [AlbumItem] = []
    var cacheImageManager : PHCachingImageManager?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cacheImageManager = PHCachingImageManager()
        
        setRightNav()
        
        getAlbums()
        
        setTableView()
        
        
        
    }
    
    func getAlbums() {
        let smartAlbums = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .albumRegular, options: nil)
        
//        convertAssetCollections(assetCollections: smartAlbums)
        convertCollections(collection: smartAlbums as! PHFetchResult<PHCollection>)
        
        let userAlbums = PHCollectionList.fetchTopLevelUserCollections(with: nil)
        
        convertCollections(collection: userAlbums)
        
        
    }
    
    //转换智能相册
//    func convertAssetCollections(assetCollections : PHFetchResult<PHAssetCollection>) {
//        for i in 0..<assetCollections.count {
//            
//            let assetCollection = assetCollections[i]
//            
//            
//            
//        }
//    }
    
    //转换用户相册
    func convertCollections(collection : PHFetchResult<PHCollection>) {
        
//        print(collection)
        
        for i in 0..<collection.count {
            //获取当前相册图片
            let resultOptions = PHFetchOptions()
            
            resultOptions.sortDescriptors = [NSSortDescriptor(key : "creationDate" , ascending : true)]
            
            //获取相册中文件类新
//            resultOptions.predicate = NSPredicate(format: "mediaType = %d", PHAssetMediaType.image.rawValue)
            
            guard let phassetCollection = collection[i] as? PHAssetCollection else { return  }
            
            let assetFetchResult = PHAsset.fetchAssets(in: phassetCollection, options: resultOptions)
            
//            print(assetFetchResult)
            
//            if assetFetchResult.count > 0 {
                self.items.append(AlbumItem(title: phassetCollection.localizedTitle!, fetchResult: assetFetchResult))
//            }
            
        }
        
    }
    
    func setTableView() {
        
        tableView = UITableView(frame: self.view.bounds, style: .plain)
        tableView?.delegate = self;
        tableView?.dataSource = self;
//        tableView?.rowHeight = 80
        tableView?.register(NSClassFromString(UITableViewCell.description()), forCellReuseIdentifier: UITableViewCell.description())
        self.view.addSubview(tableView!)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let item = self.items[indexPath.row]
        if item.fetchResult?.count == 0 {return}
            
        let singleAlbumVC = SingleAlbumsController()
        singleAlbumVC.title = item.title
        
        singleAlbumVC.fetchResult = item.fetchResult
        
        self.navigationController?.pushViewController(singleAlbumVC, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.description(), for: indexPath)
        
        let item = self.items[indexPath.row]
//        var title : String
        
//        if item.title == "All Photos" {
//            title = "全部照片"
//        } else {
//            
//        }
        
        cell.textLabel?.text = "\(item.title!)   (\(item.photosCount))"
        
        if item.image == nil{
            cell.imageView?.image = nil
            return cell
        }
        
        cell.imageView?.image = item.image!
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    
    func setRightNav() {
        
        let rightItem = UIBarButtonItem(title: "Dismiss", style: .plain, target: self, action: #selector(close))
        self.navigationItem.rightBarButtonItem = rightItem
        
    }
    
    func close() {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }

}
