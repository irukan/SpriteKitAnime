//
//  MyScene.swift
//  SpriteKitAnime
//
//  Created by Kayama on 2014/09/28.
//  Copyright (c) 2014年 Kayama. All rights reserved.
//

import UIKit
import SpriteKit


class MyScene: SKScene, SKPhysicsContactDelegate {
 
    // Appdelegate
    var ad:AppDelegate!

    var cell:CGFloat!
    var player:MyPlayer!
    var goal:MyGoal!
    
    var upTime:CFTimeInterval!
    var lastUpdate:CFTimeInterval!
    
    var debugAreaPtr:UITextView!
    
    var isAnimated:Bool!
    

    

    // 画面初期化時に毎回呼ばれる
    override func didMoveToView(view: SKView) {
        
        ad = UIApplication.sharedApplication().delegate as AppDelegate
        
        //時間。あとで見直す
        upTime = 0
        lastUpdate = 0
        
        // ViewControllerの, debugArea
        debugAreaPtr = ad.debugArea
        

        isAnimated = false
        
        // sellの分割数は15で固定。今後はmapDataから読み込むようにする
        cell = self.size.width / 15
        
        //衝突検出のため、delegateを設定する
        self.physicsWorld.contactDelegate = self
        //四隅に壁
        //self.physicsBody = SKPhysicsBody(edgeLoopFromRect: self.frame)

        // Sceneの名前
        self.name = "MyScene"
        
        //MapData読み込み
        let dataPath = NSBundle.mainBundle().pathForResource("data2", ofType: "dat", inDirectory: "MapData")

        let text: String = String(contentsOfFile:dataPath!, encoding: NSUTF8StringEncoding, error: nil)!
        var indX:Int = 0
        var indY:Int = 0
        
        for line in text.componentsSeparatedByString("\r\n")
        {

            for data in line.componentsSeparatedByString(",")
            {
                //println("\(indX), \(indY)")
                if(data as NSString == "w")
                {
                    makeWall(indX, indexY: indY)
                }
                else if(data as NSString == "s")
                {
                    makePlayer(indX, indexY: indY)
                }
                else if(data as NSString == "g")
                {
                    makeField(indX, indexY: indY)
                    goal = MyGoal(cellSize: cell, indexX: indX, indexY: indY)
                    self.addChild(goal)
                }
                else if(data as NSString == "t")
                {
                    makeTree(indX, indexY: indY)
                }
                else if(data as NSString == "0")
                {
                    makeField(indX, indexY: indY)
                }
            
                indX++
            }
            indX = 0
            indY++
            
        }
    
        // GameMaster
        ad.gmMaster.setScene(self)
        ad.gmMaster.setExecCnt(3)
        ad.gmMaster.showExecCnt()
        
        ad.gmMaster.showStart()

    }

    func makeField(indexX:Int, indexY:Int)
    {
        // Filed
        let field = MyField(cellSize: cell, indexX: indexX, indexY: indexY)
        
        self.addChild(field)
    }
    
    func makeWall(indexX:Int, indexY:Int)
    {
        // 先ずはField
        makeField(indexX, indexY: indexY)
        // Wall
        let wall = MyWall(cellSize: cell, indexX: indexX, indexY: indexY)
        
        self.addChild(wall)
    }
 
    func makeTree(indexX:Int, indexY:Int)
    {
        // 先ずはField
        makeField(indexX, indexY: indexY)
        // Wall
        let tree = MyTree(cellSize: cell, indexX: indexX, indexY: indexY)
        
        self.addChild(tree)
    }

    
    func makePlayer(indexX:Int, indexY:Int)
    {
        // 先ずはField
        makeField(indexX, indexY: indexY)
        // Player
        player = MyPlayer(cellSize: cell, indexX: indexX, indexY:indexY)
        
        //Interpreterにセット
        ad.interpreter.setPlayerPtr(player)

        self.addChild(player)
    }

    func moveRight()
    {
        player.moveRight()
    }
    func moveLeft()
    {
        player.moveLeft()
    }
    func moveUp()
    {
        player.moveUp()
    }
    func moveDown()
    {
        player.moveDown()
    }
    

    override func update(currentTime: NSTimeInterval) {
        
        //初回のみ 大体1/60秒だと仮定する
        if (lastUpdate == 0.0)
        {
            lastUpdate = currentTime - 1.0 / 60.0
        }
        
        let diffTime:CFTimeInterval = currentTime - lastUpdate
        upTime = upTime + diffTime
        lastUpdate = currentTime
        
        //**秒を,更新タイミング
        if(upTime > 1.0)
        {

            
            if (isAnimated == true)
            {
                //compileActionAssembly(lines[progLine] as String)

                //progLine = progLine + 1
                
                let cmd = ad.interpreter.getCmd()
                ad.ddEditor.tblView.setHighLighted(ad.interpreter.nowRaw - 1 , color: UIColor.yellowColor(), isScroll: true)
                
                if(cmd != "end")
                {
                    compileActionAssembly(cmd)
                }
                else
                {
                    isAnimated = false
                }
            }
            
            if(player.isGoal(goal) )
            {
                ad.gmMaster.showGoal()
                isAnimated = false
            }
            //デバッグ情報更新
            debugPrint()
            
            upTime = 0
        }
    }
    
//    override func didSimulatePhysics() {
//      //  println(player.position.x)
//                      //  println(player.getFront())
//      //  println(player.getPosByIndex())
//    }
    
    //衝突
    func didBeginContact(contact: SKPhysicsContact!) {
        var firstObj:SKPhysicsBody!
        var secondObj:SKPhysicsBody!
        println("contact")
    }
    
    func compileActionAssembly(cmd: String)
    {
        switch cmd
        {
            case "r" :
                player.moveRight()
                break
            case "l" :
                player.moveLeft()
                break
            case "u" :
                player.moveUp()
                break
            case "d" :
                player.moveDown()
                break
            case "walk" :
                player.walk()
                break
            case "turnR":
                player.turnR()
                break
            case "turnL":
                player.turnL()
                break
            case "turnU":
                player.turnU()
                break
            case "turnD":
                player.turnD()
                break

            
            default :
                break
        }
    }
    
    func debugPrint()
    {
        var setTxt:String = "Debug Information\n\n"
        
        // playerの位置情報
        setTxt += "position :" + "\(player.getPosByIndex())" + "\n"
        
        // playerの向き
        //setTxt += "direction :" + "\(player.m_direct)" + "\n"
        
        // playerの目の前のSprite
        setTxt += "Front :" + player.getFront() + "\n"
        
        //goalにいるかどうか
        var glrslt = player.isGoal(goal) ? "true" : "false"
        setTxt += "isGoal:" + glrslt + "\n"

        setTxt += "\n"
        // interpreter cmd line
        setTxt += "isAnimated:" + "\(isAnimated)" + "\n"
        setTxt += "exec line:" + "\(ad.interpreter.nowRaw)" + "\n"
        
        debugAreaPtr.text = setTxt
    }
    

}
