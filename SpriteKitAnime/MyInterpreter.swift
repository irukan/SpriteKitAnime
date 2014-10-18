//
//  MyInterpreter.swift
//  SpriteKitAnime
//
//  Created by Kayama on 2014/10/13.
//  Copyright (c) 2014年 Kayama. All rights reserved.
//

import Foundation

class WalkBlock
{
    var m_walk:Int!
    init(walkCount:Int)
    {
        m_walk = walkCount
    }
    
}

class MyInterpreter
{
    var rawLine:NSMutableArray!
    var decodeLine:NSMutableArray!
    
    var nowRaw:Int!
    var nowDecode:Int!
    var whileStart:NSMutableArray!
    var whileArg:NSMutableArray!
    
    var ptrPlayer:MyPlayer?
    
  
    
    
    init()
    {
        rawLine = NSMutableArray()
        decodeLine = NSMutableArray()
       
    }
    
    func setPlayerPtr(player_in:MyPlayer)
    {
        ptrPlayer = player_in
    }
    
    func setRawLine(input: NSArray)
    {
        rawLine = input.mutableCopy() as NSMutableArray
        decodeLine.removeAllObjects()
        nowRaw = 0
        nowDecode = 0
        whileStart = NSMutableArray()
        whileArg = NSMutableArray()
    }
    
    func getCmd()->(String)
    {
        
        if((nowRaw == rawLine.count) && (nowDecode == decodeLine.count))
        {
            return "end"
        }
        
        
        if(nowDecode == decodeLine.count)
        {
            decorder(rawLine[nowRaw] as String)
            nowRaw = nowRaw + 1
            nowDecode = 0
        }
        
        let ret:String = decodeLine.count > 0 ? decodeLine[nowDecode] as String : "end"
        
        nowDecode = nowDecode + 1
        return ret
    }
    
    
    func anaRawLine(line:String) ->(cmd:String, arg:String)
    {
        let spLine = line.componentsSeparatedByString(" ")
        
        if(spLine.count == 2)
        {
            return (spLine[0], spLine[1])
        }
        else
        {
            return (spLine[0], "")
        }
    }
    
    
    func decorder(line: String)
    {
        decodeLine.removeAllObjects()
        
        var (cmd, arg) = anaRawLine(line)
        
        switch (cmd)
        {
            case "walk":
                walkBlk(arg.toInt()!)
                break
            
            case "turn":
                turnBlk(arg)
                break
            
            case "if":
                ifFrontBlk(arg)
                break
            case "endif":
                endifBlk()
                break
            
            case "while":
                whileFrontBlk(arg)
                break
            case "endwhile":
                endwhileBlk()
                break
            
            default:
                nextStep()
                break
        }
    }
    
    func nextStep()
    {
        if( (nowRaw + 1 ) != rawLine.count)
        {
            nowRaw = nowRaw + 1
            decorder(rawLine[nowRaw] as String)
            nowDecode = 0
        }
    }
    
    func walkBlk(walkCnt:Int)
    {
        for (var i=0;i < walkCnt; i++)
        {
            decodeLine.addObject("walk")
        }
    }
    
    func turnBlk(arg:String)
    {
        switch (arg)
            {
                case "r":
                    decodeLine.addObject("turnR")
                    break
                case "l":
                    decodeLine.addObject("turnL")
                    break
                case "u":
                    decodeLine.addObject("turnU")
                    break
                case "d":
                    decodeLine.addObject("turnD")
                    break
                default:
                    break
        }
    }
    
    func ifFrontBlk(arg:String)
    {
        if(ptrPlayer!.getFrontObject() == arg)
        {
            nowRaw = nowRaw + 1
            decorder(rawLine[nowRaw] as String)
            nowDecode = 0
        }
        else
        {

            var getline:String = ""
            while(getline != "endif")
            {
                getline = rawLine[nowRaw] as String
                nowRaw = nowRaw + 1
            }
            decorder(rawLine[nowRaw] as String)
            nowDecode = 0
            
        }
    }
    
    func endifBlk()
    {
        nextStep()
    }
    
    func whileFrontBlk(arg:String)
    {
        whileStart.addObject(nowRaw + 1)
        whileArg.addObject(arg)
        
        nowRaw = nowRaw + 1
        decorder(rawLine[nowRaw] as String)
    }
    
    func endwhileBlk()
    {
        let whileStartGet = whileStart.lastObject as Int
        let whileArgGet = whileArg.lastObject as String
        
        if(ptrPlayer!.getFrontObject() != whileArgGet)
        {
            nowRaw = whileStartGet
            decorder(rawLine[nowRaw] as String)
        }
        else
        {
            whileStart.removeLastObject()
            whileArg.removeLastObject()

            nextStep()
        }
    }
    
    
    
    
    
    
    
    
}
