//
//  LGSportCell.swift
//  LetsGo
//
//  Created by 张宏台 on 15/7/18.
//  Copyright (c) 2015年 张宏台. All rights reserved.
//

import Foundation
import UIKit



class LGSportListCell:UITableViewCell {
    
    var sportName:UILabel
    var sportContent:UILabel
    var roomImage:UIImageView
    
    init(newStyle:UITableViewCellStyle, newReuseIdentifier:NSString) {
        
        sportName = UILabel(frame:CGRectZero )
        sportContent = UILabel(frame:CGRectZero)
        roomImage = UIImageView(frame:CGRectZero)
        
        super.init(style:newStyle, reuseIdentifier:newReuseIdentifier)
        
        //房间名
        sportName.frame = CGRectMake(10, 5, 225, 30)
        sportName.textAlignment = .Left
        sportName.font = UIFont.systemFontOfSize(18.0)
        sportName.backgroundColor = UIColor.clearColor()
        contentView.addSubview(sportName)
        
        //房间简介
        sportContent.frame = CGRectMake(10, 35, 225, 20)
        sportContent.textColor = UIColor.lightGrayColor()
        sportContent.textAlignment = .Left
        sportContent.font = UIFont.systemFontOfSize(12.0)
        sportContent.backgroundColor = UIColor.clearColor()
        contentView.addSubview(sportContent)
        
        //操作按钮
        
        contentView.addSubview(roomImage)
        
    }
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
}