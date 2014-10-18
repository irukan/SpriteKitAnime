//
//  ViewController.swift
//  SpriteKitAnime
//
//  Created by Kayama on 2014/09/28.
//  Copyright (c) 2014年 Kayama. All rights reserved.
//

import UIKit
import SpriteKit


class ViewController: UIViewController, UITextViewDelegate {

    // Appdelegate
    var ad:AppDelegate!
    
    
    var skView:SKView!
    var scene1:MyScene!
    
    var progAreaPtr:UITextView!
    var debugAreaPtr:UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ad = UIApplication.sharedApplication().delegate as AppDelegate
        
        
        // Do any additional setup after loading the view, typically from a nib.

        // View
        skView = SKView(frame: CGRectMake(0,0, ad.SWidth, ad.SHeight))
        skView.showsFPS = true;
        skView.showsNodeCount = true
       
        
        //scene1
        scene1 = MyScene(size: CGSizeMake(ad.SWidth, ad.SHeight))
        scene1.backgroundColor = SKColor.grayColor()


        // program 記述領域
        progAreaPtr = ad.progArea
        progAreaPtr.delegate = self
        self.view.addSubview(progAreaPtr)
        
        // debug情報出力領域
        debugAreaPtr = ad.debugArea
        self.view.addSubview(debugAreaPtr)
        
 
        // Viewにscene1を設定
        skView.presentScene(scene1)
        
        self.view.addSubview(skView)

    }


    func textViewShouldBeginEditing(textView: UITextView) -> Bool {
        
        UIView.animateWithDuration(1.0, animations: {
                self.skView.alpha = 0.0
                self.debugAreaPtr.frame = CGRectMake(self.ad.WWidth / 2.0, self.ad.WHeight, self.ad.WWidth / 2.0,
                    self.ad.WHeight - self.ad.SHeight)
                self.progAreaPtr.frame = CGRectMake(0, self.ad.StatusBar, self.ad.SWidth, self.ad.SHeight - 30)
        })

        return true
    }
    
    func textViewShouldEndEditing(textView: UITextView) -> Bool {
        
        UIView.animateWithDuration(0.8, animations: {
                self.skView.alpha = 1.0
                self.debugAreaPtr.frame = CGRectMake(self.ad.WWidth / 2.0, self.ad.SHeight, self.ad.WWidth / 2.0,
                    self.ad.WHeight - self.ad.SHeight)
                self.progAreaPtr.frame = CGRectMake(0, self.ad.SHeight, self.ad.WWidth / 2.0 , self.ad.WHeight - self.ad.SHeight)
        })
        scene1.isAnimated = true
 
        let strArr:NSArray = textView.text.componentsSeparatedByString("\n")

        self.ad.interpreter.setRawLine(strArr)
        
        self.ad.gmMaster.execCmd()
        
        return true
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // タッチイベント
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        
        for touch: AnyObject in touches{
            
            progAreaPtr.resignFirstResponder()
            
            let location = touch.locationInNode(scene1)
            
            //var nodeName = scene1.nodeAtPoint(location).name!
            //println("Node" + scene1.nodeAtPoint(location).name!)
            
        }
        
        
    }

}

