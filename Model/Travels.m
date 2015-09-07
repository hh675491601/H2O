//
//  Travels.m
//
//  Created by hehao  on 15/9/6
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "Travels.h"


NSString *const kTravelsDTime = @"dTime";
NSString *const kTravelsMTime = @"mTime";
NSString *const kTravelsFromApp = @"fromApp";
NSString *const kTravelsStatus = @"status";
NSString *const kTravelsTitle = @"title";
NSString *const kTravelsPhotoCount = @"photoCount";
NSString *const kTravelsPlaceCount = @"placeCount";
NSString *const kTravelsRecommendCount = @"recommendCount";
NSString *const kTravelsBlogId = @"blogId";
NSString *const kTravelsTextCount = @"textCount";
NSString *const kTravelsCover = @"cover";
NSString *const kTravelsOTime = @"oTime";
NSString *const kTravelsTrack = @"track";
NSString *const kTravelsVoiceCount = @"voiceCount";
NSString *const kTravelsType = @"type";
NSString *const kTravelsInfo = @"info";
NSString *const kTravelsId = @"id";
NSString *const kTravelsReadCount = @"readCount";
NSString *const kTravelsPhototextCount = @"phototextCount";
NSString *const kTravelsPlaceId = @"placeId";
NSString *const kTravelsDayCount = @"dayCount";
NSString *const kTravelsLevel = @"level";
NSString *const kTravelsUserFace = @"userFace";
NSString *const kTravelsVideoCount = @"videoCount";
NSString *const kTravelsCommentCount = @"commentCount";
NSString *const kTravelsCTime = @"cTime";
NSString *const kTravelsUserName = @"userName";
NSString *const kTravelsSound = @"sound";
NSString *const kTravelsDevice = @"device";
NSString *const kTravelsUserId = @"userId";


@interface Travels ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Travels

