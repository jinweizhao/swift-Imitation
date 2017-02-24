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
        
        let paste = UIPasteboard.general
        
        let urlString = paste.string ?? "https://www.baidu.com"
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
            
            let getPointedElement = "document.elementFromPoint(\(point.x),\(point.y)).innerHTML"
//            let getPointedElement = "document.body"
            webView.evaluateJavaScript(getPointedElement, completionHandler: { (obj, error) in
                print(obj!)
                print("---")
                print(error ?? "noerror")
            })
            
            
            print(point)
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
