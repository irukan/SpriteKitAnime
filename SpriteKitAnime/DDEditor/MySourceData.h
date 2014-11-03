//
//  MySourceData.h
//  DragEditor
//
//  Created by kayama on 14/10/26.
//  Copyright (c) 2014年 kayama. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MySourceData : NSObject
{
    NSMutableArray *data;
    NSMutableArray *endPair;
}

@property (readonly)int count;

-(id) init;
-(void)exchangeData:(int)fromIndex toIndex:(int)toIndex_in;
-(void)inserEndBlock:(int)index cmd:(NSString*)cmd_in;
-(void)addBlankLine :(int)num;

-(void)setData:(int)index cmd:(NSString*)cmd_in arg:(NSString*)arg_in;
-(void)setCmd:(int)index cmd:(NSString*)cmd_in;
-(void)setArg:(int)index arg:(NSString*)arg_in;
-(void)setScopeLevel:(int)index scopeLevel:(int)sclvl_in;

-(NSString*)getCmdByIndex:(int)index;
-(NSString*)getArgByIndex:(int)index;
-(int)getScopeLevelByIndex:(int)index;

-(void)resetScopeLevel;

-(NSMutableArray*)getSourceData;
@end
