//
//  GameMaster.swift
//  SpriteKitAnime
//
//  Created by Kayama on 2014/10/18.
//  Copyright (c) 2014年 Kayama. All rights reserved.
//

import Foundation
import SPriteKit

class GameMaster
{
    var scenePtr:SKScene!
    var m_execCmd:Int?
    
    init()
    {
    }
    
    func setScene(scene: SKScene)
    {
        scenePtr = scene
    }

    func setExecCnt(cnt:Int)
    {
        m_execCmd = cnt
    }
    
    func execCmd()
    {
        m_execCmd = m_execCmd! - 1
        
        if(m_execCmd != 0)
        {
         showExecCnt()
        }
        else
        {
            showGameOver()
        }
    }
    
    func showExecCnt()
    {
        //前回のやつ消す
        scenePtr.childNodeWithName("ExecCmdLbl")?.removeFromParent()
        
        var lbl:SKLabelNode = SKLabelNode()
        lbl.name = "ExecCmdLbl"
        lbl.fontSize = 20.0
        lbl.fontColor = SKColor.redColor()
        
        lbl.text = "残り : " + "\(m_execCmd!)"
        lbl.position = CGPointMake(50, 10)
        scenePtr.addChild(lbl)
    }
    
    func showStart()
    {
        var lbl = SKLabelNode()
        lbl.name = "StartLbl"
        
        lbl.text = "Game Start!!"
        lbl.position = CGPointMake(scenePtr.size.width/2.0, scenePtr.size.height)
        
        scenePtr.addChild(lbl)
        
        //表示から消すまでのアニメーション
        let moveDown = SKAction.moveTo(CGPointMake(scenePtr.size.width/2.0, scenePtr.size.height/2.0), duration: 0.5)
        let wait = SKAction.waitForDuration(1.0)
        let sequence = SKAction.sequence([moveDown, wait])
        
        lbl.runAction(sequence, completion: {() ->Void in
            lbl.removeFromParent()
        })
    }
    
    func showGameOver()
    {
        var lbl = SKLabelNode()
        lbl.name = "GameOverLbl"
        
        lbl.text = "Game over!!"
        lbl.position = CGPointMake(scenePtr.size.width/2.0, scenePtr.size.height/2.0)
        
        scenePtr.addChild(lbl)
        
        //表示から消すまでのアニメーション
        let wait = SKAction.waitForDuration(3.0)
        let sequence = SKAction.sequence([wait])


        lbl.runAction(sequence, completion: {() ->Void in
            self.scenePtr.removeAllChildren()
        })
    }
    
    func showGoal()
    {
        // Particle 表示
        let path:String = NSBundle.mainBundle().pathForResource("GoalScene", ofType: "sks")!
        let particle = NSKeyedUnarchiver.unarchiveObjectWithFile(path) as SKEmitterNode
        particle.particleScale = 0.3
        particle.particleLifetime = 3.0
        particle.position = CGPointMake(scenePtr.size.width/2.0, scenePtr.size.height/0.7)
        scenePtr.addChild(particle)
        
        
        
        var lbl = SKLabelNode()
        lbl.name = "GoalLbl"
        
        lbl.text = "Goal !!"
        lbl.position = CGPointMake(scenePtr.size.width/2.0, scenePtr.size.height)

        scenePtr.addChild(lbl)
        //表示から消すまでのアニメーション
        let moveDown = SKAction.moveTo(CGPointMake(scenePtr.size.width/2.0, scenePtr.size.height/2.0), duration: 0.5)
        let wait = SKAction.waitForDuration(1.0)
        let sequence = SKAction.sequence([moveDown, wait])
        
        lbl.runAction(sequence, completion: {() ->Void in
            //lbl.removeFromParent()
        })

   
    }
}