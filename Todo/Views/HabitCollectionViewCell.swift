//
//  HabitCollectionViewCell.swift
//  Todo
//
//  Created by Fengpeng Huang on 2020-06-17.
//  Copyright © 2020 Patrick. All rights reserved.
//

import UIKit

class HabitCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var image: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        image.layer.cornerRadius = image.frame.size.width / 2
        self.image.addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(longPressed)))
        self.image.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tap)))
    }
    
    @objc func longPressed(){
        print("Long Pressed a cell of Collection View")
    }

    @objc func tap(){
        print("Tap a cell of Collection View")
    }
}
