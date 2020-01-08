//
//  NSFileManager+ZZFile.h

//  Created by  on 2018/12/25.
//  Copyright © 2018年 . All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// 文件类型
typedef NS_ENUM(NSInteger, ZZFileType) {
    ZZFileTypeWord,           ///
    ZZFileTypePDF,            ///
    ZZFileTypeText,           ///
    ZZFileTypeVideo,          ///
    ZZFileTypeImage,          ///
    ZZFileTypeAllType,        ///
    ZZFileTypeUnable,         ///
};

@interface NSFileManager (ZZFile)
/** 缓存地址 */
+ (NSString *)zz_CachesPath;
/** 文档地址 */
+ (NSString *)zz_documentPath;
/** 归档的文档地址 */
+ (NSString *)zz_documentPathForArchive;
/** 获取用户头像 */
+ (NSString *)zz_getHeaderPath;
/** 判断文件格式 */
+(ZZFileType )getFileTypeWithName:(NSString *)fileName;
/** 删除文件，通过文件名,默认在document */
+(void)deleteFileWithName:(NSString *)fileName;
/** 删除文件，通过路径 */
+(BOOL)deleteFileWithPath:(NSString *)path;
/** 读取TXT文件 */
+(NSString *)txtFileContentForPath:(NSString *)pathFile;
@end

NS_ASSUME_NONNULL_END
