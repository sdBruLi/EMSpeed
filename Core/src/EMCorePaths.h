//
//  EMCorePaths.h
//  CoreDemo
//
//  Created by Mac mini 2012 on 15-3-4.
//  Copyright (c) 2015年 Mac mini 2012. All rights reserved.
//


#ifdef __cplusplus
extern "C" {
#endif
    
    /**
     *  根据bundle名+相对路径
     *
     *  @param bundle       bundle名称
     *  @param relativePath 相对路径
     *
     *  @return bundle名+相对路径
     */
    NSString* EMPathForMainBundleResource(NSString* relativePath);
    
    
    /**
     *  根据bundle名+相对路径
     *
     *  @param bundle       bundle名称
     *  @param relativePath 相对路径
     *
     *  @return bundle名+相对路径
     */
    NSString* EMPathForBundleResource(NSBundle* bundle, NSString* relativePath);
    
    
    /**
     *  Documents文件夹下文件绝对路径
     *
     *  @param relativePath 相对路径
     *
     *  @return Documents文件夹路径 + 相对路径
     */
    NSString* EMPathForDocumentsResource(NSString* relativePath);
    
    
    /**
     *  Library文件夹下文件绝对路径
     *
     *  @param relativePath 相对路径
     *
     *  @return Library文件夹路径 + 相对路径
     */
    NSString* EMPathForLibraryResource(NSString* relativePath);
    
    
    /**
     *  Caches文件夹下文件绝对路径
     *
     *  @param relativePath 相对路径
     *
     *  @return Caches文件夹路径 + 相对路径
     */
    NSString* EMPathForCachesResource(NSString* relativePath);
    
    
#ifdef __cplusplus
}
#endif