@synthesize dTime = _dTime;
@synthesize mTime = _mTime;
@synthesize fromApp = _fromApp;
@synthesize status = _status;
@synthesize title = _title;
@synthesize photoCount = _photoCount;
@synthesize placeCount = _placeCount;
@synthesize recommendCount = _recommendCount;
@synthesize blogId = _blogId;
@synthesize textCount = _textCount;
@synthesize cover = _cover;
@synthesize oTime = _oTime;
@synthesize track = _track;
@synthesize voiceCount = _voiceCount;
@synthesize type = _type;
@synthesize info = _info;
@synthesize travelsIdentifier = _travelsIdentifier;
@synthesize readCount = _readCount;
@synthesize phototextCount = _phototextCount;
@synthesize placeId = _placeId;
@synthesize dayCount = _dayCount;
@synthesize level = _level;
@synthesize userFace = _userFace;
@synthesize videoCount = _videoCount;
@synthesize commentCount = _commentCount;
@synthesize cTime = _cTime;
@synthesize userName = _userName;
@synthesize sound = _sound;
@synthesize device = _device;
@synthesize userId = _userId;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.dTime = [self objectOrNilForKey:kTravelsDTime fromDictionary:dict];
            self.mTime = [self objectOrNilForKey:kTravelsMTime fromDictionary:dict];
            self.fromApp = [self objectOrNilForKey:kTravelsFromApp fromDictionary:dict];
            self.status = [self objectOrNilForKey:kTravelsStatus fromDictionary:dict];
            self.title = [self objectOrNilForKey:kTravelsTitle fromDictionary:dict];
            self.photoCount = [self objectOrNilForKey:kTravelsPhotoCount fromDictionary:dict];
            self.placeCount = [self objectOrNilForKey:kTravelsPlaceCount fromDictionary:dict];
            self.recommendCount = [self objectOrNilForKey:kTravelsRecommendCount fromDictionary:dict];
            self.blogId = [self objectOrNilForKey:kTravelsBlogId fromDictionary:dict];
            self.textCount = [self objectOrNilForKey:kTravelsTextCount fromDictionary:dict];
            self.cover = [self objectOrNilForKey:kTravelsCover fromDictionary:dict];
            self.oTime = [self objectOrNilForKey:kTravelsOTime fromDictionary:dict];
            self.track = [self objectOrNilForKey:kTravelsTrack fromDictionary:dict];
            self.voiceCount = [self objectOrNilForKey:kTravelsVoiceCount fromDictionary:dict];
            self.type = [self objectOrNilForKey:kTravelsType fromDictionary:dict];
            self.info = [self objectOrNilForKey:kTravelsInfo fromDictionary:dict];
            self.travelsIdentifier = [self objectOrNilForKey:kTravelsId fromDictionary:dict];
            self.readCount = [self objectOrNilForKey:kTravelsReadCount fromDictionary:dict];
            self.phototextCount = [self objectOrNilForKey:kTravelsPhototextCount fromDictionary:dict];
            self.placeId = [self objectOrNilForKey:kTravelsPlaceId fromDictionary:dict];
            self.dayCount = [self objectOrNilForKey:kTravelsDayCount fromDictionary:dict];
            self.level = [self objectOrNilForKey:kTravelsLevel fromDictionary:dict];
            self.userFace = [self objectOrNilForKey:kTravelsUserFace fromDictionary:dict];
            self.videoCount = [self objectOrNilForKey:kTravelsVideoCount fromDictionary:dict];
            self.commentCount = [self objectOrNilForKey:kTravelsCommentCount fromDictionary:dict];
            self.cTime = [self objectOrNilForKey:kTravelsCTime fromDictionary:dict];
            self.userName = [self objectOrNilForKey:kTravelsUserName fromDictionary:dict];
            self.sound = [self objectOrNilForKey:kTravelsSound fromDictionary:dict];
            self.device = [self objectOrNilForKey:kTravelsDevice fromDictionary:dict];
            self.userId = [self objectOrNilForKey:kTravelsUserId fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.dTime forKey:kTravelsDTime];
    [mutableDict setValue:self.mTime forKey:kTravelsMTime];
    [mutableDict setValue:self.fromApp forKey:kTravelsFromApp];
    [mutableDict setValue:self.status forKey:kTravelsStatus];
    [mutableDict setValue:self.title forKey:kTravelsTitle];
    [mutableDict setValue:self.photoCount forKey:kTravelsPhotoCount];
    [mutableDict setValue:self.placeCount forKey:kTravelsPlaceCount];
    [mutableDict setValue:self.recommendCount forKey:kTravelsRecommendCount];
    [mutableDict setValue:self.blogId forKey:kTravelsBlogId];
    [mutableDict setValue:self.textCount forKey:kTravelsTextCount];
    [mutableDict setValue:self.cover forKey:kTravelsCover];
    [mutableDict setValue:self.oTime forKey:kTravelsOTime];
    [mutableDict setValue:self.track forKey:kTravelsTrack];
    [mutableDict setValue:self.voiceCount forKey:kTravelsVoiceCount];
    [mutableDict setValue:self.type forKey:kTravelsType];
    [mutableDict setValue:self.info forKey:kTravelsInfo];
    [mutableDict setValue:self.travelsIdentifier forKey:kTravelsId];
    [mutableDict setValue:self.readCount forKey:kTravelsReadCount];
    [mutableDict setValue:self.phototextCount forKey:kTravelsPhototextCount];
    [mutableDict setValue:self.placeId forKey:kTravelsPlaceId];
    [mutableDict setValue:self.dayCount forKey:kTravelsDayCount];
    [mutableDict setValue:self.level forKey:kTravelsLevel];
    [mutableDict setValue:self.userFace forKey:kTravelsUserFace];
    [mutableDict setValue:self.videoCount forKey:kTravelsVideoCount];
    [mutableDict setValue:self.commentCount forKey:kTravelsCommentCount];
    [mutableDict setValue:self.cTime forKey:kTravelsCTime];
    [mutableDict setValue:self.userName forKey:kTravelsUserName];
    [mutableDict setValue:self.sound forKey:kTravelsSound];
    [mutableDict setValue:self.device forKey:kTravelsDevice];
    [mutableDict setValue:self.userId forKey:kTravelsUserId];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description 
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];

    self.dTime = [aDecoder decodeObjectForKey:kTravelsDTime];
    self.mTime = [aDecoder decodeObjectForKey:kTravelsMTime];
    self.fromApp = [aDecoder decodeObjectForKey:kTravelsFromApp];
    self.status = [aDecoder decodeObjectForKey:kTravelsStatus];
    self.title = [aDecoder decodeObjectForKey:kTravelsTitle];
    self.photoCount = [aDecoder decodeObjectForKey:kTravelsPhotoCount];
    self.placeCount = [aDecoder decodeObjectForKey:kTravelsPlaceCount];
    self.recommendCount = [aDecoder decodeObjectForKey:kTravelsRecommendCount];
    self.blogId = [aDecoder decodeObjectForKey:kTravelsBlogId];
    self.textCount = [aDecoder decodeObjectForKey:kTravelsTextCount];
    self.cover = [aDecoder decodeObjectForKey:kTravelsCover];
    self.oTime = [aDecoder decodeObjectForKey:kTravelsOTime];
    self.track = [aDecoder decodeObjectForKey:kTravelsTrack];
    self.voiceCount = [aDecoder decodeObjectForKey:kTravelsVoiceCount];
    self.type = [aDecoder decodeObjectForKey:kTravelsType];
    self.info = [aDecoder decodeObjectForKey:kTravelsInfo];
    self.travelsIdentifier = [aDecoder decodeObjectForKey:kTravelsId];
    self.readCount = [aDecoder decodeObjectForKey:kTravelsReadCount];
    self.phototextCount = [aDecoder decodeObjectForKey:kTravelsPhototextCount];
    self.placeId = [aDecoder decodeObjectForKey:kTravelsPlaceId];
    self.dayCount = [aDecoder decodeObjectForKey:kTravelsDayCount];
    self.level = [aDecoder decodeObjectForKey:kTravelsLevel];
    self.userFace = [aDecoder decodeObjectForKey:kTravelsUserFace];
    self.videoCount = [aDecoder decodeObjectForKey:kTravelsVideoCount];
    self.commentCount = [aDecoder decodeObjectForKey:kTravelsCommentCount];
    self.cTime = [aDecoder decodeObjectForKey:kTravelsCTime];
    self.userName = [aDecoder decodeObjectForKey:kTravelsUserName];
    self.sound = [aDecoder decodeObjectForKey:kTravelsSound];
    self.device = [aDecoder decodeObjectForKey:kTravelsDevice];
    self.userId = [aDecoder decodeObjectForKey:kTravelsUserId];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_dTime forKey:kTravelsDTime];
    [aCoder encodeObject:_mTime forKey:kTravelsMTime];
    [aCoder encodeObject:_fromApp forKey:kTravelsFromApp];
    [aCoder encodeObject:_status forKey:kTravelsStatus];
    [aCoder encodeObject:_title forKey:kTravelsTitle];
    [aCoder encodeObject:_photoCount forKey:kTravelsPhotoCount];
    [aCoder encodeObject:_placeCount forKey:kTravelsPlaceCount];
    [aCoder encodeObject:_recommendCount forKey:kTravelsRecommendCount];
    [aCoder encodeObject:_blogId forKey:kTravelsBlogId];
    [aCoder encodeObject:_textCount forKey:kTravelsTextCount];
    [aCoder encodeObject:_cover forKey:kTravelsCover];
    [aCoder encodeObject:_oTime forKey:kTravelsOTime];
    [aCoder encodeObject:_track forKey:kTravelsTrack];
    [aCoder encodeObject:_voiceCount forKey:kTravelsVoiceCount];
    [aCoder encodeObject:_type forKey:kTravelsType];
    [aCoder encodeObject:_info forKey:kTravelsInfo];
    [aCoder encodeObject:_travelsIdentifier forKey:kTravelsId];
    [aCoder encodeObject:_readCount forKey:kTravelsReadCount];
    [aCoder encodeObject:_phototextCount forKey:kTravelsPhototextCount];
    [aCoder encodeObject:_placeId forKey:kTravelsPlaceId];
    [aCoder encodeObject:_dayCount forKey:kTravelsDayCount];
    [aCoder encodeObject:_level forKey:kTravelsLevel];
    [aCoder encodeObject:_userFace forKey:kTravelsUserFace];
    [aCoder encodeObject:_videoCount forKey:kTravelsVideoCount];
    [aCoder encodeObject:_commentCount forKey:kTravelsCommentCount];
    [aCoder encodeObject:_cTime forKey:kTravelsCTime];
    [aCoder encodeObject:_userName forKey:kTravelsUserName];
    [aCoder encodeObject:_sound forKey:kTravelsSound];
    [aCoder encodeObject:_device forKey:kTravelsDevice];
    [aCoder encodeObject:_userId forKey:kTravelsUserId];
}

