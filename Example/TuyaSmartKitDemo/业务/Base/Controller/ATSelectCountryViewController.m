//
//  ATSelectCountryViewController.m
//  Airtake
//
//  Created by fisher on 14/12/11.
//  Copyright (c) 2014年 hanbolong. All rights reserved.
//

#import "ATSelectCountryViewController.h"
#import "TPCountryCodeUtils.h"

@interface ATSelectCountryViewController() <UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate,UISearchDisplayDelegate>

@property (nonatomic, strong) UISearchBar               *searchBar;
@property (nonatomic, strong) UITableView               *tableView;
@property (nonatomic, strong) NSDictionary              *dataSource;
@property (nonatomic, strong) NSArray                   *letterList;
@property (nonatomic, strong) NSMutableArray            *searchResults;
@property (nonatomic, strong) NSMutableArray            *allDataList;
@property (nonatomic, strong) UISearchDisplayController *searchDisplayController;


@end

@implementation ATSelectCountryViewController

- (void)viewDidLoad {
    
    [self initView];
    [self loadData];
    [super viewDidLoad];

}

- (void)loadData {
    _searchResults  = [NSMutableArray new];
    _letterList     = [NSArray new];
    _allDataList    = [NSMutableArray new];
    
    NSArray *countryList = [TPCountryCodeUtils getDefaultPhoneCodeJson];
 
    NSMutableDictionary *countryCodeDict = [[NSMutableDictionary alloc] init];
    for (NSDictionary *dict in countryList) {
        ATCountryCodeModel *model = [ATCountryCodeModel modelWithJSON:dict];
        NSString *letter = model.firstLetter;
        
        NSMutableArray *mutableList;
        if ([countryCodeDict objectForKey:letter]) {
            mutableList = [countryCodeDict objectForKey:letter];
            [mutableList tp_safeAddObject:model];
        } else {
            mutableList = [NSMutableArray arrayWithArray:@[model]];
        }
        
        [countryCodeDict tp_safeSetObject:mutableList forKey:letter];
    }

    _dataSource = countryCodeDict;
    
    [self reloadData];
}


- (void)reloadData {
    NSArray *keys   = [_dataSource allKeys];
    NSArray *sortKeys = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2 options:NSLiteralSearch];
    }];
    
    [[_dataSource allValues] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [_allDataList addObjectsFromArray:obj];
    }];
    
    _letterList = sortKeys;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
    
}

- (void)initView {
    [self initTopBarView];
    
    _searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, APP_CONTENT_WIDTH, 40)];
    _searchBar.delegate = self;
    [_searchBar setPlaceholder:NSLocalizedString(@"search", @"")];
    
    _searchDisplayController = [[UISearchDisplayController alloc] initWithSearchBar:_searchBar contentsController:self];
    _searchDisplayController.searchResultsTableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APP_CONTENT_WIDTH, 44)];
    _searchDisplayController.active = NO;
    _searchDisplayController.searchResultsDataSource = self;
    _searchDisplayController.searchResultsDelegate = self;
    _searchDisplayController.delegate = self;
    
    
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = _searchBar;
    
    self.view.backgroundColor = MAIN_BACKGROUND_COLOR;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
}

-(void)initTopBarView {

    self.centerTitleItem.title = NSLocalizedString(@"please_choose_country_first", @"");
    self.topBarView.centerItem = self.centerTitleItem;
    
    self.topBarView.rightItem  = self.rightCancelItem;

    [self.view addSubview:self.topBarView];
}

- (UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, APP_TOP_BAR_HEIGHT, APP_SCREEN_WIDTH, APP_VISIBLE_HEIGHT) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.separatorColor = HEXCOLOR(0xdddddd);
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}

