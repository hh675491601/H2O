//
//  BaseClass.m
//
//  Created by hehao  on 15/9/6
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "BaseClass.h"
#import "Travels.h"


NSString *const kBaseClassRet = @"ret";
NSString *const kBaseClassTotal = @"total";
NSString *const kBaseClassTravels = @"travels";


@interface BaseClass ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation BaseClass

@synthesize ret = _ret;
@synthesize total = _total;
@synthesize travels = _travels;


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
            self.ret = [[self objectOrNilForKey:kBaseClassRet fromDictionary:dict] doubleValue];
            self.total = [[self objectOrNilForKey:kBaseClassTotal fromDictionary:dict] doubleValue];
    NSObject *receivedTravels = [dict objectForKey:kBaseClassTravels];
    NSMutableArray *parsedTravels = [NSMutableArray array];
    if ([receivedTravels isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedTravels) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedTravels addObject:[Travels modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedTravels isKindOfClass:[NSDictionary class]]) {
       [parsedTravels addObject:[Travels modelObjectWithDictionary:(NSDictionary *)receivedTravels]];
    }

    self.travels = [NSMutableArray arrayWithArray:parsedTravels];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.ret] forKey:kBaseClassRet];
    [mutableDict setValue:[NSNumber numberWithDouble:self.total] forKey:kBaseClassTotal];
    NSMutableArray *tempArrayForTravels = [NSMutableArray array];
    for (NSObject *subArrayObject in self.travels) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForTravels addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForTravels addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForTravels] forKey:kBaseClassTravels];

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

    self.ret = [aDecoder decodeDoubleForKey:kBaseClassRet];
    self.total = [aDecoder decodeDoubleForKey:kBaseClassTotal];
    self.travels = [aDecoder decodeObjectForKey:kBaseClassTravels];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_ret forKey:kBaseClassRet];
    [aCoder encodeDouble:_total forKey:kBaseClassTotal];
    [aCoder encodeObject:_travels forKey:kBaseClassTravels];
}

- (id)copyWithZone:(NSZone *)zone
{
    BaseClass *copy = [[BaseClass alloc] init];
    
    if (copy) {

        copy.ret = self.ret;
        copy.total = self.total;
        copy.travels = [self.travels copyWithZone:zone];
    }
    
    return copy;
}


@end
