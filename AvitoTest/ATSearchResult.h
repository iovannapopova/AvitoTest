//
//  ATSearchResult.h
//  AvitoTest
//
//  Created by Iovanna Popova on 04.08.15.
//  Copyright (c) 2015 Iovanna Popova. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, ATSearchEngineID) {
    ATSearchEngineIDiTunes,
    ATSearchEngineIDGitHub
};

@interface ATSearchResult : NSObject

@property (nonatomic,copy,readonly) NSString* name;
@property (nonatomic,copy,readonly) NSString* author;
@property (nonatomic,strong,readonly) NSURL* previewImageUrl;
@property (nonatomic,strong,readonly) NSURL* imageUrl;
@property (nonatomic,assign,readonly) ATSearchEngineID searchEngineID;

-(instancetype)initWithName:(NSString*)name author:(NSString*)author previewImageUrl:(NSString*)previewImageUrl imageUrl:(NSString*)imageUrl  searchEngineID:(ATSearchEngineID)searchEngineID  NS_DESIGNATED_INITIALIZER;

@end
