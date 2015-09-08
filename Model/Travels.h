//
//  Travels.h
//
//  Created by hehao  on 15/9/6
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface Travels : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *dTime;
@property (nonatomic, strong) NSString *mTime;
@property (nonatomic, strong) NSString *fromApp;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *photoCount;
@property (nonatomic, strong) NSString *placeCount;
@property (nonatomic, strong) NSString *recommendCount;
@property (nonatomic, strong) NSString *blogId;
@property (nonatomic, strong) NSString *textCount;
@property (nonatomic, strong) NSString *cover;
@property (nonatomic, strong) NSString *oTime;
@property (nonatomic, strong) NSString *track;
@property (nonatomic, strong) NSString *voiceCount;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *info;
@property (nonatomic, strong) NSString *travelsIdentifier;
@property (nonatomic, strong) NSString *readCount;
@property (nonatomic, strong) NSString *phototextCount;
@property (nonatomic, strong) NSString *placeId;
@property (nonatomic, strong) NSString *dayCount;
@property (nonatomic, strong) NSString *level;
@property (nonatomic, strong) NSString *userFace;
@property (nonatomic, strong) NSString *videoCount;
@property (nonatomic, strong) NSString *commentCount;
@property (nonatomic, strong) NSString *cTime;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *sound;
@property (nonatomic, strong) NSString *device;
@property (nonatomic, strong) NSString *userId;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
