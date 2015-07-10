//
//  LGLoginViewController.swift
//  LetsGo
//
//  Created by 张宏台 on 15/7/9.
//  Copyright (c) 2015年 张宏台. All rights reserved.
//


import UIKit

class LGLoginViewController: UIViewController,UITextFieldDelegate {
    
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
        var urlLogin:String = "http://closefriend.sinaapp.com/Oauth/Oauth/login"
        
        self.performSegueWithIdentifier("loginSuccess",sender:self)
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

}
