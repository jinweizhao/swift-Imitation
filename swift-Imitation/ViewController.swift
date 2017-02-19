//
//  ViewController.swift
//  swift-Imitation
//
//  Created by KDB on 2017/2/16.
//  Copyright © 2017年 Will-Z. All rights reserved.
//

import UIKit
import Photos

class ViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    var wechatPhotoBtn = UIButton()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.automaticallyAdjustsScrollViewInsets = false
        scrollView.contentSize = CGSize.init(width: 0, height: UIScreen.main.bounds.height - 64 + 1)
        
        
        wechatPhotoBtn = UIButton(frame: .init(x: 10, y: 15, width: UIScreen.main.bounds.width - 20, height: 45))
        wechatPhotoBtn.setTitle("微信相册", for: .normal)
        wechatPhotoBtn.backgroundColor = UIColor.init(red: 195/255.0, green: 205/255.0, blue: 211/255.0, alpha: 1)
        wechatPhotoBtn.addTarget(self, action: #selector(wechatPhotoClick), for: .touchUpInside)
        scrollView.addSubview(wechatPhotoBtn)
        
        
        
    }

    func wechatPhotoClick(){
        
        let allAlbumsVC = AllAlbumsController()
        allAlbumsVC.title = "全部相册"
        allAlbumsVC.view.backgroundColor = UIColor.white
        let nav = UINavigationController(rootViewController: allAlbumsVC)
        
        let singleAlbumsVC = SingleAlbumsController()
        singleAlbumsVC.title = "全部照片"
        singleAlbumsVC.view.backgroundColor = UIColor.white
        
        let allPhotosOptions = PHFetchOptions()
        allPhotosOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
        singleAlbumsVC.fetchResult = PHAsset.fetchAssets(with: allPhotosOptions) as? PHFetchResult<AnyObject>
        
        nav.pushViewController(singleAlbumsVC, animated: false)
        
        self.present(nav, animated: true, completion: nil)
        
    }
}

