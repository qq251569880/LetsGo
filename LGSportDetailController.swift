//
//  LGSportDetailController.swift
//  LetsGo
//
//  Created by 张宏台 on 15/7/19.
//  Copyright (c) 2015年 张宏台. All rights reserved.
//

import UIKit
import Foundation

class LGSportDetailController: UIViewController,NSURLSessionDelegate {
    
    @IBOutlet weak var sportTitle: UILabel!
    @IBOutlet weak var sportCreater: UILabel!
    @IBOutlet weak var sportContent: UILabel!
    @IBOutlet weak var sportMember: UILabel!
    @IBOutlet weak var sportStartTime: UILabel!
    var sportId:Int = 0;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let url:String = "http://closefriend.sinaapp.com/Sport/List/sportdetail";
        let postString:String = "id=\(sportId)";
        
        let  sessionConfig:NSURLSessionConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration()
        let inProcessSession = NSURLSession(configuration:sessionConfig, delegate:self, delegateQueue:NSOperationQueue.mainQueue())
        let nsurl:NSURL = NSURL(string:url)!;
        let req:NSMutableURLRequest = NSMutableURLRequest(URL:nsurl);
        req.HTTPMethod="POST";
        let postData:NSMutableData = NSMutableData();
        postData.appendData(postString.dataUsingEncoding(NSUTF8StringEncoding)!);
        req.HTTPBody = postData;
        let dataTask:NSURLSessionDataTask = inProcessSession.dataTaskWithRequest(req)
        dataTask.resume()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func URLSession(session: NSURLSession!, dataTask: NSURLSessionDataTask!, didReceiveData data: NSData!){
        let tmp:NSString=NSString(data:data ,encoding:NSUTF8StringEncoding)!
        print(tmp)
        
        let json = JSON(data: data,options: NSJSONReadingOptions.MutableContainers)
        
        if let status = json["head"]["status"].uInt{
            if status == 0 {
                
                if let title = json["body"][0]["title"].string {
                    sportTitle.text = title;
                }
                if let creater = json["body"][0]["username"].string {
                    sportCreater.text = creater;
                }
                if let content = json["body"][0]["sport_content"].string {
                    sportContent.text = content;
                }
                if let people = json["body"][0]["tp_count"].string {
                    sportMember.text = people;
                }
                if let starttime = json["body"][0]["sport_start_time"].string {
                    sportStartTime.text = starttime;
                }
            }
        }
    }
    
}
