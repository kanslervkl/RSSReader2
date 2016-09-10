//
//  LabelHelper.swift
//  RSSReader3
//
//  Created by Mac on 10.09.16.
//  Copyright © 2016 KanslerSoft. All rights reserved.
//
import UIKit
import Foundation

extension UILabel{
    func setTextDinamicaly(sizeFont:CGFloat,text:String, color:UIColor){
        let label = self
        let font = UIFont.systemFontOfSize(sizeFont)
        label.font = font
        label.numberOfLines = 0
        let size = text.sizeWithAttributes([NSFontAttributeName:font])
        label.frame = CGRectMake(0, 0, size.width, size.height)
        label.text = text
        label.textColor = color
        
    }
}