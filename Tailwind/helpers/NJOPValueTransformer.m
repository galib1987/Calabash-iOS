//
//  NJOPValueTransformer.m
//  Tailwind
//
//  Created by DAVID LIN on 10/10/14.
//  Copyright (c) 2014 NetJets. All rights reserved.
//

#import "NJOPValueTransformer.h"
#import <objc/runtime.h>

@interface NSValueTransformer (private)
+(NJOPValueTransformBlock)eachWithBlock:(NJOPValueTransformBlock)block;
+(NJOPValueTransformBlock)reduceWithBlock:(NJOPValueTransformReduceBlock)block initial:(id)initial;
@end

@interface NJOPValueTransformer ()
@property (nonatomic, copy) NJOPValueTransformBlock forwardBlock;
@end

@interface AEReversibleValueTransformer : NJOPValueTransformer
@property (nonatomic, copy) NJOPValueTransformBlock reverseBlock;
@property (nonatomic, copy) NJOPValueTransformBlock forwardBlock;
@end


@implementation NJOPValueTransformer

#pragma mark Lifecycle

+ (Class)reversibleClass {
    return [AEReversibleValueTransformer class];
}

+ (instancetype)transformerWithBlock:(NJOPValueTransformBlock)transformationBlock {
    
    return [[self alloc] initWithForwardBlock:transformationBlock reverseBlock:NULL];
}

+ (instancetype)reversibleTransformerWithForwardBlock:(NJOPValueTransformBlock)forwardBlock
                                         reverseBlock:(NJOPValueTransformBlock)reverseBlock {
    return [[[self reversibleClass] alloc] initWithForwardBlock:forwardBlock
                                                   reverseBlock:reverseBlock];
}

- (id)initWithForwardBlock:(NJOPValueTransformBlock)forwardBlock
              reverseBlock:(NJOPValueTransformBlock)reverseBlock {
    
    self = [super init];
    if (self == nil) return nil;
    
    _forwardBlock = [forwardBlock copy];
    
    return self;
}

#pragma mark -

-(instancetype)transformerForEachWithBlock:(NJOPValueTransformBlock)transformationBlock {
    
    NJOPValueTransformBlock block = [self.class eachWithBlock:transformationBlock];
    return [self transformerWithBlock:^id(id value) {
        return block(value);
    }];
}

-(instancetype)transformerByReducingWithBlock:(NJOPValueTransformReduceBlock)transformationBlock {
    return [self transformerByReducingWithBlock:transformationBlock initialValue:nil];
}

- (instancetype)transformerByReducingWithBlock:(NJOPValueTransformReduceBlock)transformationBlock initialValue:(id)initial {
    NJOPValueTransformBlock block = [self.class reduceWithBlock:transformationBlock initial:initial];
    return [self transformerWithBlock:^id(id value) {
        return block(value);
    }];
}

-(instancetype)transformerByCollectingKeyValuePairs {
    return [self transformerByReducingWithBlock:^id(id sum, id obj)
            {
                
                if ([obj isKindOfClass:[NJOPKeyValuePair class]]) {
                    NJOPKeyValuePair* pair = obj;
                    [sum setObject:pair.obj forKey:pair.key];
                }
                return sum;
                
            } initialValue:[NSMutableDictionary new]];
}


-(instancetype)transformerWithBlock:(NJOPValueTransformBlock)transformationBlock {
    
    NJOPValueTransformBlock forward = [self.forwardBlock copy];
    return [self.class transformerWithBlock:^id(id value) {
        id unboxed = forward(value);
        if (unboxed) {
            return transformationBlock(unboxed);
        }
        return unboxed;
    }];
}

-(instancetype)reversibleTransformerWithBlock:(NJOPValueTransformBlock)transformationBlock reverseBlock:(NJOPValueTransformBlock)reverseBlock {
    NJOPValueTransformBlock forward = [self.forwardBlock copy];
    return [[self.class reversibleClass] reversibleTransformerWithForwardBlock:^id(id value) {
        id unboxed = forward(value);
        return transformationBlock(unboxed);
    } reverseBlock:^id(id value) {
        return reverseBlock(value);
    }];
}

