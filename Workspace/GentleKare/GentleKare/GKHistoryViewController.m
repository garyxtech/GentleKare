//
//  GKHistoryViewController.m
//  GentleKare
//
//  Created by 薛洪 on 13-12-3.
//  Copyright (c) 2013年 薛洪. All rights reserved.
//

#import "GKHistoryViewController.h"

@interface GKHistoryViewController ()

@end

@implementation GKHistoryViewController

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
}

-(void)viewDidAppear:(BOOL)animated{
    [[self tableView] reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    int numberOfSection = [GKBabySitter getGroupCount];
    return numberOfSection;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int numberOfRow = [[GKBabySitter getActionForGroupIdx:section] count];
    return numberOfRow;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CELL_ID = @"HISTORY_TABLE_CELL_ID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_ID];
    if(cell==nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELL_ID];
    }
    
    NSArray* arAction = [GKBabySitter getActionForGroupIdx:indexPath.section];
    if(arAction!=nil){
        GKAction* action = [arAction objectAtIndex:indexPath.row];
        UILabel* lbl = cell.textLabel;
        GK_E_Action actionEnum = (GK_E_Action) [action.actionType intValue];
        NSString* desc = [@"    " stringByAppendingString:[GKBabySitter getActionDescription:actionEnum]];
        NSString* startTime = [GKUtil dateToStrAsMonthDayTimeOnly:action.startTime];
        NSString* endTime = [GKUtil dateToStrAsTimeOnly:action.endTime];
        desc = [desc stringByAppendingString:[NSString stringWithFormat:@"    从 %@ 到 %@", startTime, endTime]];
        [lbl setText:desc];
    }
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSDate* day = (NSDate*)[GKBabySitter getGroupCompareKeyForIdx: section];
    return [GKUtil dateToStrAsDayOnly:day];
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

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
}
@end
