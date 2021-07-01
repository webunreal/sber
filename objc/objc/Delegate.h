//
//  Delegate.h
//  objc
//
//  Created by Nikolai Sokol on 01.07.2021.
//

#import <Foundation/Foundation.h>
#import "DelegateProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface Delegate : NSObject

@property (nonatomic, weak) id <DelegateProtocol> delegate;

- (void)giveArray;

@end

NS_ASSUME_NONNULL_END
