//          
//  NSDate+ZZXDate.m
//  Created  on 2020/6/9.
//

#import "NSDate+ZZXDate.h"

@implementation NSDate (ZZXDate)

- (NSInteger)year {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitYear fromDate:self] year];
}

- (NSInteger)month {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitMonth fromDate:self] month];
}

- (NSInteger)day {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitDay fromDate:self] day];
}

- (NSInteger)hour {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitHour fromDate:self] hour];
}

- (NSInteger)minute {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitMinute fromDate:self] minute];
}

- (NSInteger)second {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitSecond fromDate:self] second];
}

- (NSInteger)nanosecond {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitSecond fromDate:self] nanosecond];
}

- (NSInteger)weekday {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitWeekday fromDate:self] weekday];
}

- (NSInteger)weekdayOrdinal {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitWeekdayOrdinal fromDate:self] weekdayOrdinal];
}

- (NSInteger)weekOfMonth {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitWeekOfMonth fromDate:self] weekOfMonth];
}

- (NSInteger)weekOfYear {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitWeekOfYear fromDate:self] weekOfYear];
}

- (NSInteger)yearForWeekOfYear {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitYearForWeekOfYear fromDate:self] yearForWeekOfYear];
}

- (NSInteger)quarter {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitQuarter fromDate:self] quarter];
}

- (BOOL)isLeapMonth {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitQuarter fromDate:self] isLeapMonth];
}
/// 获取日期是一年中的第几天
+ (NSInteger)zz_getNumDayInYear:(NSString *)year{
    
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate * date = [formatter dateFromString:year];

    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSInteger numDay = [calendar ordinalityOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitYear forDate:date];
    return numDay;
}
/// 获取某年的天数
+ (NSInteger)zz_getDaysInYear:(NSString *)year{
    
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"]; // 年-月
    NSDate * date = [formatter dateFromString:year]; 
    NSCalendar * calendar = [NSCalendar currentCalendar];
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay
                                   inUnit: NSCalendarUnitYear
                                  forDate:date];
    return range.length;
}

/// 获取某个月的天数
+ (NSInteger)zz_getDaysInMonth:(NSString *)month{
    
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"]; // 年-月
    NSDate * date = [formatter dateFromString:month];
    NSCalendar * calendar = [NSCalendar currentCalendar];
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay
                                   inUnit: NSCalendarUnitMonth
                                  forDate:date];
    return range.length; 
}
- (BOOL)isLeapYear {
    NSUInteger year = self.year;
    return ((year % 400 == 0) || ((year % 100 != 0) && (year % 4 == 0)));
}

- (BOOL)isToday {
    if (fabs(self.timeIntervalSinceNow) >= 60 * 60 * 24) return NO;
    return [NSDate new].day == self.day;
}

- (BOOL)isYesterday {
    NSDate *added = [self dateByAddingDays:1];
    return [added isToday];
}

- (NSDate *)dateByAddingDays:(NSInteger)days {
    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + 86400 * days;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}
/// 是否是今年
- (BOOL)zz_isThisYear{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitYear;
    // 1.获得当前时间的年月日
    NSDateComponents *nowCmps = [calendar components:unit fromDate:[NSDate date]];
    // 2.获得self的年月日
    NSDateComponents *selfCmps = [calendar components:unit fromDate:self];
    return nowCmps.year == selfCmps.year;
}

