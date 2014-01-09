//
//  NXTableViewController.m
//  board-mobile
//
//  Created by KIMJOOHWEE on 2013. 12. 4..
//  Copyright (c) 2013년 KIMJOOHWEE. All rights reserved.
//

#import <MobileCoreServices/MobileCoreServices.h>
#import "NXTableViewController.h"
#import "NXDataModel.h"
#import "MyCell.h"
#import "UIImageView+WebCache.h"
#import "CLImageEditor.h"
#import "NXWriteViewController.h"
#import "DetailViewController.h"

@interface NXTableViewController ()

@end

@implementation NXTableViewController{
    NXDataModel* _dataModel;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _dataModel = [[NXDataModel alloc] init]; //3
    _dataModel.aController = self;

    // 오른쪽 상단의 카메라 아이콘 넣기
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]
        initWithBarButtonSystemItem:UIBarButtonSystemItemCamera
        target:self
        action:@selector(newImage:)];
    self.navigationItem.rightBarButtonItem = rightButton;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}



#pragma mark - DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [_dataModel ArrayLengthCount];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary* item = [_dataModel objectAtIndex:indexPath.row];
    MyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mycell"];
    NSString* id = [item objectForKey:@"id"];
    cell.num.text = [NSString stringWithFormat:@"%@",id];
    cell.title.text = [item objectForKey:@"title"];
    cell.uploaddate.text = [item objectForKey:@"contents"];
    
    NSString* string;
    if([[item objectForKey:@"filename"]  isEqualToString: @""])
    {
        string = [NSString stringWithFormat:
                  @"http://localhost:8080/images/%@",@"tmp.gif"];
    } else {
        string = [NSString stringWithFormat:
                  @"http://localhost:8080/images/%@",[item objectForKey:@"filename"]];
    }
    
    [cell.image setImageWithURL:[NSURL URLWithString:string]];
    return cell;
}



// 카메라 버튼을 눌렀을 때의 액션
- (void)newImage:(id)sender
{
    UIImagePickerController *picker
    = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    [self.navigationController
     presentViewController:picker animated:YES completion:^{}];
}


- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *mediaType = [info objectForKey: UIImagePickerControllerMediaType];
    if ([mediaType isEqualToString:(__bridge id)kUTTypeImage])
    {
        UIImage* aImage = [info objectForKey:UIImagePickerControllerOriginalImage];
        
        CLImageEditor * editor = [[CLImageEditor alloc] initWithImage:aImage];
        editor.delegate = self;
        [picker pushViewController:editor animated:YES];
    }
    
//        UIAlertView *alertView1 = [[UIAlertView alloc] initWithTitle:@"이미지" message:@"골랐어요" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
//        alertView1.alertViewStyle = UIAlertViewStyleDefault;
//        [alertView1 show];
  //  [picker dismissViewControllerAnimated:YES completion:^{}];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:^{}];
}

#pragma mark- CLImageEditor delegate

- (void)imageEditor:(CLImageEditor *)editor
didFinishEdittingWithImage:(UIImage *)image
{
    NXWriteViewController* writeVC = [self.storyboard instantiateViewControllerWithIdentifier:@"writeViewController"];
    [writeVC prepareData:image];
    [editor dismissViewControllerAnimated:NO completion:nil];
    [self.navigationController pushViewController:writeVC
                                         animated:NO];
}



// 셀 선택시 디테일 페이지로 이동하는 sugue
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"ShowDetail" sender:self];
}


//디테일 페이지로 정보 전달
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    DetailViewController* _detailView = segue.destinationViewController;
    NSIndexPath* idxPath = [self.tableView indexPathForSelectedRow];
    NSDictionary* item = [_dataModel objectAtIndex:idxPath.row];
    _detailView.titleField = [item objectForKey:@"title"];
    _detailView.contentField = [item objectForKey:@"contents"];
    
    NSString* string;
    if([[item objectForKey:@"filename"]  isEqualToString: @""])
    {
        string = [NSString stringWithFormat:
                  @"http://localhost:8080/images/%@",@"tmp.gif"];
    } else {
        string = [NSString stringWithFormat:
                  @"http://localhost:8080/images/%@",[item objectForKey:@"filename"]];
    }

    _detailView.imageField = string;
    NSArray* comments = [item objectForKey:@"comments"];
    _detailView.commentArr = comments;
}



@end
