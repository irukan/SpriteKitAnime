//
//  MyButton.m
//  DragEditor
//
//  Created by kayama on 14/10/24.
//  Copyright (c) 2014年 kayama. All rights reserved.
//

#import "MyButton.h"
#import <QuartzCore/QuartzCore.h>
@implementation MyButton


-(id)init:(CGPoint)center_in title:(NSString*)title_in
{
    self = [super initWithFrame:CGRectMake(center_in.x, center_in.y, 100, 30)];
    if(self) {
        
        //position
        self.center = center_in;
        m_setPos = center_in;
        
        //title
        [self setTitle:title_in forState:UIControlStateNormal];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        m_title = title_in;
        
        //枠
        self.layer.borderColor = [UIColor redColor].CGColor;
        self.layer.borderWidth = 3;
        self.layer.cornerRadius = 7.5f;
        
        // Initialization code
        //self.backgroundColor = [UIColor greenColor];
        
        [self addTarget:self action:@selector(btn_TouchDragInside:forEvent:) forControlEvents:UIControlEventTouchDragInside];
        [self addTarget:self action:@selector(btn_TouchUpInside:forEvent:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    return self;
}

-(void)didMoveToSuperview
{
    rootView = [DDEditor getViewController:self];
    tblView = [rootView getTable];
}

- (void) btn_TouchDragInside:(id)sender forEvent:(UIEvent *)event
{
    NSSet *touches = [event touchesForView:sender];
    UITouch *touch = [touches anyObject];
    
    CGPoint preLoc = [touch previousLocationInView:sender];
    CGPoint nowLoc = [touch locationInView:sender];
    
    CGFloat deltaX = nowLoc.x - preLoc.x;
    CGFloat deltaY = nowLoc.y - preLoc.y;
    
    CGPoint newPos = CGPointMake(self.center.x + deltaX, self.center.y + deltaY);
    self.center = newPos;
    
    if (CGRectContainsPoint(tblView.tableView.frame, newPos))
    {
        int cellIndex = [tblView getCellIndexByPos:newPos];
        
        if(cellIndex != -1)
        {
            [tblView setHighLighted:cellIndex color:[UIColor cyanColor] isScroll:false];

        }
    }
}

- (void) btn_TouchUpInside:(id)sender forEvent:(UIEvent *)event
{
    int cellIndex = [tblView getCellIndexByPos:self.center];
    
    if(cellIndex != -1)
    {
                
        if ( ([m_title isEqualToString:@"while"]) || ([m_title isEqualToString:@"if"]) )
        {
            [tblView setDataByIndexWithEndBlock:cellIndex cmd:m_title arg:@""];
        }
        else
        {
            [tblView setDataByIndex:cellIndex cmd:m_title arg:@""];
        }
        
        // ArgInputWindow
        [rootView argInputView:m_title cellIndex:cellIndex];

    }
    
    //初期位置に戻す
    [UIView animateWithDuration:0.2f
                     animations:^{
                         self.center = m_setPos;
                     }];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