+ (BOOL)zz_isDateInYesterday:(NSString *)string{
    if (string.length > 10) {
        string = [string substringToIndex:10];
    }
    
    NSDateFormatter *format = [[NSDateFormatter alloc]init];
    [format setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [format dateFromString:string];
    BOOL isToday = [[NSCalendar currentCalendar] isDateInYesterday:date];
    return isToday;
}

+ (BOOL)zz_isDateInTomorrow:(NSString *)string {
    if (string.length > 10) {
        string = [string substringToIndex:10];
    }
    NSDateFormatter *format = [[NSDateFormatter alloc]init];
    [format setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [format dateFromString:string];
    BOOL isToday = [[NSCalendar currentCalendar] isDateInTomorrow:date];
    return isToday;
}
- (BOOL)zz_isToday {
    return [self zz_isSameDay:[NSDate date]];
}
- (BOOL)zz_isSameDay:(NSDate *)anotherDate {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components1 = [calendar components:(NSCalendarUnitYear
                                                          | NSCalendarUnitMonth
                                                          | NSCalendarUnitDay)
                                                fromDate:self];
    NSDateComponents *components2 = [calendar components:(NSCalendarUnitYear
                                                          | NSCalendarUnitMonth
                                                          | NSCalendarUnitDay)
                                                fromDate:anotherDate];
    return ([components1 year] == [components2 year]
            && [components1 month] == [components2 month]
            && [components1 day] == [components2 day]);
}

/// 1.过去日期  2.未来日期  3.今天
+(NSInteger )zz_compareDate1:(NSString *)time1 Date2:(NSString *)time2{
    if (time1.length > 10) {
        time1 = [time1 substringToIndex:10];
    }
    if (time2.length > 10) {
        time2 = [time2 substringToIndex:10];
    }
    
    NSDateFormatter *format = [[NSDateFormatter alloc]init];
    [format setDateFormat:@"yyyy-MM-dd"];
    NSDate *date1 = [format dateFromString:time1];
    NSDate *date2 = [format dateFromString:time2];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components1 = [calendar components:(NSCalendarUnitYear
                                                          | NSCalendarUnitMonth
                                                          | NSCalendarUnitDay)
                                                fromDate:date1];
    NSDateComponents *components2 = [calendar components:(NSCalendarUnitYear
                                                          | NSCalendarUnitMonth
                                                          | NSCalendarUnitDay)
                                                fromDate:date2];
    
    if ([components1 year] > [components2 year]) {
        return 1;
    }
    if ([components1 year] < [components2 year]) {
        return 2;
    }
    
    if ([components1 year] == [components2 year]
        && [components1 month] > [components2 month]) {
        return 1;
    }
    if ([components1 year] == [components2 year]
        && [components1 month] < [components2 month]) {
        return 2;
    }
    
    if ([components1 year] == [components2 year]
        && [components1 month] == [components2 month]
        && [components1 day] > [components2 day]) {
        return 1;
    }
    
    if ([components1 year] == [components2 year]
    && [components1 month] == [components2 month]
    && [components1 day] < [components2 day]) {
        return 2;
    }
    
    if ([components1 year] == [components2 year]
    && [components1 month] == [components2 month]
    && [components1 day] == [components2 day]) {
        return 3;
    }
    
    return 0;
}

+ (NSDate *)zz_dateWithString:(NSString *)dateString format:(NSString *)format {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    return [formatter dateFromString:dateString];
}
/// 将时间字符串转换成时间戳 (TimeString => Timestamp) / 北京时间
+ (NSInteger)zz_timestampFromTimeString:(NSString *)timeString formatter:(NSString *)format{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:format];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setTimeZone:timeZone];
    // 将字符串按formatter转成NSDate
    NSDate *date = [formatter dateFromString:timeString];
    return [self timestampFromDate:date];
}


// (Timestamp => TimeString)
+ (NSString *)zz_timeStringFromTimestamp:(NSInteger)timestamp formatter:(NSString *)format {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:format];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setTimeZone:timeZone];
    NSDate *timeDate = [NSDate dateWithTimeIntervalSince1970:timestamp];
    return [formatter stringFromDate:timeDate];
}


