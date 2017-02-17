//
//  AllAlbumsController.swift
//  swift-Imitation
//
//  Created by KDB on 2017/2/17.
//  Copyright © 2017年 Will-Z. All rights reserved.
//

import UIKit

class AllAlbumsController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setRightNav()
        
        
    }
    
    func setRightNav() {
        
        let rightItem = UIBarButtonItem(title: "Dismiss", style: .plain, target: self, action: #selector(close))
        self.navigationItem.rightBarButtonItem = rightItem
        
    }
    
    func close() {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }

}
