#include "EPWRootListController.h"
#include <objc/runtime.h> 

@interface _CDBatterySaver
- (id)batterySaver;
- (BOOL)setPowerMode:(long long)arg1 error:(id *)arg2; 
@end

@implementation EPWRootListController

- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [self loadSpecifiersFromPlistName:@"Root" target:self];
	}

	return _specifiers;
}

-(void)openGithub {
    [[UIApplication sharedApplication]
    openURL:[NSURL URLWithString:@"https://github.com/WilsontheWolf/eliza"]
    options:@{}
    completionHandler:nil];
}

-(void)applyChanges {
    // This is kinda hacky but I toggle LPM to the current value so iOS updates 
    // the button color
    bool current = [[NSProcessInfo processInfo] isLowPowerModeEnabled];
    [[objc_getClass("_CDBatterySaver") batterySaver] 
    setPowerMode:!current error:nil];
    [[objc_getClass("_CDBatterySaver") batterySaver] 
    setPowerMode:current error:nil];
}

@end