/** 开始到结束的时间差 */
+ (NSInteger )zz_dateTimeDifferenceWithStartTime:(NSString *)startTime endTime:(NSString *)endTime{
 
    NSDateFormatter *date = [[NSDateFormatter alloc]init];
    [date setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *startD =[date dateFromString:startTime];
    NSDate *endD = [date dateFromString:endTime];
    NSTimeInterval start = [startD timeIntervalSince1970] * 1;
    NSTimeInterval end = [endD timeIntervalSince1970] * 1;
    NSTimeInterval value = end - start;
    NSInteger second = (NSInteger )value;//秒
    
    return second;
}

- (NSString *)zz_intervalStartTime:(NSString *)startTime endTime:(NSString *)endTime{
    
    NSDateFormatter *date=[[NSDateFormatter alloc] init];
    [date setDateFormat:@"yyyy-MM-dd"];
    NSDate *d1=[date dateFromString:startTime];
    NSTimeInterval late1=[d1 timeIntervalSince1970]*1;
    NSDate *d2=[date dateFromString:endTime];
    NSTimeInterval late2=[d2 timeIntervalSince1970]*1;
    NSTimeInterval cha=late2-late1;
    NSString *timeString=@"";
    NSString *house=@"";
    NSString *min=@"";
    NSString *sen=@"";
    
    sen = [NSString stringWithFormat:@"%d", (int)cha%60];
    sen=[NSString stringWithFormat:@"%@", sen];
    min = [NSString stringWithFormat:@"%d", (int)cha/60%60];
    min=[NSString stringWithFormat:@"%@", min];
    house = [NSString stringWithFormat:@"%d", (int)cha/3600];
    house=[NSString stringWithFormat:@"%@", house];
    timeString=[NSString stringWithFormat:@"差小时:%@-----分:%@------秒:%@",house,min,sen];
    return timeString;
    
}
/// 获取当前系统时间的时间戳 / 北京时间
+ (NSInteger)zz_getNowTimestamp{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setTimeZone:timeZone];
    return [self timestampFromDate:[NSDate date]];
}

+ (NSInteger)timestampFromDate:(NSDate *)date {
    return [[NSNumber numberWithDouble:[date timeIntervalSince1970]] integerValue];
}

+ (NSString *)zz_currentTimeString {
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a = [date timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat:@"%d", (int)a];
    return timeString;
}

+ (NSString *)zz_currentWithFormat:(NSString *)format{
    return [[NSDate date] stringWithFormat:format];
}

+ (NSString *)zz_currentWithFormatActive{
    return [[NSDate date] stringWithFormat:@"yyyy-MM-dd HH:mm"];
}
- (NSString *)stringWithFormat:(NSString *)format {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    [formatter setLocale:[NSLocale currentLocale]];
    return [formatter stringFromDate:self];
}

+ (NSString *)zz_transformTimeFormatted:(NSInteger )totalSeconds tpye:(NSInteger)type{
    
    NSInteger seconds = totalSeconds % 60;
    NSInteger minutes = (totalSeconds / 60) % 60;
    NSInteger hours = totalSeconds / 3600;
    NSInteger days = totalSeconds / 3600 / 24;
    
    if (type == 1) {
        
        if (days != 0) {
            return [NSString stringWithFormat:@"%02ld",days];
        }else if (days == 0 && hours != 0) {
            return [NSString stringWithFormat:@"1"];
        }else if (days == 0 && hours == 0 && minutes != 0){
            return [NSString stringWithFormat:@"1"];
        }else{
            return [NSString stringWithFormat:@"1"];
        }
    }else if (type == 2){
        
        if ( hours != 0) {
            return [NSString stringWithFormat:@"%02ld:%02ld:%02ld",hours, minutes, seconds];
        }else if (hours == 0 && minutes != 0){
            return [NSString stringWithFormat:@"00:%02ld:%02ld", minutes, seconds];
        }else{
            return [NSString stringWithFormat:@"00:00:%ld", seconds];
        }
    }
    
    return nil;
}
+ (NSString *)zz_transformTimeFormatted:(NSInteger )totalSeconds{
    
    NSInteger seconds = totalSeconds % 60;
    NSInteger minutes = (totalSeconds / 60) % 60;
    NSInteger hours = totalSeconds / 3600;
    
    if ( hours != 0) {
        return [NSString stringWithFormat:@"%02ld:%02ld:%02ld",hours, minutes, seconds];
    }else if (hours == 0 && minutes != 0){
        return [NSString stringWithFormat:@"00:%02ld:%02ld", minutes, seconds];
    }else{
        return [NSString stringWithFormat:@"00:00:%ld", seconds];
    }
}
+ (NSString *)zz_transformTimeFormatted1:(NSInteger )totalSeconds{
    
    NSInteger seconds = totalSeconds % 60;
    NSInteger minutes = (totalSeconds / 60) % 60;
    NSInteger hours = totalSeconds / 3600;
    
    if ( hours != 0) {
        return [NSString stringWithFormat:@"%02ldh %02ldmin",hours, minutes];
    }else if (hours == 0 && minutes != 0){
        return [NSString stringWithFormat:@"%02ldmin", minutes];
    }else{
        return [NSString stringWithFormat:@"< 1min"];
    }
}

