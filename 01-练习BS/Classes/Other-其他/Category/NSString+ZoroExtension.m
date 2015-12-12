//
//  NSString+ZoroExtension.m
//  01-练习BS
//
//  Created by grylls on 15/11/19.
//  Copyright © 2015年 grylls. All rights reserved.
//

#import "NSString+ZoroExtension.h"

@implementation NSString (ZoroExtension)

- (unsigned long long)fileSize
{
    //总大小
    unsigned long long size = 0 ;
    
    //文件管理者
    
    NSFileManager *mgr = [NSFileManager defaultManager];
    
    //是否为文件夹
    
    BOOL isDirectory = NO;
    
    //路径是否存在
    
    BOOL exists = [mgr fileExistsAtPath:self isDirectory:&isDirectory];
    
    if(!exists) return size;
    
    if (isDirectory) {
        //文件夹
        
        //获得文件夹的大小
        NSDirectoryEnumerator *enumertor = [mgr enumeratorAtPath:self];
        
        for (NSString *subpath in enumertor) {
            //全路径
            NSString *fullSubpath = [self stringByAppendingPathComponent:subpath];
            //累加文件大小
            
            size += [mgr attributesOfItemAtPath:fullSubpath error:nil].fileSize;
            
        }
        
    }else{ //文件
        size = [mgr attributesOfItemAtPath:self error:nil].fileSize;
    
    }
    
    return size;
}
@end
