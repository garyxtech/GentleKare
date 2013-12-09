//
//  GKHisViewController.m
//  GentleKare
//
//  Created by 薛洪 on 13-12-9.
//  Copyright (c) 2013年 薛洪. All rights reserved.
//

#import "GKHisViewController.h"

@interface GKHisViewController ()

@end

@implementation GKHisViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)viewDidAppear:(BOOL)animated{
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[GKBabySitter inst] getGroupCount];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[GKBabySitter inst] getActionForGroupIdx:(int)section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"HIS_CELL";
    //static int TAG_IMAGE = 0;
    static int TAG_ACTION = 1;
    static int TAG_STARTTIME = 2;
    static int TAG_ENDTIME = 3;

    GKAction* action = [[[GKBabySitter inst] getActionForGroupIdx:indexPath.section] objectAtIndex:indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    //UIImage* vwImage = (UIImage*)[cell viewWithTag:TAG_IMAGE];
    UILabel* lblAction = (UILabel*)[cell viewWithTag:TAG_ACTION];
    UILabel* lblStartTime = (UILabel*)[cell viewWithTag:TAG_STARTTIME];
    UILabel* lblEndTime = (UILabel*)[cell viewWithTag:TAG_ENDTIME];
    
    //UIImage* image = [UIImage imageWithContentsOfFile:@"FEED"];
    [lblAction setText:[[GKBabySitter inst] getActionDescription:[action.actionType intValue]]];

    [lblStartTime setText:[GKUtil dateToStr:action.startTime]];
    NSLog(@"lbl start at %@", lblStartTime.text);
    
    [lblEndTime setText:[GKUtil dateToStr:action.endTime]];
    NSLog(@"lbl end at %@", lblEndTime.text);
    
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

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
