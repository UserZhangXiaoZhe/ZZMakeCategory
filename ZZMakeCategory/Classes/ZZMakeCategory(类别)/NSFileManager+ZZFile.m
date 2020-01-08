//
//  NSFileManager+ZZFile.m

//  Created by on 2018/12/25.
//  Copyright © 2018年 . All rights reserved.
//

#import "NSFileManager+ZZFile.h"
#import "NSString+ZZString.h"

@implementation NSFileManager (ZZFile)

/** 缓存地址 */
+ (NSString *)zz_CachesPath{
    BOOL isDir = YES;
    NSString *docPath = [self getPathOfDictionory:NSCachesDirectory];
    if (![[NSFileManager defaultManager] fileExistsAtPath:docPath isDirectory:&isDir ]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:docPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    return docPath;
}
/** 文档地址 */
+ (NSString *)zz_documentPath{
    
    BOOL isDir = YES;
    NSString *docPath = [self getPathOfDictionory:NSDocumentDirectory];
    if (![[NSFileManager defaultManager] fileExistsAtPath:docPath isDirectory:&isDir ]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:docPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return docPath;
}
/** 文档地址 */
+ (NSString *)zz_documentPathForArchive{
    BOOL isDir = YES;
    NSString *docPath = [self getPathOfDictionory:NSDocumentDirectory];
    if (![[NSFileManager defaultManager] fileExistsAtPath:docPath isDirectory:&isDir ]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:docPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    NSString *fileStr = [docPath stringByAppendingPathComponent:@"data.archive"];
    return fileStr;
}
/** 获取用户头像 */
+ (NSString *)zz_getHeaderPath{
    return [[self zz_documentPath] stringByAppendingPathComponent:@"headImage.png"];
}

+ (NSString *)getPathOfDictionory:(NSSearchPathDirectory )searchDictionary {
    return NSSearchPathForDirectoriesInDomains(searchDictionary, NSUserDomainMask, YES).lastObject;
}
/** 判断文件格式 */
+(ZZFileType )getFileTypeWithName:(NSString *)fileName{
    
    //先判断ASCII编码
    ZZFileType tempFileType;
    NSString *tempPath = [[self zz_documentPath] stringByAppendingPathComponent:fileName];
    
    NSData *tempData = [NSData dataWithContentsOfFile:tempPath];
    if (tempData.length<2) {
        tempFileType = ZZFileTypeUnable;
    }else{
        int char1 = 0 ,char2 =0 ; //必须这样初始化
        [tempData getBytes:&char1 range:NSMakeRange(0, 1)];
        [tempData getBytes:&char2 range:NSMakeRange(1, 1)];
        
        NSString *numStr = [NSString stringWithFormat:@"%i%i",char1,char2];
        NSLog(@"文件格式ASCII：%@",numStr);
        
        // 255216 jpg; // 7173 gif;     // 6677 bmp,
        // 13780 png;  // 6787 swf      // 7790 exe dll,
        // 8297 rar    // 8075 zip      // 55122 7z
        // 6063 xml    // 6033 html     // 239187 aspx
        // 117115 cs   // 119105 js     // 102100 txt
        // 255254 sql  //3780 PDF      //00 识别不出，如.DS_Store
        
        if ([numStr isEqualToString:@"3780"]) {
            tempFileType = ZZFileTypePDF;
        }else if ([numStr isEqualToString:@"255216"] || [numStr isEqualToString:@"13780"]) {
            tempFileType = ZZFileTypeImage;
        }else if ([numStr isEqualToString:@"102100"]) {
            tempFileType = ZZFileTypeText;
        }else if ([numStr isEqualToString:@"8075"]) {
            tempFileType = ZZFileTypeWord;
        }else if ([numStr isEqualToString:@"3"]) {
            tempFileType = ZZFileTypeVideo;
        }else{
            tempFileType = ZZFileTypeUnable;
        }
    }
    //再判断名称
    if (tempFileType == ZZFileTypeUnable) {
        if ([fileName rangeOfString:@".pdf"].location != NSNotFound) {
            tempFileType = ZZFileTypePDF;
        }else if ([fileName rangeOfString:@".docx"].location != NSNotFound || [fileName rangeOfString:@".doc"].location != NSNotFound) {
            tempFileType = ZZFileTypeWord;
        }else if ([fileName rangeOfString:@".png"].location != NSNotFound || [fileName rangeOfString:@".jpg"].location != NSNotFound) {
            tempFileType = ZZFileTypeImage;
        }else if ([fileName rangeOfString:@".mp4"].location != NSNotFound) {
            tempFileType = ZZFileTypeVideo;
        }else if ([fileName rangeOfString:@".txt"].location != NSNotFound) {
            tempFileType = ZZFileTypeText;
        }else{
            tempFileType = ZZFileTypeUnable;
        }
    }
    
    return tempFileType;
}

/** 删除文件 */
+(void)deleteFileWithName:(NSString *)fileName{
    NSString *tempPath = [[self zz_documentPath] stringByAppendingPathComponent:fileName];
    
    if( [[NSFileManager defaultManager] fileExistsAtPath:tempPath] ) {
        BOOL isSuccess = [[NSFileManager defaultManager] removeItemAtPath:tempPath error:nil];
        NSLog(@"%@",isSuccess ? @"文件删除成功" : @"文件删除失败");
    }
}

+(BOOL)deleteFileWithPath:(NSString *)path{
    if ([[self defaultManager] fileExistsAtPath:path]) {
        NSLog(@"文件存在");
        BOOL isSuccess = [[self defaultManager] removeItemAtPath:path error:nil];
        NSLog(@"%@",isSuccess ? @"文件删除成功" : @"文件删除失败");
        return isSuccess;
    }else{
        NSLog(@"文件不存在");
        return NO;
    }
}

+(NSString *)txtFileContentForPath:(NSString *)pathFile{
    
    NSString *contentTxt = @"暂无";
 
    NSError *error ;
    NSStringEncoding encoding;
    NSString *content = [NSString stringWithContentsOfFile:pathFile usedEncoding:&encoding error:&error];
    if (error == nil) {
        NSLog(@"编码格式 %lu",encoding); //如utf-8编码的会得到4
        return content;
    }else{
        NSLog(@"编码错误 %@",error);
    }
    
    NSString *UTF8txtString = [[NSString alloc] initWithContentsOfFile:pathFile encoding:NSUTF8StringEncoding error:nil];
    if ([NSString zz_checkWithString:UTF8txtString]) {
         contentTxt = UTF8txtString;
    }else{
        //按GBK编码再解码一次.
        UTF8txtString = [[NSString alloc] initWithContentsOfFile:pathFile encoding:0x80000632 error:nil];
        
         if ([NSString zz_checkWithString:UTF8txtString]) {
              contentTxt = UTF8txtString;
         }else{
             //还是识别不到，按GB18030编码再解码一次.
             UTF8txtString = [NSString stringWithContentsOfFile:pathFile encoding:0x80000631 error:nil];
             if ([NSString zz_checkWithString:UTF8txtString]) {
                  contentTxt = UTF8txtString;
             }
         }
        
    }
    return contentTxt;
}
@end
