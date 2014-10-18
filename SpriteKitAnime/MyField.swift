//
//  MyField.swift
//  SpriteKitAnime
//
//  Created by Kayama on 2014/10/10.
//  Copyright (c) 2014年 Kayama. All rights reserved.
//

import UIKit
import SpriteKit

class MyField: MyObjectBase {

    init(cellSize:CGFloat, indexX:Int, indexY:Int)
    {
        super.init(cellSize:cellSize, indexX:indexX, indexY:indexY, isThrough:true)
        
        self.texture = self.ad.mapImgArr[80] as? SKTexture
        self.name = "field_"+String(indexX) + "_" + String(indexY)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
}
