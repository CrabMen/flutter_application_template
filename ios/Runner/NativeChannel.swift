//
//  NativeChannel.swift
//  Runner
//
//  Created by 骚强 on 2024/1/8.
//

import Foundation
import Flutter
class NativeChannel {
    
    static var channelName = "NativeChannel";
    static var channel = FlutterMethodChannel(name: channelName, binaryMessenger: (keyWindow!.rootViewController as! FlutterViewController).binaryMessenger)
    
    static func launch() -> Void {
        
//        let controller : FlutterViewController = keyWindow!.rootViewController as! FlutterViewController;
        
//        let channel = FlutterMethodChannel(name: "NativeChannel", binaryMessenger: controller.binaryMessenger)
    
        
        channel.setMethodCallHandler { call ,result in
            if(call.method == "showAlert"){
                showAlert(call: call, result: result);
            }
        }
        
    }
    

    static func showAlert(call:FlutterMethodCall, result :@escaping FlutterResult){
        
        
        let dictionary = call.arguments as! Dictionary<String,String>
       
        let title = dictionary["title"] ?? "调用原生"
        let content = dictionary["content"] ?? "消息"

        
        let alertController = UIAlertController(title: title, message: content, preferredStyle: .alert)
        
        
        let okAction = UIAlertAction(title: "确定", style: .default) { (_) in
           print("原生点击了确定")
            
           result("用户点击了确定按钮哟")

        }
        
       
        
        alertController.addAction(okAction)
        let controller : FlutterViewController = keyWindow!.rootViewController as! FlutterViewController
        controller.present(alertController, animated: true)
        
    }
    
}

func convertStringToDictionary(text: String) -> [String:String] {
    var dictionary = Dictionary<String, String>();
    
    
    
    if let data = text.data(using: .utf8) {
        do {
            dictionary = try JSONSerialization.jsonObject(with: data, options: []) as! [String: String]
            print("字典解析%@",dictionary)
        } catch {
            print("字典解析错误%@",error)
        }
    }

    return dictionary
}


public var keyWindow: UIWindow? {
    
    if #available(iOS 14.0, *) {
        
        if let window = UIApplication.shared.connectedScenes.map({$0 as? UIWindowScene}).compactMap({$0}).first?.windows.first {
            
            return window
            
        }else if let window = UIApplication.shared.delegate?.window {
            
            return window
            
        }else{
            
            return nil
            
        }
        
    } else if #available(iOS 13.0, *) {
        
        if let window = UIApplication.shared.connectedScenes
            
            .filter({$0.activationState == .foregroundActive})
            
            .map({$0 as? UIWindowScene})
            
            .compactMap({$0})
            
            .first?.windows
            
            .filter({$0.isKeyWindow}).first{
            
            return window
            
        } else if let window = UIApplication.shared.delegate?.window {
            return window
            
        } else {
            
            return nil
            
        }
        
    } else {
        
        if let window = UIApplication.shared.delegate?.window {
            
            return window
            
        }else{
            
            return nil
            
        }
        
    }
    
}