#pragma mark NSValueTransformer

+ (BOOL)allowsReverseTransformation {
    return NO;
}

+ (Class)transformedValueClass {
    return [NSObject class];
}

- (id)transformedValue:(id)value {
    return self.forwardBlock(value);
}

- (id)reverseTransformedValue:(id)value {
    return value;
}

@end


@implementation AEReversibleValueTransformer

+ (BOOL)allowsReverseTransformation {
    return YES;
}

- (id)initWithForwardBlock:(NJOPValueTransformBlock)forwardBlock
              reverseBlock:(NJOPValueTransformBlock)reverseBlock {
    
    self = [super init];
    if (self == nil) return nil;
    
    self.forwardBlock = [forwardBlock copy];
    _reverseBlock = [reverseBlock copy];
    
    return self;
}

-(instancetype)reversibleTransformerWithBlock:(NJOPValueTransformBlock)transformationBlock reverseBlock:(NJOPValueTransformBlock)reverseBlock {
    NJOPValueTransformBlock forward = [self.forwardBlock copy];
    NJOPValueTransformBlock reverse = [self.forwardBlock copy];
    return [[self.class reversibleClass] reversibleTransformerWithForwardBlock:^id(id value) {
        id unboxed = forward(value);
        return transformationBlock(unboxed);
    } reverseBlock:^id(id value) {
        id unboxed = reverse(value);
        return reverseBlock(unboxed);
    }];
}

-(id)reverseTransformedValue:(id)value {
    return self.reverseBlock(value);
}

@end


@implementation NSValueTransformer (NJOPValueTransformer)

-(NJOPValueTransformer *)transformerWithBlock:(NJOPValueTransformBlock)transformationBlock {
    
    NJOPValueTransformBlock forward = ^(id value){
        return [self transformedValue:value];
    };
    return [NJOPValueTransformer transformerWithBlock:^id(id value) {
        id unboxed = forward(value);
        if (unboxed) {
            return transformationBlock(unboxed);
        }
        return unboxed;
    }];
}

-(NJOPValueTransformer *)transformerForEachWithBlock:(NJOPValueTransformBlock)transformationBlock {
    
    NJOPValueTransformBlock block = [NJOPValueTransformer eachWithBlock:transformationBlock];
    return [self transformerWithBlock:^id(id value) {
        return block(value);
    }];
}

-(NJOPValueTransformer *)transformerByReducingWithBlock:(NJOPValueTransformReduceBlock)transformationBlock {
    return [self transformerByReducingWithBlock:transformationBlock initialValue:nil];
}

- (NJOPValueTransformer *)transformerByReducingWithBlock:(NJOPValueTransformReduceBlock)transformationBlock
                                          initialValue:(id)initial {
    NJOPValueTransformBlock block = [self.class reduceWithBlock:transformationBlock initial:initial];
    return [self transformerWithBlock:^id(id value) {
        return block(value);
    }];
}

- (instancetype)reversibleTransformerWithBlock:(NJOPValueTransformBlock)transformationBlock
                                  reverseBlock:(NJOPValueTransformBlock)reverseBlock {
    
    NJOPValueTransformBlock forward = ^(id value){
        return [self transformedValue:value];
    };
    NJOPValueTransformBlock reverse = ^(id value){
        return [self reverseTransformedValue:value];
    };
    
    return [AEReversibleValueTransformer reversibleTransformerWithForwardBlock:^id(id value) {
        id unboxed = forward(value);
        if (unboxed) {
            return transformationBlock(unboxed);
        }
        return unboxed;
    }
                                                                  reverseBlock:^id(id value)
            {
                id unboxed = reverse(value);
                if (unboxed) {
                    return reverseBlock(unboxed);
                }
                return unboxed;
            }];
    
}

