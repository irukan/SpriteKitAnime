//
//  MyButton.h
//  DragEditor
//
//  Created by kayama on 14/10/24.
//  Copyright (c) 2014年 kayama. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DDEditor.h"

@interface MyButton : UIButton
{
    NSString *m_title;
    CGPoint m_setPos;
    
    DDEditor *rootView;
    MyTableViewController *tblView;
}
-(id)init:(CGPoint)center_in title:(NSString*)title_in;
@end
