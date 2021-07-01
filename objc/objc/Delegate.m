//
//  Delegatem
//  objc
//
//  Created by Nikolai Sokol on 01072021
//

#import "Delegate.h"

@implementation Delegate

- (void)giveArray {
    NSArray *array = @[
        @"lorem ipsum dolor sit amet, consectetur adipiscing elit",
        @"maecenas mollis ipsum ac elit pellentesque, quis cursus diam finibus",
        @"integer facilisis erat faucibus neque pellentesque dignissim",
        @"suspendisse ex ante, tempus eget volutpat ut, fermentum a velit",
        @"fusce tellus magna, pharetra sit amet dictum sed, gravida sagittis tortor ",
        @"donec non massa consequat",
        @"mauris consequat dolor ac diam consectetur, eget ornare eros porta",
        @"suspendisse a purus feugiat, efficitur lorem eget, congue massa",
        @"sed ornare, tellus eget accumsan imperdiet, orci nibh placerat magna, ut convallis diam est in erat",
        @"sed elementum eleifend mi non sollicitudin",
        @"proin vulputate nec libero eget maximus",
        @"sed bibendum mauris tortor, sit amet fringilla nisi placerat id",
        @"nullam quis mi quam",
        @"sed nec feugiat dui",
        @"fusce ac orci mauris",
    ];
    
    [self.delegate arrayWasGiven:array];
}

@end
