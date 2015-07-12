//
//  LGLoginViewController.swift
//  LetsGo
//
//  Created by 张宏台 on 15/7/9.
//  Copyright (c) 2015年 张宏台. All rights reserved.
////Users/zhanghongdai/Documents/workspace/LetsGo/LetsGo/LGLoginViewController.swift:38:9: 'NSURLRequest' does not have a member named 'setHTTPMethod'

import UIKit
import Foundation

class LGLoginViewController: UIViewController,UITextFieldDelegate,NSURLSessionDelegate {
    
    @IBOutlet weak var tipInfo: UILabel!
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var password: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginAction(sender: UIButton) {
        var username:String = self.userName.text
        var passwd:String = self.password.text
        //http://closefriend.sinaapp.com/Oauth/Oauth/login
        let url:String = "http://closefriend.sinaapp.com/Oauth/Oauth/login"
        var postString:String = "username=\(username)&password=\(passwd)";
        
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
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject? ){
        
        if (segue.identifier == "loginSuccess") {
            var mainController:LGMainViewController  = segue.destinationViewController as LGMainViewController;
            
            println("Chat classify is \(mainController)")
        }
    }
    //当用户按下return键或者按回车键，keyboard消失
    func textFieldShouldReturn(textField:UITextField) -> Bool {
        //if (textField == self.userText) {
        textField.resignFirstResponder();
        //}
        
        return true
    }
    
    //开始编辑输入框的时候，软键盘出现，执行此事件
    func textFieldDidBeginEditing(textField:UITextField)
    {
        var frame:CGRect = textField.frame;
        var offset:CGFloat = frame.origin.y + 32 - (self.view.frame.size.height - 216.0);//键盘高度216
        
        var animationDuration:NSTimeInterval  = 0.30;
        UIView.beginAnimations("ResizeForKeyboard",context:nil);
        UIView.setAnimationDuration(animationDuration)
        
        //将视图的Y坐标向上移动offset个单位，以使下面腾出地方用于软键盘的显示
        if(offset > 0) {
            self.view.frame = CGRectMake(0.0, -offset, self.view.frame.size.width, self.view.frame.size.height);
        }
        UIView.commitAnimations()
    }
    
    
    //输入框编辑完成以后，将视图恢复到原始状态
    func textFieldDidEndEditing(textField:UITextField)
    {
        self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    }
    func URLSession(session: NSURLSession!, dataTask: NSURLSessionDataTask!, didReceiveData data: NSData!){
        var tmp:NSString=NSString(data:data ,encoding:NSUTF8StringEncoding)!
        println(tmp)
/*
        var mdata:Dictionary<String,String> = Dictionary()
        mdata["aa"]="11";
        mdata["bb"] = "22";
        var writeError1 = NSErrorPointer()
        var jsons  = NSJSONSerialization.dataWithJSONObject(mdata, options: NSJSONWritingOptions.PrettyPrinted, error: writeError1)
        var tmp1:NSString=NSString(data:jsons! ,encoding:NSUTF8StringEncoding)!
        println(tmp1)
        */
        var writeError = NSErrorPointer()
        var jsons  = NSJSONSerialization.JSONObjectWithData(data ,options:NSJSONReadingOptions.MutableLeaves,error:writeError) as? NSDictionary

        
        if (writeError != nil ){
            println(writeError.debugDescription)
        }else if( jsons == nil ){
            println("JSON error")
        }else{
            var status: AnyObject? = jsons!.objectForKey("head")?.objectForKey("status");
            if let s:Int = (status as? Int) {
                if(s == 0){
                    self.performSegueWithIdentifier("loginSuccess",sender:self)
                }else{
                    tipInfo.text = "用户名密码错误";
                }
            }else{
                tipInfo.text = "登录失败"
            }
        }

    }
}
