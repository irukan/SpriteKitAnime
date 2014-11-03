//
//  MyTableViewController.h
//  DragEditor
//
//  Created by kayama on 14/10/24.
//  Copyright (c) 2014年 kayama. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MySourceData.h"

@interface MyTableViewController : UITableViewController
{
    MySourceData *sourceData;
}
-(int)getCellIndexByPos:(CGPoint)pos;
-(NSString*)getCmdByIndex:(int)index;

-(void)setDataByIndex:(int)index cmd:(NSString*)cmd_in arg:(NSString*)arg_in;
-(void)setDataByIndexWithEndBlock:(int)index cmd:(NSString *)cmd_in arg:(NSString *)arg_in;

-(void)setHighLighted:(int)index color:(UIColor*)color_in isScroll:(bool)isScroll_in;


-(NSMutableArray*)getSourceData;
@end
