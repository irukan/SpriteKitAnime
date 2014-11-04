//
//  ViewController.swift
//  SpriteKitAnime
//
//  Created by Kayama on 2014/09/28.
//  Copyright (c) 2014年 Kayama. All rights reserved.
//

import UIKit
import SpriteKit


class ViewController: UIViewController, DDEditorDelegate {

    // Appdelegate
    var ad:AppDelegate!
    
    
    var skView:SKView!
    var scene1:MyScene!
    
    var debugAreaPtr:UITextView!
    
    
    override func viewWillAppear(animated: Bool) {
        ad.ddEditor.setTableViewMode("debugView", setView: self.view)
    }
    
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

        
        // ddEditor テーブル表示
        ad.ddEditor.setTableViewMode("debugView", setView: self.view)
        ad.ddEditor.delegate = self
        
        // ddEditorを覆う透明なCover
        let ddEditorCover : UIButton = UIButton(frame: ad.ddEditor.tblView.tableView.frame)
        ddEditorCover.addTarget(self, action: "pushCover:", forControlEvents: UIControlEvents.TouchDown)
        self.view.addSubview(ddEditorCover)
        
        
        // debug情報出力領域
        debugAreaPtr = ad.debugArea
        self.view.addSubview(debugAreaPtr)
        
 
        // Viewにscene1を設定
        skView.presentScene(scene1)
        
        self.view.addSubview(skView)

    }
    
    func pushCover(sender:UIButton)
    {
        ad.ddEditor.setTableViewMode("inputView", setView: ad.ddEditor.view)
        self.presentViewController(ad.ddEditor, animated: true, completion: nil)
    }

    //delegate実装
    func editFinish() {
        scene1.isAnimated = true
        
        let strArr:NSArray = ad.ddEditor.tblView.getSourceData()
        
        self.ad.interpreter.setRawLine(strArr)
        
        self.ad.gmMaster.execCmd()

    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

//    // タッチイベント
//    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
//        
//        for touch: AnyObject in touches{
//            
//            
//            let location = touch.locationInNode(scene1)
//            
//            //var nodeName = scene1.nodeAtPoint(location).name!
//            //println("Node" + scene1.nodeAtPoint(location).name!)
//            
//        }
//        
//        
//    }

}

