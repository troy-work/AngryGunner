#import "CCNodeExtensions.h"

@implementation CCNode (Utility)

-(CGSize) scaledSize {
	CGSize cs = self.contentSize;
	return CGSizeMake(cs.width * self.scaleX, cs.height * self.scaleY);
}

@end