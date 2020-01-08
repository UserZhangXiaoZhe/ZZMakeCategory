//
//  NSArray+ZZNSArray.m
//  ZZTools_Example
//
//  Created by 张哲 on 2018/12/18.
//  Copyright © 2018年 UserZhangXiaoZhe. All rights reserved.
//

#import "NSArray+ZZNSArray.h"
#import <Photos/Photos.h>
@implementation NSArray (ZZNSArray)


- (BOOL)zz_checkBlankWithArray{
    if (!self) return YES;
    
    if ([self isKindOfClass:[NSNull class]])return YES;
    
    if (self == nil) return YES;
    
    if (self == NULL) return YES;
    
    if (![self isKindOfClass:[NSArray class]]) return YES;
    
    if (self.count == 0) return YES;
    return NO;
    
}


+ (NSArray *)zz_getPhotoFromSystem{
    
    @autoreleasepool {
        PHFetchOptions *fetchOptions = [PHFetchOptions new];
        fetchOptions.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:NO]];
        // 获得所有的自定义相簿
        PHFetchResult<PHAssetCollection *> *assetCollections = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeSmartAlbumUserLibrary options:nil];
        NSMutableArray *tempArr = [NSMutableArray arrayWithCapacity:0];
        // 遍历所有的自定义相簿
        for (PHAssetCollection *assetCollection in assetCollections) {
            
            PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
            options.resizeMode = PHImageRequestOptionsResizeModeFast;
            // 同步获得图片, 只会返回1张图片
            options.synchronous = YES;
            
            // 获得某个相簿中的所有PHAsset对象
            PHFetchResult<PHAsset *> *assets = [PHAsset fetchAssetsInAssetCollection:assetCollection options:fetchOptions];
            [tempArr addObject:assets];
        }
        return tempArr;
    }
    return nil;
}

- (NSString *)descriptionWithLocale:(id)locale{
    
    NSMutableString *strM = [NSMutableString stringWithString:@"(\n"];
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [strM appendFormat:@"\t%@,\n", obj];
    }];
    [strM appendString:@")"];
    return strM.copy;
}

+ (NSArray *)zz_imagesWithGif:(NSString *)gifNameInBoundle {
    NSURL *fileUrl = [[NSBundle mainBundle] URLForResource:gifNameInBoundle withExtension:@"gif"];
    
    CGImageSourceRef gifSource = CGImageSourceCreateWithURL((CFURLRef)fileUrl, NULL);
    size_t gifCount = CGImageSourceGetCount(gifSource);
    
    NSMutableArray *frames = [[NSMutableArray alloc]init];
    for (size_t i = 0; i< gifCount; i++) {
        CGImageRef imageRef = CGImageSourceCreateImageAtIndex(gifSource, i, NULL);
        UIImage *image = [UIImage imageWithCGImage:imageRef];
        [frames addObject:image];
        CGImageRelease(imageRef);
    }
    
    return frames;
}
@end
