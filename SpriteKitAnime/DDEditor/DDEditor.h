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

// デリゲートを定義
@protocol DDEditorDelegate <NSObject>

// デリゲートメソッドを宣言
- (void)editFinish;

@end

@interface DDEditor : UIViewController
{
    MyTableViewController *tblView;
    
    // Appdelegate from swift
    AppDelegate *ad;
    

}

// deleget property
@property (nonatomic, assign) id<DDEditorDelegate> delegate;

-(id)initWithFrame:(CGRect)frame;
+(DDEditor*)getViewController:(UIView*)self_in;
-(MyTableViewController*)getTable;
-(void)argInputView:(NSString*)cmdType cellIndex:(int)cellIndex_in;
-(void)setTableViewMode:(NSString*)viewMode setView:(UIView*)setView_in;


@property (strong,readonly)MyTableViewController* tblView;
@property CGFloat width;
@property CGFloat height;


@end
