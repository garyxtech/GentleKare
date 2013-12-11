//
//  GKBabyDetailViewController.m
//  GentleKare
//
//  Created by 薛洪 on 13-12-9.
//  Copyright (c) 2013年 薛洪. All rights reserved.
//

#import "GKBabyDetailViewController.h"

@interface GKBabyDetailViewController ()

@end

@implementation GKBabyDetailViewController{
    NSDate* _pickedDate;
    UIImagePickerController* _pkrImage;
    GKBaby* _babyOnHold;
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.lblBirthday setInputView:self.pkrDate];
    _pkrImage = [[UIImagePickerController alloc] init];
    [_pkrImage setAllowsEditing:true];
}

-(void)loadBabyDetail:(GKBaby*) baby{
    _babyOnHold = baby;
}

-(void)viewDidAppear:(BOOL)animated{
    
    if(_babyOnHold != nil){
        [self.lblName setText:_babyOnHold.name];
        if(_babyOnHold.birthday!=nil){
            [self.lblBirthday setText:[GKUtil dateToStrAsDayOnly:_babyOnHold.birthday]];
            _pickedDate = _babyOnHold.birthday;
        }else{
            [self.lblBirthday setText:@"未设定"];
            _pickedDate = nil;
        }
        UIImage* img = [UIImage imageWithData:_babyOnHold.image];
        self.imgBaby.image = img;
        _babyOnHold = nil;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)confirmDetail:(id)sender {
    GKBaby* baby = [[GKBabySitter inst] baby];
    baby.name = self.lblName.text;
    baby.birthday = _pickedDate;
    baby.image = UIImagePNGRepresentation(self.imgBaby.image);
    [[GKBabySitter inst] save];
    [self.navigationController popViewControllerAnimated:true];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return true;
}

- (IBAction)confirmBirthdayPick:(id)sender {
    
    _pickedDate = [self.pkrDate date];
    [self.lblBirthday setText:[GKUtil dateToStrAsDayOnly:_pickedDate]];
    
    [self.lblBirthday resignFirstResponder];
    self.btnPickDateOK.hidden = true;
    self.btnPickDateOK.hidden = true;
}

- (IBAction)startPickBirthday:(id)sender {
    if(_pickedDate!=nil){
        [self.pkrDate setDate:_pickedDate];
    }
    self.btnPickDateOK.hidden = false;
    self.pkrDate.hidden = false;
}

- (IBAction)pickImage:(id)sender{
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"给宝宝选照片" message:@"请选择照片来源" delegate:self cancelButtonTitle:@"不拍了" otherButtonTitles:@"拍一个", @"从图片库选", nil];
    alert.delegate = self;
    alert.tag = 1;
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(alertView.tag == 1){
        if(buttonIndex == 0){
            return;
        }
        
        UIImagePickerControllerSourceType srcType = UIImagePickerControllerSourceTypeCamera;
        if(buttonIndex == 2){
            srcType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        }
        [_pkrImage setSourceType:srcType];
        _pkrImage.delegate = self;
        [self presentViewController:_pkrImage animated:true completion:nil];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    UIImage* newImage = [info objectForKey:UIImagePickerControllerEditedImage];
    newImage = [GKUtil imageWithImage:newImage scaledToSize:CGSizeMake(100, 100)];
    self.imgBaby.image = newImage;
    
    [_pkrImage dismissViewControllerAnimated:true completion:nil];
}

@end
