//
//  LGPublic.swift
//  LetsGo
//
//  Created by 张宏台 on 15/7/16.
//  Copyright (c) 2015年 张宏台. All rights reserved.
//

import UIKit
import Foundation

struct LGSportInfo{
    init(){}
    var id:Int = 0;
    var sportName:String = "";
    var address:String = "";
    var sportStartName:String = "";
    var sportEndName:String = "";
    var peopleMin:Int = 0;
    var peopleMax:Int = 0;
    var sportContent:String = "";
    var creater:String = "";
    var sportType:Int = 0;
    var sportMember = 0;
}
func LGAlert(title:String,content:String){
    let alert = UIAlertView()
    alert.title = title
    alert.message = content
    alert.addButtonWithTitle("Ok")
    alert.show()
}