+ (NSString *)zz_compareCurrentTime:(NSString *)str{
    
    //把字符串转为NSdate
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *timeDate = [dateFormatter dateFromString:str];
    NSDate *currentDate = [NSDate date];
    NSTimeInterval timeInterval = [currentDate timeIntervalSinceDate:timeDate];
    
    long temp = 0;
    NSString *result;
    
    if (timeInterval/60 < 1) {
        result = [NSString stringWithFormat:@"刚刚"];
    }else if((temp = timeInterval/60) <60){
        result = [NSString stringWithFormat:@"%ld分钟前",temp];
    }else if((temp = temp/60) <24){
        result = [NSString stringWithFormat:@"%ld小时前",temp];
    }else{
        str = [str substringFromIndex:5];
        result = [NSString stringWithFormat:@"%@",str];
    }
    
    
//    if (timeInterval/60 < 1) {
//        result = [NSString stringWithFormat:@"刚刚"];
//    }else if((temp = timeInterval/60) <60){
//        result = [NSString stringWithFormat:@"%ld分钟前",temp];
//    }else if((temp = temp/60) <24){
//        result = [NSString stringWithFormat:@"%ld小时前",temp];
//    }else if((temp = temp/24) <30){
//        result = [NSString stringWithFormat:@"%ld天前",temp];
//    }else if((temp = temp/30) <12){
//        result = [NSString stringWithFormat:@"%ld月前",temp];
//    }else{
//        temp = temp/12;
//        result = [NSString stringWithFormat:@"%ld年前",temp];
//    }
    return result;
    
}
 
