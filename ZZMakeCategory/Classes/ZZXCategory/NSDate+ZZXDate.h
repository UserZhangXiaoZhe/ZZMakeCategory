//          
//  NSDate+ZZXDate.h
//  Created  on 2020/6/9.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (ZZXDate)

@property (nonatomic, readonly) NSInteger year; ///< Year component
@property (nonatomic, readonly) NSInteger month; ///< Month component (1~12)
@property (nonatomic, readonly) NSInteger day; ///< Day component (1~31)
@property (nonatomic, readonly) NSInteger hour; ///< Hour component (0~23)
@property (nonatomic, readonly) NSInteger minute; ///< Minute component (0~59)
@property (nonatomic, readonly) NSInteger second; ///< Second component (0~59)
@property (nonatomic, readonly) NSInteger nanosecond; ///< Nanosecond component
@property (nonatomic, readonly) NSInteger weekday; ///< Weekday component (1~7, first day is based on user setting)
@property (nonatomic, readonly) NSInteger weekdayOrdinal; ///< 周几
@property (nonatomic, readonly) NSInteger weekOfMonth; ///< 一月中的星期 (1~5)
@property (nonatomic, readonly) NSInteger weekOfYear; ///< 一年中的星期 (1~53)
@property (nonatomic, readonly) NSInteger yearForWeekOfYear; ///< YearForWeekOfYear component
@property (nonatomic, readonly) NSInteger quarter; ///< 季度
@property (nonatomic, readonly) BOOL isLeapMonth; ///< 闰月
@property (nonatomic, readonly) BOOL isLeapYear; ///< 闰年
@property (nonatomic, readonly) BOOL isToday; ///< whether date is today (based on current locale)
@property (nonatomic, readonly) BOOL isYesterday; ///< whether date is yesterday (based on current locale)
/// 获取某个月的天数
+ (NSInteger)zz_getDaysInMonth:(NSString *)month;
/// 获取某年的天数
+ (NSInteger)zz_getDaysInYear:(NSString *)year;
/// 获取日期是一年中的第几天
+ (NSInteger)zz_getNumDayInYear:(NSString *)year;

/// 是否是今年
- (BOOL)zz_isThisYear;
/// 是否是昨天(过去时间)
+ (BOOL)zz_isDateInYesterday:(NSString *)string;
/// 是否是明天(未来时间)
+ (BOOL)zz_isDateInTomorrow:(NSString *)string;
/// 是否是今天
- (BOOL)zz_isToday;
/// 1.过去日期  2.未来日期  3.今天
+(NSInteger )zz_compareDate1:(NSString *)time1 Date2:(NSString *)time2;
/**
 将时间字符串转换成date (TimeString ==> NSDate)
 Example:
 NSString *string = @"2017-09-15";
 NSDate *date = [NSDate zz_dateWithString:string format:@"yyyy-MM-dd"];
 */
+ (NSDate *)zz_dateWithString:(NSString *)dateString format:(NSString *)format;
/**
 将时间字符串转换成时间戳 (TimeString => Timestamp) / 北京时间
 Example:
 NSString *timeString = @"2017-09-15 15:39";
 NSInteger timestamp = [NSDate zz_timestampFromTimeString:timeString formatter:@"yyyy-MM-dd HH:mm"];
 */
+ (NSInteger)zz_timestampFromTimeString:(NSString *)timeString formatter:(NSString *)format;

/// 将时间戳转换成时间字符串 (Timestamp => TimeString) / 北京时间
+ (NSString *)zz_timeStringFromTimestamp:(NSInteger)timestamp formatter:(NSString *)format;

/** 开始到结束的时间差 */
+ (NSInteger )zz_dateTimeDifferenceWithStartTime:(NSString *)startTime endTime:(NSString *)endTime;
/** 开始到结束的时间差 */
+ (NSString *)zz_intervalStartTime:(NSString *)startTime endTime:(NSString *)endTime;

/// 获取当前系统时间的时间戳 / 北京时间
+ (NSInteger)zz_getNowTimestamp;
/// 获取当前时间戳字符串
+ (NSString *)zz_currentTimeString;

/// 当前时间转换成时间格式
+ (NSString *)zz_currentWithFormat:(NSString *)format;
+ (NSString *)zz_currentWithFormatActive;
/// 秒 转换成 时分秒
+ (NSString *)zz_transformTimeFormatted:(NSInteger )totalSeconds tpye:(NSInteger)type;
+ (NSString *)zz_transformTimeFormatted:(NSInteger)totalSeconds;
+ (NSString *)zz_transformTimeFormatted1:(NSInteger )totalSeconds;

/// 时间变成 XX分钟之前
+ (NSString *)zz_compareCurrentTime:(NSString *)str;

/// 公历转成阴历
+ (NSString *)zz_lunarCalendarForDate:(NSString *)dateTime;

/// 时间处理 昨天、今天、刚刚、分钟前、小时前
+ (NSString *)stringWithTimelineDate:(NSDate *)date;

/// 获取周几
+(NSString *)zz_getWeekForDate:(NSDate *)data;
// 返回星期几
- (NSString *)zz_getWeekWithdate:(NSDate *)date;
@end

NS_ASSUME_NONNULL_END
