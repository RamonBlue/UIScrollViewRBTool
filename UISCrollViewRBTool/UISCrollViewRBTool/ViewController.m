//
//  ViewController.m
//  UISCrollViewRBTool
//
//  Created by Mac on 2020/9/19.
//

#import "ViewController.h"
#import "AddFunctionVC.h"
#import "InsertFunctionVC.h"
#import "RemoveFunctionVC.h"
#import "DemoVC.h"

@interface ViewController ()

@end

@implementation ViewController

#pragma mark - Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setup];
}

#pragma mark - Private

- (void)setup
{
    self.title = @"竖排工具";
}

#pragma mark - Network

#pragma mark - Event

- (IBAction)addBtnTapped:(id)sender
{
    [self.navigationController pushViewController:AddFunctionVC.new animated:YES];
}

- (IBAction)insertBtnTapped:(id)sender
{
    [self.navigationController pushViewController:InsertFunctionVC.new animated:YES];
}

- (IBAction)removeBtnTapped:(id)sender
{
    [self.navigationController pushViewController:RemoveFunctionVC.new animated:YES];
}

- (IBAction)demoBtnTapped:(id)sender
{
    [self.navigationController pushViewController:DemoVC.new animated:YES];
}

#pragma mark - Setter

#pragma mark - Getter

@end
