//
//  DDEditor.m
//  DragEditor
//
//  Created by kayama on 2014/11/01.
//  Copyright (c) 2014年 kayama. All rights reserved.
//

#import "DDEditor.h"
#import "MyButton.h"
#import "MyArgInputView.h"

#import "SpriteKitAnime-Swift.h"


@interface DDEditor ()

@end

@implementation DDEditor

@synthesize delegate;
@synthesize tblView;

-(id)initWithFrame:(CGRect)frame
{
    self = [super init];
    
    ad = [[UIApplication sharedApplication]delegate];
    
    if (self)
    {
        self.width = frame.size.width;
        self.height = frame.size.height;

        self.view.backgroundColor = [UIColor whiteColor];
    }
    
    return self;
}

//DDEditorのUIViewContorllerを取得する
+(DDEditor*)getViewController:(UIView*)self_in
{
    UIResponder *responder = self_in;
    while ((responder = responder.nextResponder) != nil) {
        if([responder isKindOfClass:[DDEditor class]]){
            return (DDEditor*)responder;
        }
    }
    return nil;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    tblView = [[MyTableViewController alloc]initWithStyle:UITableViewStylePlain];
    tblView.tableView.frame = CGRectMake(0, 0, self.width, self.height/1.3);
    
    [self.view addSubview:tblView.tableView];
    
    
    // Exec btn
    UIButton* execBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.width*0.1, self.height -30, self.width* 0.8, 30)];
    execBtn.layer.borderColor = [UIColor brownColor].CGColor;
    execBtn.layer.borderWidth = 4;
    execBtn.layer.cornerRadius = 5.5f;
    [execBtn setTitle:@"Execute" forState:UIControlStateNormal];
    [execBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [execBtn addTarget:self action:@selector(pushExec:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:execBtn];
    
    
    //後でGeneratorクラス作る
    [self.view addSubview:[[MyButton alloc]init:CGPointMake(self.width*0.25, self.height - 100 ) title:@"walk"]];
    [self.view addSubview:[[MyButton alloc]init:CGPointMake(self.width*0.75, self.height - 100 ) title:@"turn"]];
    [self.view addSubview:[[MyButton alloc]init:CGPointMake(self.width*0.25, self.height - 50 ) title:@"if"]];
    [self.view addSubview:[[MyButton alloc]init:CGPointMake(self.width*0.75, self.height - 50 ) title:@"while"]];
}


-(MyTableViewController*)getTable
{
    return tblView;
}


-(void)argInputView:(NSString*)cmdType cellIndex:(int)cellIndex_in
{
    MyArgInputView *argView = [[MyArgInputView alloc]initWithType:cmdType index:cellIndex_in size:self.view.frame.size];
    [self.view addSubview:argView];
}


-(void)setTableViewMode:(NSString*)viewMode setView:(UIView*)setView_in
{
    if ([viewMode isEqualToString:@"inputView"])
    {
        tblView.tableView.frame = CGRectMake(0, 0, self.width, self.height/1.3);
        
        [setView_in addSubview:tblView.tableView];
        [setView_in sendSubviewToBack:tblView.tableView];
    }
    else if ([viewMode isEqualToString:@"debugView"])
    {
        tblView.tableView.frame = CGRectMake(0, ad.getSHeight, ad.getWWidth / 2.0, ad.getWHeight - ad.getSHeight);

        [setView_in addSubview:tblView.tableView];
        [setView_in sendSubviewToBack:tblView.tableView];
    }
}

- (void) pushExec:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(editFinish)]) {
        [self.delegate editFinish];
    }
    
    [self dismissViewControllerAnimated:true completion:nil];
   
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
  
    //[ad.ddEditor.tblView setHighLighted:5 color:[UIColor redColor] isScroll:true];
    //tblView.tableView.transform = CGAffineTransformMakeScale(0.5, 0.5);
    
    //    NSMutableArray *getSource = [tblView getSourceData];
    //
    //    for(int i= 0; i<[getSource count];i++)
    //    {
    //        NSString *get = [getSource objectAtIndex:i];
    //        NSLog((NSString*)([getSource objectAtIndex:i]));
    //    }
}

-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
