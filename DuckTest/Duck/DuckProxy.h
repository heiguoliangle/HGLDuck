

#import <Foundation/Foundation.h>


@protocol HGLDuckProxy <NSObject>

- (void) dependencyObject:(id)object forProtocol:(Protocol *)protocol;

@end

extern id HGLDuckProxyCreat(void);
