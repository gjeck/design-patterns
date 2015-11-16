//
//  TodoListCreateViewController.m
//  todo
//
//  Created by Greg on 11/15/15.
//  Copyright © 2015 Hyde. All rights reserved.
//

#import "TodoListCreateViewController.h"
#import "GJCoreData.h"

@interface TodoListCreateViewController () <UITextFieldDelegate>
@property (nonatomic, weak) IBOutlet UITextField* titleField;
@end

@implementation TodoListCreateViewController

#pragma mark - UIViewController Life

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - IBActions

- (IBAction)cancelButtonPressed:(UIButton *)sender {
  [_context rollback];
  [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)titleTextChanged:(UITextField *)sender {}

- (IBAction)saveButtonPressed:(UIButton *)sender {
  self.potentialTodoList.title = self.titleField.text;
  [self.potentialTodoList saveInContext:_context withErrorBlock:nil];
  [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {}

@end
