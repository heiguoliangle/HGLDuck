//
//  TestDuck.h
//  HGLDuckTest
//
//  Created by heiguoliangle on 2017/12/21.
//  Copyright © 2017年 heiguoliangle. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol HGLTestDuck <NSObject>

-(void)run:(NSString *)name;
@end


@interface TestDuck : NSObject <HGLTestDuck>

@end

@implementation TestDuck
-(void)run:(NSString *)name{
      NSLog(@"%@ run",name);
}

//-(void)run:(NSString *)name{
//    NSLog(@"%@ run",name);
//}

@end

