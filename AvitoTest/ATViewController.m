//
//  ATViewController.m
//  AvitoTest
//
//  Created by Iovanna Popova on 04.08.15.
//  Copyright (c) 2015 Iovanna Popova. All rights reserved.
//

#import "ATViewController.h"
#import "ATSearchEngine.h"
#import "ATAlternatingSearchEngine.h"
#import "ATRemoteSearchEngine.h"
#import "ATSearchResult.h"
#import "NSArray+ATAdditions.h"
#import "ATTableViewDataSource.h"
#import "ATSearchResultViewModel.h"
#import "ATImageViewController.h"
#import "ATTransitioningDelegateObject.h"

@interface ATViewController ()<UISearchBarDelegate,UISearchBarDelegate,ATTableViewDelegate>

@property (nonatomic, strong) UINavigationBar* navigationBar;
@property (nonatomic, strong) UISegmentedControl* segmentedControl;
@property (nonatomic, strong) UISearchBar* searchBar;
@property (nonatomic, strong) UITableView* tableView;

@property (nonatomic,strong) id<ATSearchEngine> itunesSearchEngine;
@property (nonatomic,strong) id<ATSearchEngine> githubSearchEngine;
@property (nonatomic,strong) ATAlternatingSearchEngine* searchEngine;
@property (nonatomic,strong) ATTableViewDataSource* resultsTableViewDataSource;

@property (nonatomic, strong) NSArray* itunesResultsArray;
@property (nonatomic, strong) NSArray* githubResultsArray;


@property (nonatomic, strong) ATTransitioningDelegateObject* transitoningDelegate;

@end

@implementation ATViewController

#pragma mark - Lazy loading

-(UINavigationBar*)navigationBar{
    if (_navigationBar == nil) {
        _navigationBar = [[UINavigationBar alloc] init];
        _navigationBar.tintColor = [UIColor whiteColor];
    }
    return _navigationBar;
}

- (UISegmentedControl*)segmentedControl{
    if (_segmentedControl == nil) {
        _segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"Itunes",@"GitHub"]];
        _segmentedControl.apportionsSegmentWidthsByContent = YES;
        _segmentedControl.tintColor = [UIColor blueColor];
        [_segmentedControl addTarget:self action:@selector(segmentedControlAction:) forControlEvents:UIControlEventValueChanged];
    }
    return _segmentedControl;
}

-(UISearchBar*)searchBar{
    if (_searchBar == nil) {
        _searchBar = [[UISearchBar alloc] init];
        _searchBar.delegate = self;
    }
    return _searchBar;
}

-(UITableView*)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] init];
        _tableView.dataSource = self.resultsTableViewDataSource;
    }
    return _tableView;
}

-(ATTableViewDataSource*)resultsTableViewDataSource{
    if (_resultsTableViewDataSource == nil) {
        _resultsTableViewDataSource = [[ATTableViewDataSource alloc] init];
        _resultsTableViewDataSource.uiDelegate = self;
    }
    return _resultsTableViewDataSource;
}

-(id<ATSearchEngine>)itunesSearchEngine{
    if (_itunesSearchEngine == nil) {
        NSURL* templateURL = [NSURL URLWithString:@"https://itunes.apple.com/search"];
        NSString* searchTermParameterName = @"term";
        ATRemoteSearchEngineResultParser parser = ^(NSDictionary* resultDictionary){
            NSArray* resultsDict = [resultDictionary objectForKey:@"results"];
            return [resultsDict at_map:^ATSearchResultViewModel*(NSDictionary* dict, NSUInteger idx) {
                return [[ATSearchResultViewModel alloc] initWithSearchResult:[[ATSearchResult alloc] initWithName:[dict objectForKey:@"artistName"]
                                                                                                           author:[dict objectForKey:@"collectionName"]
                                                                                                  previewImageUrl:[dict objectForKey:@"artworkUrl60"]
                                                                                                         imageUrl:[dict objectForKey:@"artworkUrl100"]
                                                                                                   searchEngineID:ATSearchEngineIDiTunes]
                                                                       index:idx];
            }];
        };
        _itunesSearchEngine = [[ATRemoteSearchEngine alloc] initWithTemplateURL:templateURL
                                                        searchTermParameterName:searchTermParameterName
                                                                   resultParser:parser];
    }
    return _itunesSearchEngine;
}

