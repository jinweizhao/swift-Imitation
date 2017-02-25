//
//  CaptureController.swift
//  swift-Imitation
//
//  Created by KDB on 2017/2/24.
//  Copyright © 2017年 Will-Z. All rights reserved.
//

import UIKit
import WebKit
import JavaScriptCore

class CaptureController: UIViewController,WKNavigationDelegate,WKUIDelegate,UIGestureRecognizerDelegate {

    
    var longPress = UILongPressGestureRecognizer()
    
    var webView = WKWebView()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        setRightNav()
        
        setWKWebView()
        
        
    }
    func setWKWebView() {
        
        webView = WKWebView(frame: self.view.bounds)
        webView.navigationDelegate = self
        webView.uiDelegate = self
        self.view.addSubview(webView)
        
//        let paste = UIPasteboard.general
        
//        let urlString = paste.string ?? "https://www.baidu.com"
        
        let urlString = "http://www.miaopai.com/show/Qi3NR5twvM2e5k2lc-nXjw__.htm"
        
        let request = NSURLRequest(url: URL(string: urlString)!)
        
        webView.load(request as URLRequest)
        
        longPress.addTarget(self, action: #selector(longPressAction(gesture:)))
        longPress.delegate = self
        webView.scrollView.addGestureRecognizer(longPress)
        
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        let alert = UIAlertController(title: "error", message: error.localizedDescription, preferredStyle: .alert)
        
        alert .show(self, sender: nil)
        
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        
        if gestureRecognizer == longPress {
            return true
        }
        return false
    }
    
    func longPressAction(gesture:UILongPressGestureRecognizer) {
        
        if gesture.state == UIGestureRecognizerState.began {
            let point = gesture.location(in: webView.scrollView)
            //第一种方式
            let getPointedElement = "document.elementFromPoint(\(point.x),\(point.y)).src"
//            let getPointedElement = "document.body"
            webView.evaluateJavaScript(getPointedElement, completionHandler: { (obj, error) in
                let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "确定", style: .default, handler: nil))
                if obj != nil {
                    
                    alert.title = "获取到了"
                    alert.message = obj as? String
                    
                    let paste = UIPasteboard.general
                    paste.string = alert.message
                    
                    
                    
                }else
                {
                    alert.title = "未获取到！"
                }
                self.present(alert, animated: true, completion: nil)
            })
            
            //第二种方式：通过注入 js ，从 js 的方法中回调给 VC 需要的内容
        }
        
    }
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return false
    }
    
    func setRightNav() {
        
        let rightItem = UIBarButtonItem(title: "Dismiss", style: .plain, target: self, action: #selector(close))
        self.navigationItem.rightBarButtonItem = rightItem
        
    }
    func close() {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    


}
