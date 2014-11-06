//
//  NJOPValueTransformer.h
//  Tailwind
//
//  Created by DAVID LIN on 10/10/14.
//  Copyright (c) 2014 NetJets. All rights reserved.
//

@import Foundation;

@protocol NSTransformable <NSObject>

- (id)transformedValue:(id)value;           // by default returns value
- (id)reverseTransformedValue:(id)value;    // will not even if +allowsReverseTransformation returns NO. will return self and not invokes transformedValue: if reverser transform is not there.

@end

typedef id (^NJOPValueTransformBlock)(id);
typedef id (^NJOPValueTransformReduceBlock)(id sum, id obj);

@interface NJOPValueTransformer : NSValueTransformer<NSTransformable>

// Returns a transformer which transforms values using the given block. Reverse
// transformations will not be allowed.
+ (instancetype)transformerWithBlock:(NJOPValueTransformBlock)transformationBlock;

// Returns a transformer which transforms values using the given blocks.
+ (instancetype)reversibleTransformerWithForwardBlock:(NJOPValueTransformBlock)forwardBlock
                                         reverseBlock:(NJOPValueTransformBlock)reverseBlock;

- (instancetype)transformerWithBlock:(NJOPValueTransformBlock)transformationBlock;

- (instancetype)transformerForEachWithBlock:(NJOPValueTransformBlock)transformationBlock;

- (instancetype)transformerByReducingWithBlock:(NJOPValueTransformReduceBlock)transformationBlock;

- (instancetype)transformerByCollectingKeyValuePairs;

- (instancetype)transformerByReducingWithBlock:(NJOPValueTransformReduceBlock)transformationBlock initialValue:(id)initial;

- (instancetype)reversibleTransformerWithBlock:(NJOPValueTransformBlock)transformationBlock
                                  reverseBlock:(NJOPValueTransformBlock)reverseBlock;

@end

@interface NSValueTransformer (NJOPValueTransformer)

- (NJOPValueTransformer* )transformerWithBlock:(NJOPValueTransformBlock)transformationBlock;

- (NJOPValueTransformer* )transformerForEachWithBlock:(NJOPValueTransformBlock)transformationBlock;

- (NJOPValueTransformer*) transformerByReducingWithBlock:(NJOPValueTransformReduceBlock)transformationBlock;

- (NJOPValueTransformer *)transformerByReducingWithBlock:(NJOPValueTransformReduceBlock)transformationBlock
                                          initialValue:(id)initial;

- (NJOPValueTransformer *)reversibleTransformerWithBlock:(NJOPValueTransformBlock)transformationBlock
                                          reverseBlock:(NJOPValueTransformBlock)reverseBlock;

@end

@interface NSObject(NSValueTransformer) <NSTransformable>


- (id)transformedValue:(id)value;           // by default returns value
- (id)reverseTransformedValue:(id)value;
- (NJOPValueTransformer*)transformerWithBlock:(NJOPValueTransformBlock)transformationBlock;

@end

@class NJOPKeyValuePair;
@interface NSDictionary (NJOPKeyValuePair)
-(NSSet*)keyValuePairs;
-(void)enumerateKeyValue:(void (^)(NJOPKeyValuePair* pair, BOOL *stop))block;
@end

@interface NJOPKeyValuePair : NSObject
@property (copy,nonatomic) id<NSCopying>key;
@property (copy,nonatomic) id obj;

+(instancetype)keyValuePairWithObject:(id)obj andKey:(id<NSCopying>)key;

@end
