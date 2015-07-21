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
    var sportCreator:UILabel
    var sportMember:UILabel
    
    init(newStyle:UITableViewCellStyle, newReuseIdentifier:NSString) {
        
        sportName = UILabel(frame:CGRectZero )
        sportCreator = UILabel(frame:CGRectZero)
        sportMember = UILabel(frame:CGRectZero)
        
        super.init(style:newStyle, reuseIdentifier:newReuseIdentifier)
        
        //房间名
        sportName.frame = CGRectMake(10, 5, 225, 30)
        sportName.textAlignment = .Left
        sportName.font = UIFont.systemFontOfSize(18.0)
        sportName.backgroundColor = UIColor.clearColor()
        contentView.addSubview(sportName)
        
        //房间创建者
        sportCreator.frame = CGRectMake(10, 35, 225, 20)
        sportCreator.textColor = UIColor.lightGrayColor()
        sportCreator.textAlignment = .Left
        sportCreator.font = UIFont.systemFontOfSize(12.0)
        sportCreator.backgroundColor = UIColor.clearColor()
        contentView.addSubview(sportCreator)
        
        //活动参与人数
        
        sportMember.frame = CGRectMake(255, 10, 285, 20)
        sportMember.textColor = UIColor.lightTextColor()
        sportMember.textAlignment = .Left
        sportMember.font = UIFont.systemFontOfSize(10.0)
        sportMember.backgroundColor = UIColor.clearColor()
        contentView.addSubview(sportMember)
        
    }
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
}