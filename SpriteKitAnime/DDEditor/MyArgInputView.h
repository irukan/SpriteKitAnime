//
//  MyArgInputView.h
//  DragEditor
//
//  Created by kayama on 14/10/27.
//  Copyright (c) 2014年 kayama. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DDEditor.h"

enum Enum_cmdType {
    Type_walk = 0,
    Type_turn,
    Type_if,
    Type_while
};
typedef enum Enum_cmdType cmdType ;

@interface MyArgInputView : UIView
{
    cmdType m_type;
    int m_cellIndex;
    
    DDEditor *rootView;
    MyTableViewController *tblView;
}

-(id)initWithType:(NSString*)cmd index:(int)index_in size:(CGSize)size_in;

@end
