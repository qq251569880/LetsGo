//
//  LGRegisterViewController.swift
//  LetsGo
//
//  Created by 张宏台 on 15/7/15.
//  Copyright (c) 2015年 张宏台. All rights reserved.
//

import UIKit
import Foundation


class LGRegisterViewController: UIViewController,UITextFieldDelegate,NSURLSessionDelegate {

    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var passwd: UITextField!
    @IBOutlet weak var passwd2: UITextField!

    @IBOutlet weak var tipinfo: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func backLoginAction(sender: AnyObject) {
        self.dismissViewControllerAnimated(true,completion:nil)
    }
    @IBAction func RegisterAction(sender: UIButton) {
        let username:String = self.username.text!
        let password:String = self.passwd.text!
        let password2:String = self.passwd2.text!
        if(password != password2){
            tipinfo.text = "两次密码输入不同";
            return;
        }
        //http://closefriend.sinaapp.com/Oauth/Oauth/login
        let url:String = "http://closefriend.sinaapp.com/Oauth/Oauth/register"
        let postString:String = "username=\(username)&password=\(password)";
        
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
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject? ){
        
        if (segue.identifier == "registerSuccess") {
            let mainController:LGMainViewController  = segue.destinationViewController as! LGMainViewController;
            
            print("Chat classify is \(mainController)")
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
        let frame:CGRect = textField.frame;
        let offset:CGFloat = frame.origin.y + 32 - (self.view.frame.size.height - 216.0);//键盘高度216
        
        let animationDuration:NSTimeInterval  = 0.30;
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
        let tmp:NSString=NSString(data:data ,encoding:NSUTF8StringEncoding)!
        print(tmp)
        /*
        var mdata:Dictionary<String,String> = Dictionary()
        mdata["aa"]="11";
        mdata["bb"] = "22";
        var writeError1 = NSErrorPointer()
        var jsons  = NSJSONSerialization.dataWithJSONObject(mdata, options: NSJSONWritingOptions.PrettyPrinted, error: writeError1)
        var tmp1:NSString=NSString(data:jsons! ,encoding:NSUTF8StringEncoding)!
        println(tmp1)
        */
        var jsons:NSDictionary?
        var writeError = NSErrorPointer()
        do{
            jsons  = try NSJSONSerialization.JSONObjectWithData(data ,options:NSJSONReadingOptions.MutableLeaves) as? NSDictionary
        }catch {
            
        }
        
        if (writeError != nil ){
            print(writeError.debugDescription)
        }else if( jsons == nil ){
            print("JSON error")
        }else{
            let status: AnyObject? = jsons!.objectForKey("head")?.objectForKey("status");
            if let s:Int = (status as? Int) {
                if(s == 0){
                    self.performSegueWithIdentifier("registerSuccess",sender:self)
                }else{
                    tipinfo.text = "用户名被占用 err=\(s)";
                }
            }else{
                tipinfo.text = "注册失败"
            }
        }
        
    }
}