#pragma mark - TableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == _searchDisplayController.searchResultsTableView) {
        return self.searchResults.count;
    } else {
        NSArray *array = [self.dataSource objectForKey:[self.letterList objectAtIndex:section]];
        return array.count;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (tableView == _searchDisplayController.searchResultsTableView) {
        return 1;
    } else {
        return _letterList.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 45.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    if (tableView == _searchDisplayController.searchResultsTableView) {
        ATCountryCodeModel *model = _searchResults[indexPath.row];
        cell.textLabel.text = model.countryName;
    }
    else {
        ATCountryCodeModel *model = [[self.dataSource objectForKey:[self.letterList objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row];
        cell.textLabel.text = model.countryName;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ATCountryCodeModel *model;
    if (tableView == _searchDisplayController.searchResultsTableView) {
        model = _searchResults[indexPath.row];
    } else {
        model = [[self.dataSource objectForKey:[self.letterList objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row];
    }
    [self.delegate didSelectCountry:self model:model];
}


- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    if (tableView == _searchDisplayController.searchResultsTableView) {
        return nil;
    } else {
        return self.letterList.count > 1 ? self.letterList : nil;
    }
}

- (NSString *)titleForHeaderInSection:(NSInteger)section {
    return [[self.letterList objectAtIndex:section] uppercaseString];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [self titleForHeaderInSection:section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (tableView == _searchDisplayController.searchResultsTableView) {
        return 0;
    } else {
        return 25;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (tableView == _searchDisplayController.searchResultsTableView) {
        return nil;
    }
        
        
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = HEXCOLOR(0xf1f3f5);
    
    UIView *border1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, view.width, 0.5)];
    border1.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    border1.backgroundColor = HEXCOLOR(0xdddddd);
    [view addSubview:border1];
    
    
    UIView *border2 = [[UIView alloc] initWithFrame:CGRectMake(0, 25-0.5, view.width, 0.5)];
    border2.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    border2.backgroundColor = HEXCOLOR(0xdddddd);
    [view addSubview:border2];
    
    UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, view.width, view.height)];
    textLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    textLabel.backgroundColor = [UIColor clearColor];
    textLabel.font = [UIFont boldSystemFontOfSize:12];
    textLabel.textColor = RGBCOLOR(0x99, 0x99, 0x99);
    textLabel.text = [self titleForHeaderInSection:section];
    textLabel.shadowColor = RGBCOLOR(0xfa, 0xfa, 0xfa);
    textLabel.shadowOffset = CGSizeMake(0, 1);
    [view addSubview:textLabel];
    
    return view;
}

#pragma UISearchDisplayDelegate
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    _searchResults = [[NSMutableArray alloc] init];

    if (searchText.length > 0) {
        for (ATCountryCodeModel *model in _allDataList) {
            
            NSRange result1 = [model.countryCnName rangeOfString:searchBar.text options:NSCaseInsensitiveSearch];
            NSRange result2 = [model.countryEnName rangeOfString:searchBar.text options:NSCaseInsensitiveSearch];
            NSRange result3 = [model.countrySpell  rangeOfString:searchBar.text options:NSCaseInsensitiveSearch];
            
            if (result1.length > 0 || result2.length > 0 || result3.length > 0) {
                [_searchResults tp_safeAddObject:model];
            }
        }
    }
}

// called when table is shown/hidden
- (void)searchDisplayController:(UISearchDisplayController *)controller willShowSearchResultsTableView:(UITableView *)tableView {
}

- (void)searchDisplayController:(UISearchDisplayController *)controller willHideSearchResultsTableView:(UITableView *)tableView {
}

- (void)searchDisplayController:(UISearchDisplayController *)controller didHideSearchResultsTableView:(UITableView *)tableView {

}

//- (void)searchDisplayController:(UISearchDisplayController *)controller didShowSearchResultsTableView:(UITableView *)tableView {
////    tableView.frame = CGRectMake(0, APP_TOP_BAR_HEIGHT - 20, APP_CONTENT_WIDTH, APP_VISIBLE_HEIGHT);
//    [self.view bringSubviewToFront:self.topBarView];
//}
@end
