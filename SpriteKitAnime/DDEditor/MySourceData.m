//
//  MySourceData.m
//  DragEditor
//
//  Created by kayama on 14/10/26.
//  Copyright (c) 2014年 kayama. All rights reserved.
//

#import "MySourceData.h"

@interface dataSet :NSObject
@property (nonatomic,strong)NSString* cmd;
@property (nonatomic,strong)NSString* arg;
@property int scopeLevel;
-(id)init:(NSString*)cmd arg:(NSString*)arg_in;
@end
@implementation dataSet
-(id)init:(NSString*)cmd_in arg:(NSString*)arg_in
{
    self.cmd = cmd_in;
    self.arg = arg_in;
    self.scopeLevel = 0;

    return [super init];
}
@end




@implementation MySourceData

-(int)count
{
    return (int)([data count]);
}

-(id)init
{
    data = [NSMutableArray array];
    [self addBlankLine:10];
    
    endPair = [NSMutableArray array];
    
    return [super init];
}

-(void)addBlankLine :(int)num
{

    for( int i=0; i< num;i++)
        [data addObject:[[dataSet alloc]init:@"" arg:@""]];
}

-(void)exchangeData:(int)fromIndex toIndex:(int)toIndex_in
{
    dataSet *item = (dataSet*)[data objectAtIndex:fromIndex]; // 移動対象を保持します。
    [data removeObject:item]; // 配列から一度消します。
    [data insertObject:item atIndex:toIndex_in]; // 保持しておいた対象を挿入します。
}

-(void)setData:(int)index cmd:(NSString*)cmd_in arg:(NSString*)arg_in
{
    if( !([cmd_in isEqualToString:@""]) )
    {
        [self setCmd:index cmd:cmd_in];
    }
    
    [self setArg:index arg:arg_in];
    
}

-(void)setCmd:(int)index cmd:(NSString*)cmd_in
{
    dataSet *get = (dataSet*)[data objectAtIndex:index];
    get.cmd = cmd_in;
    
    [data replaceObjectAtIndex:index withObject:get];
}

-(void)setArg:(int)index arg:(NSString*)arg_in
{
    dataSet *get = (dataSet*)[data objectAtIndex:index];
    get.arg = arg_in;
    
    [data replaceObjectAtIndex:index withObject:get];
}

-(void)setScopeLevel:(int)index scopeLevel:(int)sclvl_in
{
    dataSet *get = (dataSet*)[data objectAtIndex:index];
    get.scopeLevel = sclvl_in;
    
    [data replaceObjectAtIndex:index withObject:get];
}


-(NSString*)getCmdByIndex:(int)index
{
    dataSet *temp = (dataSet*)[data objectAtIndex:index];
    return temp.cmd;
}

-(NSString*)getArgByIndex:(int)index
{
    dataSet *temp = (dataSet*)[data objectAtIndex:index];
    return temp.arg;
}

-(int)getScopeLevelByIndex:(int)index
{
    dataSet *temp = (dataSet*)[data objectAtIndex:index];
    return temp.scopeLevel;
}

-(void)inserEndBlock:(int)index cmd:(NSString*)cmd_in
{
    [data insertObject:[[dataSet alloc]init:@"" arg:@""] atIndex:index + 1];
    //[data insertObject:[[dataSet alloc]init:[NSString stringWithFormat:@"end%@", cmd_in] arg:@""] atIndex:index + 2];
    [data insertObject:[[dataSet alloc]init:@"end" arg:@""] atIndex:index + 2];
}

-(void)resetScopeLevel
{
    int nowLevel = 0;
    [endPair removeAllObjects];
    
    for (int i=0; i< [data count]; i++)
    {
        NSString* getCmd = [self getCmdByIndex:i];
        
        if(([getCmd isEqualToString:@"if"])||([getCmd isEqualToString:@"while"]))
        {
            [self setScopeLevel:i scopeLevel:nowLevel];
            nowLevel++;
            
            [endPair addObject:getCmd];
        }
        //else if( ([getCmd rangeOfString:@"end"]).location != NSNotFound)
        else if( [getCmd isEqualToString:@"end"] )
        {
            nowLevel--;
            [self setScopeLevel:i scopeLevel:nowLevel];
            
            [self setArg:i arg:[endPair lastObject]];
            [endPair removeLastObject];
        }
        else
        {
            [self setScopeLevel:i scopeLevel:nowLevel];
        }
    }
}

-(NSMutableArray*)getSourceData
{

    NSMutableArray *ret = [NSMutableArray array];
    
    for (int i=0; i< [data count]; i++)
    {
        NSString* getCmd = [self getCmdByIndex:i];
        NSString* getArg = [self getArgByIndex:i];
        
        if( [getCmd isEqualToString:@"end"] )
        {
            // endwhile, endif にする
            [ret addObject:[NSString stringWithFormat:@"%@%@", getCmd, getArg]];
        }
        else if( [getCmd isEqualToString:@""] )
        {
            //空行
            [ret addObject:@""];
        }
        else
        {
            // walk , turn , while, if
            [ret addObject:[NSString stringWithFormat:@"%@ %@", getCmd, getArg]];
        }
    }
    
    return ret;
}

@end
