//
//  MyTableViewController.m
//  DragEditor
//
//  Created by kayama on 14/10/24.
//  Copyright (c) 2014年 kayama. All rights reserved.
//

#import "MyTableViewController.h"
#import "MyCell.h"
#import <QuartzCore/QuartzCore.h>

@interface MyTableViewController ()

@end

@implementation MyTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        sourceData = [[MySourceData alloc]init];
        
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[self.tableView layer]setBorderColor:[[UIColor blueColor]CGColor]];
    [[self.tableView layer]setBorderWidth:2.0];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [self.tableView setEditing:YES animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return sourceData.count;
}

- (MyCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    MyCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // セルが作成されていないか?
    if (!cell) { // yes
        // セルを作成
        
        cell = [[MyCell alloc]init:(int)indexPath.row indentLevel:[sourceData getScopeLevelByIndex:(int)indexPath.row]];
    }
    
    // Configure the cell...
    [cell setData:[sourceData getCmdByIndex:(int)indexPath.row] arg:[sourceData getArgByIndex:(int)indexPath.row]];
    

    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/


// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    if(fromIndexPath.section == toIndexPath.section) { // 移動元と移動先は同じセクションです。
        if(sourceData && toIndexPath.row < sourceData.count) {
            [sourceData exchangeData:(int)fromIndexPath.row toIndex:(int)toIndexPath.row];
            
            //更新
            [self resetDataAndView];
        }
    }
}

- (UITableViewCellEditingStyle) tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // セルが編集可能だと左側に削除アイコンが出るけど、それを表示させない
    return UITableViewCellEditingStyleNone;
}

-(BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    // editingStyleForRowAtIndexPath()でアイコン表示を無くしたけど、アイコン分の空白が残っているので左寄せする
    return NO;
}

// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}



#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

-(int)getCellIndexByPos:(CGPoint)pos;
{
    NSArray *cells = [self.tableView visibleCells];
    
   int ret = -1;

    for (int i=0;i<[cells count];i++)
    {
        MyCell *temp = [cells objectAtIndex:i];
        if (CGRectContainsPoint(temp.realFrame, pos))
        {
            ret = [temp getIndex];
            break;
        }
    }
        
    return ret;
}

-(void)setDataByIndex:(int)index cmd:(NSString*)cmd_in arg:(NSString*)arg_in
{

    // sourceDataに値登録
    [sourceData setData:index cmd:cmd_in arg:arg_in];
    
    
    if(index > (sourceData.count -2))
    {
        [sourceData addBlankLine:3];
    }
    
    //更新
    [self resetDataAndView];
}

-(void)setDataByIndexWithEndBlock:(int)index cmd:(NSString*)cmd_in arg:(NSString*)arg_in
{
    // sourceDataに値登録
    [sourceData setData:index cmd:cmd_in arg:arg_in];
    [sourceData inserEndBlock:index cmd:cmd_in];
    
    if(index > (sourceData.count -5))
    {
        [sourceData addBlankLine:3];
    }

    //更新
    [self resetDataAndView];
}

-(void)setHighLighted:(int)index color:(UIColor*)color_in isScroll:(bool)isScroll_in
{
    //エラーチェック
    if (index > [sourceData count] -1 )
    {
        // 前にHighLightを消すだけなので、表示の更新だけでよい
        [self.tableView reloadData];
        return;
    }
    
    // 前にHighLightを消すだけなので、表示の更新だけでよい
    [self.tableView reloadData];
    
    // cellの表示変更
    MyCell *temp = (MyCell*)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];

    temp.backgroundColor = color_in;
 
    // Scrollする
    if (isScroll_in)
    {
        NSIndexPath* indexPath = [NSIndexPath indexPathForRow:index inSection:0];
        [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    }
}

-(NSString*)getCmdByIndex:(int)index
{
    return [sourceData getCmdByIndex:index];
}

-(NSMutableArray*)getSourceData
{
    return [sourceData getSourceData];
}

-(void)resetDataAndView
{
    // scopeLevelの更新
    [sourceData resetScopeLevel];
    
    // 表示の更新
    [self.tableView reloadData];
}
@end
