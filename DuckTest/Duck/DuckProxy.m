
#import "DuckProxy.h"

@import ObjectiveC;

@interface DuckProxy : NSProxy <HGLDuckProxy>

@property(nonatomic,strong)NSMutableDictionary * implementtations;

- (id)init;

@end

@implementation DuckProxy

-(id)init{
    
    self.implementtations = [NSMutableDictionary dictionary];
    return self;
}

-(void)dependencyObject:(id)object forProtocol:(Protocol *)protocol{
     NSAssert([object conformsToProtocol:protocol], @"object %@ does not conform to protocol: %@", object, protocol);
    self.implementtations[NSStringFromProtocol(protocol)] = object;
}

-(BOOL)conformsToProtocol:(Protocol *)aProtocol{
    for (NSString * protocolName in self.implementtations.allKeys) {
        if (protocol_isEqual(aProtocol, NSProtocolFromString(protocolName))) {
            return YES;
        }
    }
    return [super conformsToProtocol:aProtocol];
}

-(NSMethodSignature *)methodSignatureForSelector:(SEL)sel{
    for (id object in self.implementtations.allValues) {
        if ([object respondsToSelector:sel]) {
            
            return [object methodSignatureForSelector:sel];
        }
    }
    return [super methodSignatureForSelector:sel];
}

-(void)forwardInvocation:(NSInvocation *)invocation{
    for (id object in self.implementtations.allValues) {
        if ([object respondsToSelector:invocation.selector]) {
            [object methodSignatureForSelector:invocation.selector];
            [invocation invokeWithTarget:object];
            return ;
        }
    }
    return [super forwardInvocation:invocation];
}

@end

id HGLDuckProxyCreat(){
    return [[DuckProxy alloc]init];
}