@end

@implementation NSValueTransformer (private)

+(NJOPValueTransformBlock)eachWithBlock:(NJOPValueTransformBlock)block {
    
    return ^(id value) {
        if ([value isKindOfClass:[NSArray class]]) {
            
            NSArray* array = (NSArray*)value;
            NSMutableArray *mutable = [NSMutableArray arrayWithCapacity:array.count];
            [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                id value = block(obj) ?: [NSNull null];
                [mutable addObject:value];
            }];
            return mutable.copy;
            
        } else if([value isKindOfClass:[NSSet class]]) {
            
            NSSet* set = (NSSet*)value;
            NSMutableSet *mutable = [NSMutableSet setWithCapacity:set.count];
            
            [set enumerateObjectsUsingBlock:^(id obj, BOOL *stop) {
                id value = block(obj) ?:[NSNull null];
                [mutable addObject:value];
            }];
            
            return mutable.copy;
            
        } else if([value isKindOfClass:[NSDictionary class]]) {
            
            NSDictionary* dictionary = (NSDictionary*)value;
            NSMutableDictionary *mutable = [NSMutableDictionary dictionaryWithCapacity:dictionary.count];
            
            [dictionary enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
                id value = block([NJOPKeyValuePair keyValuePairWithObject:obj
                                                                 andKey:key]) ?: [NSNull null];
                mutable[key] = value;
            }];
            
            return mutable.copy;
            
        } else {
            
            return block(value);
        }
    };
}

+(NJOPValueTransformBlock)reduceWithBlock:(NJOPValueTransformReduceBlock)block initial:(id)initial {
    
    return ^(id value) {
        if ([value isKindOfClass:[NSArray class]]) {
            
            NSArray* array = (NSArray*)value;
            
            __block id result = initial;
            
            [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                result = block(result, obj);
            }];
            
            return result;
            
        } else if([value isKindOfClass:[NSSet class]]) {
            
            NSSet* set = value;
            __block id result = initial;
            
            [set enumerateObjectsUsingBlock:^(id obj, BOOL *stop) {
                result = block(result, obj);
            }];
            
            return result;
            
        } else if([value isKindOfClass:[NSDictionary class]]) {
            
            NSDictionary* dictionary = (NSDictionary*)value;
            __block id result = initial;
            
            [dictionary enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
                result = block(result,[NJOPKeyValuePair keyValuePairWithObject:obj
                                                                      andKey:key]);
            }];
            
            return result;
            
        } else {
            
            return block(initial, value);
            
        }
    };
}

@end

@implementation NSObject(AEReduce)

-(id)transformedValue:(id)value {
    return self;
}

-(id)reverseTransformedValue:(id)value {
    return self;
}

@end

@implementation NJOPKeyValuePair

-(instancetype)initWithObject:(id)obj andKey:(id<NSCopying>)key {
    self = [super init];
    if (self) {
        _key = key;
        _obj = obj;
    }
    return obj;
}

+(instancetype)keyValuePairWithObject:(id)obj andKey:(id<NSCopying>)key {
    return [[self alloc] initWithObject:obj andKey:key];
}

@end

@implementation  NSDictionary (NJOPKeyValuePair)

-(void)enumerateKeyValue:(void (^)(NJOPKeyValuePair *, BOOL *))block {
    [self.keyValuePairs enumerateObjectsUsingBlock:^(id obj, BOOL *stop) {
        block(obj,stop);
    }];
}

-(NSSet*)keyValuePairs {
    NSMutableSet* pairs = [NSMutableSet new];
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        if (![key respondsToSelector:@selector(copyWithZone:)]) {
            key = @([key hash]);
        }
        [pairs addObject:[NJOPKeyValuePair keyValuePairWithObject:obj andKey:key]];
    }];
    return pairs.copy;
}

@end
