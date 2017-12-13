//
//  DialogViewController.m
//  ThirdLibPackage
//
//  Created by mgfjx on 2017/11/11.
//  Copyright © 2017年 mgfjx. All rights reserved.
//

#import "DialogViewController.h"
#import "PublicDialogManager.h"

@interface DialogViewController ()

@end

@implementation DialogViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    titles = @[@"only text", @"only text offset", @"show waitting", @"hide waitting"];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    switch (indexPath.row) {
        case 0:
            [PublicDialogManager showText:@"当时是小白的我受宠若惊，好奇心作祟，我点开她的文章，作为一个“过来人”的身份，若单单是论文笔，姑娘尚幼，确有不足之处，但好在真情流露，也难怪能在简书开拓一片沃土。" inView:self.view duration:1.5];
            break;
            
        case 1:
            [PublicDialogManager showText:@"only text offset" inView:self.view duration:1.5 offset:self.view.height];
            break;
            
        case 2:
            [PublicDialogManager showWaittingInView:self.view];
            break;
            
        case 3:
            [PublicDialogManager hideWaittingInView:self.view];
            break;
            
        default:
            break;
    }
    
}

@end
