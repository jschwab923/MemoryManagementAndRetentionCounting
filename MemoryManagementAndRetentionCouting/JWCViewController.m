//
//  JWCViewController.m
//  MemoryManagementAndRetentionCouting
//
//  Created by Jeff Schwab on 2/13/14.
//  Copyright (c) 2014 Jeff Schwab. All rights reserved.
//

#import "JWCViewController.h"

@interface JWCViewController ()

{
    char *ptr;
}

@property (nonatomic, copy) void (^retainBlock)(BOOL retained);


@end

@implementation JWCViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    ptr = malloc(sizeof(char)*8);
    
    ptr[0] = 'a';
    ptr[1] = 'b';
    ptr[2] = 'c';
    ptr[3] = 'd';
    ptr[4] = 'e';
    ptr[5] = 'f';
    ptr[6] = 'g';
    ptr[7] = 'h';
    
    for (int i = 0; i < 8; i++) {
        if (i > 4) {
            ptr[i] = 55 + i;
        }
        NSLog(@"%c", ptr[i]);
    }
    
    free(ptr);
    
    ptr = NULL;
    
    __block int count = 5;
    
    __weak JWCViewController *weakSelf = self;
    self.retainBlock = ^void(BOOL retained) {
        if (retained) {
            count = [weakSelf squareSomeCrap:count];
        } else {
            count += count;
        }
    };
    
    self.retainBlock(NO);
    NSLog(@"%i", count);
    
    self.retainBlock(YES);
    NSLog(@"%i", count);
}

- (int)squareSomeCrap:(int)crap
{
    return crap*crap;
}

- (void)viewDidAppear:(BOOL)animated
{

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
