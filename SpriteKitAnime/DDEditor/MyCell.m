//
//  MyCell.m
//  DragEditor
//
//  Created by kayama on 14/10/24.
//  Copyright (c) 2014年 kayama. All rights reserved.
//

#import "MyCell.h"

@implementation MyCell

-(CGRect)realFrame
{
    
    CGPoint offset = tblView.tableView.contentOffset;
    
    CGRect ret = self.frame;
    ret.origin = CGPointMake(ret.origin.x - offset.x,
                             ret.origin.y - offset.y);
    return ret;
}

-(id) init:(int)index indentLevel:(int)indetLevel_in
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    
    if(self)
    {
        m_index = index;
        m_indentLevel = indetLevel_in;
    }
    
    return  self;
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)didMoveToSuperview
{
    rootView = [DDEditor getViewController:self];
    tblView = [rootView getTable];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    //[super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

// Dataをセットし、cellの表示を変える
-(void) setData:(NSString*)cmd_in arg:(NSString*)arg_in
{
    NSString *indentSpace=@"";
    for(int i=0; i< m_indentLevel;i++)
    {
        indentSpace = [NSString stringWithFormat:@"%@    ",indentSpace];
    }
    
    self.textLabel.text = [NSString stringWithFormat:@"%@%@ %@",indentSpace, cmd_in, arg_in];
}

-(int)getIndex
{
    return  m_index;
}

-(int)getIndexLevel
{
    return m_indentLevel;
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
   // [tblView setHighLighted:m_index color:[UIColor grayColor] isScroll:false];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    //[tblView setHighLighted:m_index color:[UIColor whiteColor] isScroll:false];
    
    NSString *getCmd = [tblView getCmdByIndex:m_index];
    
    if ( !([getCmd isEqualToString:@""]) && !([getCmd isEqualToString:@"end"]))
    {
        // ArgInputWindow
        [rootView argInputView:getCmd cellIndex:m_index];
    }

}



//- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
//	UITouch *touch = [touches anyObject];
//	CGPoint oldLocation = [touch previousLocationInView:self];
//	CGPoint newLocation = [touch locationInView:self];
//	
//	[super touchesMoved:touches withEvent:event];
//	
//	NSLog(@"指の動き：%f , %f から %f, %f", oldLocation.x, oldLocation.y, newLocation.x, newLocation.y);
//}

@end
