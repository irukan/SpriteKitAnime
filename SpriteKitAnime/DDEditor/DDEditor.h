//
//  DDEditor.h
//  DragEditor
//
//  Created by kayama on 2014/11/01.
//  Copyright (c) 2014年 kayama. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyTableViewController.h"

@class AppDelegate;

@interface DDEditor : UIViewController
{
    MyTableViewController *tblView;
    
    // Appdelegate from swift
    AppDelegate *ad;
}

-(id)initWithFrame:(CGRect)frame;
+(DDEditor*)getViewController:(UIView*)self_in;
-(MyTableViewController*)getTable;
-(void)argInputView:(NSString*)cmdType cellIndex:(int)cellIndex_in;

@property (strong,readonly)MyTableViewController* tblView;
@property CGFloat width;
@property CGFloat height;


@end
