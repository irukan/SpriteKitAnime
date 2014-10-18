//
//  MyObjectBase.swift
//  SpriteKitAnime
//
//  Created by Kayama on 2014/10/10.
//  Copyright (c) 2014年 Kayama. All rights reserved.
//

import UIKit
import SpriteKit

class MyObjectBase: SKSpriteNode {
   
    func getPosByIndex(indexX:Int, indexY:Int)->(CGFloat, CGFloat)
    {
        return (m_cell*CGFloat(indexX), ad.SHeight - m_cell*CGFloat(indexY))
    }
    
    func getIndexByPosition(posX:CGFloat, posY:CGFloat)->(Int, Int)
    {
        return (Int(posX / m_cell), Int( (ad.SHeight - posY) / m_cell))
    }

    
    // Appdelegate
    var ad:AppDelegate!
    
    var isThrough:Bool
    
    var m_cell:CGFloat!
    
    init(cellSize:CGFloat, indexX:Int, indexY:Int, isThrough:Bool)
    {
        // AppDelegate
        ad = UIApplication.sharedApplication().delegate as AppDelegate
        
        self.isThrough = isThrough
        super.init(texture: nil, color: nil, size: CGSizeMake(cellSize, cellSize))

        m_cell = cellSize
        
        var (posX, posY) = getPosByIndex(indexX, indexY: indexY)
        posX = posX + m_cell / 2.0
        posY = posY - m_cell / 2.0
        self.position = CGPointMake(posX, posY)

        
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
}