/// 阴历
+(NSString *)zz_lunarCalendarForDate:(NSString *)dateTime{
    
    //农历日期名
    NSArray *chineseYears = [NSArray arrayWithObjects:
                             @"甲子", @"乙丑", @"丙寅", @"丁卯",  @"戊辰",  @"己巳",  @"庚午",  @"辛未",  @"壬申",  @"癸酉",
                             @"甲戌",   @"乙亥",  @"丙子",  @"丁丑", @"戊寅",   @"己卯",  @"庚辰",  @"辛己",  @"壬午",  @"癸未",
                             @"甲申",   @"乙酉",  @"丙戌",  @"丁亥",  @"戊子",  @"己丑",  @"庚寅",  @"辛卯",  @"壬辰",  @"癸巳",
                             @"甲午",   @"乙未",  @"丙申",  @"丁酉",  @"戊戌",  @"己亥",  @"庚子",  @"辛丑",  @"壬寅",  @"癸丑",
                             @"甲辰",   @"乙巳",  @"丙午",  @"丁未",  @"戊申",  @"己酉",  @"庚戌",  @"辛亥",  @"壬子",  @"癸丑",
                             @"甲寅",   @"乙卯",  @"丙辰",  @"丁巳",  @"戊午",  @"己未",  @"庚申",  @"辛酉",  @"壬戌",  @"癸亥", nil];
    
    NSArray *chineseMonths=[NSArray arrayWithObjects:
                            @"正月", @"二月", @"三月", @"四月", @"五月", @"六月", @"七月", @"八月",
                            @"九月", @"十月", @"十一月", @"腊月", nil];
    
    NSArray *chineseDays=[NSArray arrayWithObjects:
                          @"初一", @"初二", @"初三", @"初四", @"初五", @"初六", @"初七", @"初八", @"初九", @"初十",
                          @"十一", @"十二", @"十三", @"十四", @"十五", @"十六", @"十七", @"十八", @"十九", @"二十",
                          @"廿一", @"廿二", @"廿三", @"廿四", @"廿五", @"廿六", @"廿七", @"廿八", @"廿九", @"三十",  nil];
    
    NSDate *dateTemp = nil;
    NSDateFormatter *dateFormater = [[NSDateFormatter alloc]init];
    [dateFormater setDateFormat:@"yyyy-MM-dd"];
    if (dateTime.length > 10) {
        dateTime = [dateTime substringToIndex:10];
    }
    dateTemp = [dateFormater dateFromString:dateTime];
    NSCalendar *localeCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierChinese];
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay;
    NSDateComponents *localeComp = [localeCalendar components:unitFlags fromDate:dateTemp];
    //MyLog(@"农历日期:%ld_%ld_%ld  %@",(long)localeComp.year,(long)localeComp.month,(long)localeComp.day, localeComp.date);
    NSString *y_str = [chineseYears objectAtIndex:localeComp.year-1];
    NSString *m_str = [chineseMonths objectAtIndex:localeComp.month-1];
    NSString *d_str = [chineseDays objectAtIndex:localeComp.day-1];
    
    NSString *chineseCal_str = [NSString stringWithFormat: @"%@年%@%@",y_str,m_str,d_str];
     
    NSString *choose_str = [NSString stringWithFormat: @"%@%@",m_str,d_str];
    NSString *riqi_str = [dateTime substringWithRange:NSMakeRange(5, 5)];
    if ([d_str isEqualToString:@"初一"]) {
        chineseCal_str = chineseCal_str;
    }else{
        if ([riqi_str isEqualToString:@"01-01"]) {
            chineseCal_str = [chineseCal_str stringByAppendingString:@"元旦节"];
        }else if([riqi_str isEqualToString:@"04-01"]){
            chineseCal_str = [chineseCal_str stringByAppendingString:@"愚人节"];
        }else if([riqi_str isEqualToString:@"05-01"]){
            chineseCal_str = [chineseCal_str stringByAppendingString:@"劳动节"];
        }else if([riqi_str isEqualToString:@"06-01"]){
            chineseCal_str = [chineseCal_str stringByAppendingString:@"儿童节"];
        }else if([riqi_str isEqualToString:@"07-01"]){
            chineseCal_str = [chineseCal_str stringByAppendingString:@"建军节"];
        }else if([riqi_str isEqualToString:@"08-01"]){
            chineseCal_str = [chineseCal_str stringByAppendingString:@"建党节"];
        }else if([riqi_str isEqualToString:@"09-10"]){
            chineseCal_str = [chineseCal_str stringByAppendingString:@"教师节"];
        }else if([riqi_str isEqualToString:@"10-01"]){
            chineseCal_str = [chineseCal_str stringByAppendingString:@"国庆节"];
        }else if([riqi_str isEqualToString:@"12-25"]){
            chineseCal_str = [chineseCal_str stringByAppendingString:@"圣诞节"];
        }else if ([choose_str isEqualToString:@"腊月三十"]) {
            chineseCal_str = [chineseCal_str stringByAppendingString:@"除夕夜"];
        }else if ([choose_str isEqualToString:@"正月十五"]){
            chineseCal_str = [chineseCal_str stringByAppendingString:@"元宵节"];
        }else if ([choose_str isEqualToString:@"二月初二"]){
            chineseCal_str = [chineseCal_str stringByAppendingString:@"龙头节"];
        }else if ([choose_str isEqualToString:@"三月初八"]){
            chineseCal_str = [chineseCal_str stringByAppendingString:@"清明节"];
        }else if ([choose_str isEqualToString:@"五月初五"]){
            chineseCal_str = [chineseCal_str stringByAppendingString:@"端午节"];
        }else if ([choose_str isEqualToString:@"七月初七"]){
            chineseCal_str = [chineseCal_str stringByAppendingString:@" 七夕节"];
        }else if ([choose_str isEqualToString:@"八月十五"]){
            chineseCal_str = [chineseCal_str stringByAppendingString:@"中秋节"];
        }else if ([choose_str isEqualToString:@"十月初一"]){
            chineseCal_str = [chineseCal_str stringByAppendingString:@"国庆节"];
        }else{
            chineseCal_str = chineseCal_str;
        }
    } 
    return chineseCal_str;
}

