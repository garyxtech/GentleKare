//
//  GKBabyDetailViewController.h
//  GentleKare
//
//  Created by 薛洪 on 13-12-9.
//  Copyright (c) 2013年 薛洪. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GKBabyDetailViewController : UIViewController<UITextFieldDelegate,UIAlertViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *lblName;
@property (weak, nonatomic) IBOutlet UITextField *lblBirthday;
@property (weak, nonatomic) IBOutlet UIImageView *imgBaby;
@property (weak, nonatomic) IBOutlet UIButton *btnPickDateOK;
@property (weak, nonatomic) IBOutlet UIDatePicker *pkrDate;
- (IBAction)confirmDetail:(id)sender;
- (IBAction)cancelDetail:(id)sender;
- (IBAction)confirmBirthdayPick:(id)sender;
- (IBAction)startPickBirthday:(id)sender;
- (IBAction)pickImage:(id)sender;
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info;

-(void)loadBabyDetail:(GKBaby*) baby;

@end
