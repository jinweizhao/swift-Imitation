//
//  ThumbnailCell.swift
//  swift-Imitation
//
//  Created by KDB on 2017/2/17.
//  Copyright © 2017年 Will-Z. All rights reserved.
//

import UIKit

class ThumbnailCell: UICollectionViewCell {

    
    @IBOutlet weak var selectBtn: UIButton!
    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var typeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func selectBtnClick(_ sender: UIButton) {
        
        selectBtn.isSelected = !selectBtn.isSelected
        
        if selectBtn.isSelected {
            
            UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 10, options: .curveEaseInOut, animations: {
                
                self.selectBtn.layer.transform = CATransform3DMakeScale(1.1, 1.1, 1)
                
            }, completion: { (Bool) in
                UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 10, options: .curveEaseInOut, animations: {
                    
                    self.selectBtn.layer.transform = CATransform3DIdentity
                    
                }, completion: { (Bool) in
                    
                })
            })
            
            
        }
        
    }
}
