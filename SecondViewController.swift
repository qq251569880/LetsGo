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
    var sportId = 0;
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        sportsList.delegate = self
        sportsList.dataSource = self
        let url:String = "http://closefriend.sinaapp.com/Sport/List/sportlist";
        let postString:String = "sporttype=1&fields=title,tpcount,nindex,username";
        
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
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        sportsList.reloadData()
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
            print("cell is nil")
        }
        sport = sportsData[indexPath.row]
            //cell!.operateBtn.titleLabel.text = "离开"

        print(" room \(sport!.sportName) add to \(indexPath.row)")
        cell!.sportName.text = "\(sport!.sportName)"
        cell!.sportCreator.text =  "\(sport!.creater)"
        cell!.sportMember.text = "\(sport!.sportMember)"
        return cell!
        
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        var listCount:Int = 0

        listCount = sportsData.count
        print("count = \(listCount)")
        return listCount
    }
    
    func tableView(tableView:UITableView , commitEditingStyle editingStyle:UITableViewCellEditingStyle, forRowAtIndexPath indexPath:NSIndexPath){
        if (editingStyle == .Delete)
        {

        }
    }
    //UITableViewDelegate协议实现
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        //start a Chat
        let sportName:String? = sportsData[indexPath.row].sportName
        sportId = sportsData[indexPath.row].id
        print("Now switch to \(sportName)")
        
        self.performSegueWithIdentifier("showdetail",sender:self)
        
    }
    //每一行的高度
    func tableView(tableView:UITableView, heightForRowAtIndexPath indexPath:NSIndexPath) -> CGFloat{
        return 53.0
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject? ){
        
        if (segue.identifier == "showdetail") {
            let detailController:LGSportDetailController  = segue.destinationViewController as! LGSportDetailController;
            detailController.sportId = sportId;
            print("Chat classify is \(detailController)")
        }else{
            print(segue.identifier)
            
        }
    }
    func URLSession(session: NSURLSession!, dataTask: NSURLSessionDataTask!, didReceiveData data: NSData!){
        let tmp:NSString=NSString(data:data ,encoding:NSUTF8StringEncoding)!
        print(tmp)

        let json = JSON(data: data,options: NSJSONReadingOptions.MutableContainers)
        
        if let status = json["head"]["status"].uInt{
            if status == 0 {
                if let sports = json["body"]["list"].array {
                    for sport in sports{
                        print(sport)
                        var sportData:LGSportInfo = LGSportInfo();
                        if let name = sport["title"].string{
                            sportData.sportName = name
                        }
                        if let id = Int((sport["nindex"].string)!) {
                            sportData.id  = id
                            
                        }
                        if let creater = sport["username"].string{
                            sportData.creater = creater
                        }
                        if let number = Int((sport["tpcount"].string)!){
                            sportData.sportMember = number
                        }
                        sportsData.append(sportData);
                    }
                }
            }else{
                LGAlert("tip",content: "获取列表失败");
            }
        }
        sportsList.reloadData()

    }

}