- (id)copyWithZone:(NSZone *)zone
{
    Travels *copy = [[Travels alloc] init];
    
    if (copy) {

        copy.dTime = [self.dTime copyWithZone:zone];
        copy.mTime = [self.mTime copyWithZone:zone];
        copy.fromApp = [self.fromApp copyWithZone:zone];
        copy.status = [self.status copyWithZone:zone];
        copy.title = [self.title copyWithZone:zone];
        copy.photoCount = [self.photoCount copyWithZone:zone];
        copy.placeCount = [self.placeCount copyWithZone:zone];
        copy.recommendCount = [self.recommendCount copyWithZone:zone];
        copy.blogId = [self.blogId copyWithZone:zone];
        copy.textCount = [self.textCount copyWithZone:zone];
        copy.cover = [self.cover copyWithZone:zone];
        copy.oTime = [self.oTime copyWithZone:zone];
        copy.track = [self.track copyWithZone:zone];
        copy.voiceCount = [self.voiceCount copyWithZone:zone];
        copy.type = [self.type copyWithZone:zone];
        copy.info = [self.info copyWithZone:zone];
        copy.travelsIdentifier = [self.travelsIdentifier copyWithZone:zone];
        copy.readCount = [self.readCount copyWithZone:zone];
        copy.phototextCount = [self.phototextCount copyWithZone:zone];
        copy.placeId = [self.placeId copyWithZone:zone];
        copy.dayCount = [self.dayCount copyWithZone:zone];
        copy.level = [self.level copyWithZone:zone];
        copy.userFace = [self.userFace copyWithZone:zone];
        copy.videoCount = [self.videoCount copyWithZone:zone];
        copy.commentCount = [self.commentCount copyWithZone:zone];
        copy.cTime = [self.cTime copyWithZone:zone];
        copy.userName = [self.userName copyWithZone:zone];
        copy.sound = [self.sound copyWithZone:zone];
        copy.device = [self.device copyWithZone:zone];
        copy.userId = [self.userId copyWithZone:zone];
    }
    
    return copy;
}


@end