- (id<ATSearchEngine>)githubSearchEngine{
    if (_githubSearchEngine == nil) {
        NSURL* templateURL = [NSURL URLWithString:@"https://api.github.com/search/users"];
        NSString* searchTermParameterName = @"q";
        ATRemoteSearchEngineResultParser parser = ^(NSDictionary* resultDictionary){
            NSArray* resultsDict = [resultDictionary objectForKey:@"items"];
                return [resultsDict at_map:^ATSearchResultViewModel*(NSDictionary* dict, NSUInteger idx) {
                    return [[ATSearchResultViewModel alloc] initWithSearchResult:[[ATSearchResult alloc] initWithName:[dict objectForKey:@"login"]
                                                                                                               author:[dict objectForKey:@"url"]
                                                                                                      previewImageUrl:[dict objectForKey:@"avatar_url"]
                                                                                                             imageUrl:[dict objectForKey:@"avatar_url"]
                                                                                                       searchEngineID:ATSearchEngineIDGitHub]
                                                                           index:idx];

            }];
        };
        _githubSearchEngine = [[ATRemoteSearchEngine alloc] initWithTemplateURL:templateURL
                                                        searchTermParameterName:searchTermParameterName
                                                                   resultParser:parser];

    }
    return _githubSearchEngine;
}

- (ATAlternatingSearchEngine*)searchEngine {
    if (_searchEngine == nil) {
        _searchEngine = [[ATAlternatingSearchEngine alloc] initWithSearchEngines:@[self.itunesSearchEngine,self.githubSearchEngine]];
    }
    return _searchEngine;
}

#pragma mark - Life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.navigationBar];
    [self.navigationBar addSubview:self.segmentedControl];
    [self.view addSubview:self.searchBar];
    [self.view addSubview:self.tableView];
    self.segmentedControl.selectedSegmentIndex = 0;
}

static CGFloat kNavigationBarHeight = 64.0;
static CGFloat kSearchBarHeight = 60.0;

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    self.navigationBar.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), kNavigationBarHeight);
    self.segmentedControl.center = CGPointMake(CGRectGetMidX(self.navigationBar.bounds), CGRectGetMidY(self.navigationBar.bounds) + 10);
    self.searchBar.frame = CGRectMake(0, CGRectGetHeight(self.navigationBar.frame), CGRectGetWidth(self.view.bounds), kSearchBarHeight);
    self.tableView.frame = CGRectMake(0, CGRectGetMaxY(self.searchBar.frame), CGRectGetWidth(self.view.bounds), CGRectGetMaxY(self.view.bounds) - CGRectGetMaxY(self.searchBar.frame));
}

#pragma mark - Search bar delegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [self dismissKeyboard];
    [self.searchEngine searchForString:self.searchBar.text completionHandler:^(NSArray *itunesResultsArray, NSArray *githubResultsArray, NSError *resultsError) {
        if (!resultsError) {
            self.itunesResultsArray = itunesResultsArray;
            self.githubResultsArray = githubResultsArray;
            [self segmentedControlAction:self.segmentedControl];
        }
        else {
            UIAlertView* errorAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:[NSString stringWithFormat:@"%@",resultsError] delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
            [errorAlertView show];
        }
    }];
}

- (void)dismissKeyboard{
    [self.searchBar resignFirstResponder];
}

#pragma mark - Cell Delegate


-(void)userDidTouch:(UITapGestureRecognizer*)recognizer image:(UIImage*)image cell:(ATTableViewCell*)cell{
    self.transitoningDelegate = [[ATTransitioningDelegateObject alloc] init];
    self.transitoningDelegate.type = ATAnimationTypePresent;
    
    ATImageViewController *imageViewController = [[ATImageViewController alloc] initWithImage:image];
    imageViewController.view.frame = [self.view convertRect:cell.objectImageView.frame fromView:cell.contentView];
    imageViewController.fromCenter = imageViewController.view.center;
    
    imageViewController.transitioningDelegate = self.transitoningDelegate;
    imageViewController.modalPresentationStyle = UIModalPresentationCustom;

    [self presentViewController:imageViewController animated:YES completion:nil];
}

#pragma mark - Delegate

-(void)setUserInteractionEnabled:(BOOL)enable{
}

#pragma mark - segmented control actions

- (void)segmentedControlAction:(UISegmentedControl *)segment{
    if (segment.selectedSegmentIndex == 0) {
        self.resultsTableViewDataSource.searchResultsArray = self.itunesResultsArray;
    } else {
        self.resultsTableViewDataSource.searchResultsArray = self.githubResultsArray;
    }
    [self.tableView reloadData];
}

@end
