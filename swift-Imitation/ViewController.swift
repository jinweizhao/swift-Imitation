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
        
        let btnHeight: CGFloat = 45.0
        let margin : CGFloat = 15
        
        self.automaticallyAdjustsScrollViewInsets = false
        scrollView.contentSize = CGSize.init(width: 0, height: UIScreen.main.bounds.height - 64 + 1)
        
        
        wechatPhotoBtn = UIButton(frame: .init(x: 10, y: 15, width: UIScreen.main.bounds.width - 20, height: btnHeight))
        wechatPhotoBtn.setTitle("微信相册", for: .normal)
        wechatPhotoBtn.backgroundColor = UIColor.init(red: 195/255.0, green: 205/255.0, blue: 211/255.0, alpha: 1)
        wechatPhotoBtn.addTarget(self, action: #selector(wechatPhotoClick), for: .touchUpInside)
        scrollView.addSubview(wechatPhotoBtn)
        
        
        let captureBtn = UIButton(frame: .init(x: wechatPhotoBtn.frame.minX, y: wechatPhotoBtn.frame.maxY + margin, width: UIScreen.main.bounds.width - 20, height: btnHeight))
        captureBtn.setTitle("抓取网页video/image", for: .normal)
        captureBtn.backgroundColor = UIColor.init(red: 195/255.0, green: 205/255.0, blue: 211/255.0, alpha: 1)
        captureBtn.addTarget(self, action: #selector(captureWebVideoAndImage), for: .touchUpInside)
        scrollView.addSubview(captureBtn)
        
    }

    func wechatPhotoClick(){
        
        let allAlbumsVC = AllAlbumsController()
        allAlbumsVC.title = "全部相册"
        allAlbumsVC.view.backgroundColor = UIColor.white
        let nav = UINavigationController(rootViewController: allAlbumsVC)
        
        let singleAlbumsVC = SingleAlbumsController()
        singleAlbumsVC.title = "全部照片"
        singleAlbumsVC.view.backgroundColor = UIColor.white
        
        nav.pushViewController(singleAlbumsVC, animated: false)
        
        self.present(nav, animated: true, completion: nil)
        
    }
    
    func captureWebVideoAndImage() {
        
        let captureVC = CaptureController();
        
        let nav = UINavigationController(rootViewController: captureVC)
        captureVC.title = "抓取video/image"
        self.present(nav, animated: true, completion: nil)
        
    }
    
}

