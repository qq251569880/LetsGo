//
//  SecondViewController.swift
//  LetsGo
//
//  Created by 张宏台 on 15/7/7.
//  Copyright (c) 2015年 张宏台. All rights reserved.
//

import UIKit
import Foundation

class SecondViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,NSURLSessionDelegate{
    @IBOutlet weak var sportsList: UITableView!
    var sportsData:[LGSportInfo] = [LGSportInfo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        var url:String = "http://closefriend.sinaapp.com/Sport/List/sportlist";
        var postString:String = "sporttype=1";
        
        var  sessionConfig:NSURLSessionConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration()
        var inProcessSession = NSURLSession(configuration:sessionConfig, delegate:self, delegateQueue:NSOperationQueue.mainQueue())
        var nsurl:NSURL = NSURL(string:url)!;
        var req:NSMutableURLRequest = NSMutableURLRequest(URL:nsurl);
        req.HTTPMethod="POST";
        var postData:NSMutableData = NSMutableData();
        postData.appendData(postString.dataUsingEncoding(NSUTF8StringEncoding)!);
        req.HTTPBody = postData;
        var dataTask:NSURLSessionDataTask = inProcessSession.dataTaskWithRequest(req)
        dataTask.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //UITableViewDataSource协议实现
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        var cell : LGSportListCell?
        var sport:LGSportInfo?

        let identifier:String = "sportInfo"
        cell = tableView.dequeueReusableCellWithIdentifier(identifier) as? LGSportListCell
        if cell == nil {
            cell = LGSportListCell(newStyle:.Subtitle,newReuseIdentifier:identifier)
        }else
        {
            println("cell is nil")
        }
        sport = sportsData[indexPath.row]
            //cell!.operateBtn.titleLabel.text = "离开"

        println(" room \(sport!.sportName) add to \(indexPath.row)")
        cell!.sportName.text = "\(sport!.sportName)"
        cell!.sportContent.text =  "\(sport!.sportContent)"
        
        return cell!
        
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        var listCount:Int = 0

        listCount = sportsData.count

        return listCount
    }
    
    func tableView(tableView:UITableView , commitEditingStyle editingStyle:UITableViewCellEditingStyle, forRowAtIndexPath indexPath:NSIndexPath){
        if (editingStyle == .Delete)
        {

        }
    }
    //UITableViewDelegate协议实现
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!){
        //start a Chat
        var sportName:String? = sportsData[indexPath!.row].sportName
        var sportid:Int = sportsData[indexPath!.row].id
        println("Now switch to \(sportName)")
        
        self.performSegueWithIdentifier("chatting",sender:self)
        
    }
    //每一行的高度
    func tableView(tableView:UITableView, heightForRowAtIndexPath indexPath:NSIndexPath) -> CGFloat{
        return 53.0
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject? ){
        
        if (segue.identifier == "loginSuccess") {
            var mainController:LGMainViewController  = segue.destinationViewController as LGMainViewController;
            
            println("Chat classify is \(mainController)")
        }else{
            var regController:LGRegisterViewController  = segue.destinationViewController as LGRegisterViewController;
            
        }
    }
    func URLSession(session: NSURLSession!, dataTask: NSURLSessionDataTask!, didReceiveData data: NSData!){
        var tmp:NSString=NSString(data:data ,encoding:NSUTF8StringEncoding)!
        println(tmp)

        var writeError = NSErrorPointer()
        var jsons  = NSJSONSerialization.JSONObjectWithData(data ,options:NSJSONReadingOptions.MutableContainers,error:writeError) as? NSDictionary
        
        
        if (writeError != nil ){
            println(writeError.debugDescription)
        }else if( jsons == nil ){
            println("JSON error")
        }else{
            var status: AnyObject? = jsons!.objectForKey("head")?.objectForKey("status");
            if let s:Int = (status as? Int) {
                if(s == 0){
                    var body:AnyObject? = jsons!.objectForKey("body")
                    let sports = body as? [Dictionary<String,String>];
                    for item:Dictionary<String,String> in sports! {
                        println(item)
                    }
                }else{
                    LGAlert("tip", "用户名密码错误");
                }
            }else{
                LGAlert("tip","登录失败");
            }
        }
        
    }

}

