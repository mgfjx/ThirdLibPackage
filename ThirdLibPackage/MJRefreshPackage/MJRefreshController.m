//
//  MJRefreshController.m
//  ThirdLibPackage
//
//  Created by mgfjx on 2017/11/5.
//  Copyright © 2017年 mgfjx. All rights reserved.
//

#import "MJRefreshController.h"
#import "UIScrollView+Refresh.h"

@interface MJRefreshController ()<UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UIScrollView *scrollView ;
@property (nonatomic, assign) BOOL selected ;

@end

@implementation MJRefreshController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"MJRefresh封装";
    _selected = YES;
    
//    [self initTableView];
    [self initCollectionView];
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Change" style:UIBarButtonItemStylePlain target:self action:@selector(setPropertys:)];
    
}

- (void)setPropertys:(UIButton *)sender {
    self.scrollView.canPullUp = !_selected;
    self.scrollView.canPullDown = _selected;
    _selected = !_selected;
}

- (void)setMJRefresh {
    _scrollView.canPullUp = YES;
    
    _scrollView.headerRefreshBlock = ^(UIScrollView *rfScrollView) {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [NSThread sleepForTimeInterval:2];
            dispatch_async(dispatch_get_main_queue(), ^{
                [rfScrollView stopHeaderRefreshing];
            });
        });
    };
    
    _scrollView.canPullDown = YES;
    _scrollView.footerRefreshBlock = ^(UIScrollView *rfScrollView){
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [NSThread sleepForTimeInterval:2];
            dispatch_async(dispatch_get_main_queue(), ^{
                [rfScrollView stopFooterRefreshing];
            });
        });
    };
    
    if (@available(iOS 11.0, *)) {
        _scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    _scrollView.y += kNavigationBar_Height;
    _scrollView.height -= kNavigationBar_Height;
}

- (void)initScrollView {
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.backgroundColor = [UIColor randomColor];
    _scrollView = scrollView;
    [self.view addSubview:scrollView];
    
    UIView *view = [[UIView alloc] initWithFrame:scrollView.bounds];
    view.height = view.height * 2;
    view.backgroundColor = [UIColor randomColor];
    [scrollView addSubview:view];
    
    scrollView.contentSize = CGSizeMake(scrollView.width, view.height);
    [self setMJRefresh];
}

- (void)initTableView {
    UITableView *table = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    table.delegate = self;
    table.dataSource = self;
    
    [self.view addSubview:table];
    _scrollView = table;
    [self setMJRefresh];
}

- (void)initCollectionView {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(50, 50);
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing = 10;
    
    UICollectionView *collection = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    collection.delegate = self;
    collection.dataSource = self;
    collection.backgroundColor = [UIColor whiteColor];
    [collection registerClass:UICollectionViewCell.class forCellWithReuseIdentifier:@"cell"];
    
    
    
    [self.view addSubview:collection];
    _scrollView = collection;
    [self setMJRefresh];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellReuse = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellReuse];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellReuse];
    }
    
    cell.backgroundColor = [UIColor randomColor];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - UICollectionViewDelegate, UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 200;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor randomColor];
    
    return cell;
}

@end