/// 获取周几
+(NSString *)zz_getWeekForDate:(NSDate *)data{
    
    NSDate *dateTime = data;
    
    NSString *weekStr = @"";
    switch (dateTime.weekday) {
        case 1:{
            weekStr = @"日";
        } break;
            
        case 2:{
            weekStr = @"一";
        } break;
            
        case 3:{
            weekStr = @"二";
        } break;
            
        case 4:{
            weekStr = @"三";
        } break;
        case 5:{
            weekStr = @"四";
        } break;
        case 6:{
            weekStr = @"五";
        } break;
        case 7:{
            weekStr = @"六";
        } break;
        default:
            break;
    }
    return weekStr;
    
}

// 返回星期几
- (NSString *)zz_getWeekWithdate:(NSDate *)date {
    
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"星期日", @"星期一", @"星期二", @"星期三", @"星期四", @"星期五", @"星期六", nil];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:date];
    NSString *weekday = [weekdays objectAtIndex:theComponents.weekday];
    return weekday;
}

/// 时间处理 昨天、今天、刚刚、分钟前、小时前
+ (NSString *)stringWithTimelineDate:(NSDate *)date {
    if (!date) return @"";
    
    static NSDateFormatter *formatterYesterday;
    static NSDateFormatter *formatterSameYear;
    static NSDateFormatter *formatterFullDate;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formatterYesterday = [[NSDateFormatter alloc] init];
        [formatterYesterday setDateFormat:@"昨天 HH:mm"];
        [formatterYesterday setLocale:[NSLocale currentLocale]];
        
        formatterSameYear = [[NSDateFormatter alloc] init];
        [formatterSameYear setDateFormat:@"M-d"];
        [formatterSameYear setLocale:[NSLocale currentLocale]];
        
        formatterFullDate = [[NSDateFormatter alloc] init];
        [formatterFullDate setDateFormat:@"yy-M-dd"];
        [formatterFullDate setLocale:[NSLocale currentLocale]];
    });
    
    NSDate *now = [NSDate new];
    NSTimeInterval delta = now.timeIntervalSince1970 - date.timeIntervalSince1970;
    if (delta < -60 * 10) { // 本地时间有问题
        return [formatterFullDate stringFromDate:date];
    } else if (delta < 60 * 10) { // 10分钟内
        return @"刚刚";
    } else if (delta < 60 * 60) { // 1小时内
        return [NSString stringWithFormat:@"%d分钟前", (int)(delta / 60.0)];
    } else if (date.isToday) {
        return [NSString stringWithFormat:@"%d小时前", (int)(delta / 60.0 / 60.0)];
    } else if (date.isYesterday) {
        return [formatterYesterday stringFromDate:date];
    } else if (date.year == now.year) {
        return [formatterSameYear stringFromDate:date];
    } else {
        return [formatterFullDate stringFromDate:date];
    }
}


@end
