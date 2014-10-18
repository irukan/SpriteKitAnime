//
//  AppDelegate.swift
//  SpriteKitAnime
//
//  Created by Kayama on 2014/09/28.
//  Copyright (c) 2014年 Kayama. All rights reserved.
//

import UIKit
import SpriteKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var progArea: UITextView!
    var debugArea: UITextView!
    
    var StatusBar:CGFloat!
    var WWidth:CGFloat!
    var WHeight:CGFloat!
    
    var SWidth:CGFloat!
    var SHeight:CGFloat!
    
    
    var mapImgArr:NSMutableArray!
    
    var interpreter:MyInterpreter!
    
    var gmMaster:GameMaster!
    
    func initImgArr()
    {
        mapImgArr = NSMutableArray()
        
        interpreter = MyInterpreter()
        
        var picture:SKTexture = SKTexture(imageNamed: "mapItem")

        let numX = 8
        let numY = 11
        
        let chipsize = CGSizeMake( picture.size().width / CGFloat(numX), picture.size().height / CGFloat(numY) )
        
        
        let Wratio = chipsize.width / picture.size().width
        let Hratio = chipsize.height / picture.size().height
        
        for(var y = 0 ; y < numY; y++){
            for(var x = 0; x < numX; x++){
                
                // 切り出し範囲。実際の大きさではなく、割合で指定する
                let cutRect:CGRect = CGRectMake(Wratio * CGFloat(x), Hratio * CGFloat(y), Wratio, Hratio)
                let imgCellTemp: SKTexture = SKTexture(rect:cutRect, inTexture: picture)
                mapImgArr.addObject(imgCellTemp)
            }
            
        }

    }

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        StatusBar = UIApplication.sharedApplication().statusBarFrame.height
        WWidth = window?.bounds.width
        WHeight = window?.bounds.height
        SWidth = WWidth
        SHeight = WWidth
        
        // progArea
        progArea = UITextView(frame: CGRectMake(0, SHeight, WWidth / 2.0, WHeight - SHeight))
        progArea.layer.borderWidth = 2
        progArea.layer.borderColor = UIColor.blueColor().CGColor
        progArea.layer.cornerRadius = 4
        progArea.keyboardType = UIKeyboardType.ASCIICapable
        
        // debugArea
        debugArea = UITextView(frame: CGRectMake(WWidth / 2.0, SHeight, WWidth / 2.0, WHeight - SHeight))
        debugArea.layer.borderWidth = 2
        debugArea.layer.borderColor = UIColor.redColor().CGColor
        debugArea.layer.cornerRadius = 4
        debugArea.editable = false
        
        // 画像ファイルの読み見込み
        initImgArr()
        
        // GameMaster
        gmMaster = GameMaster()
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

