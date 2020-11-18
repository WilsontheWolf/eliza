#import <UIKit/UIKit.h>

@interface _UIBatteryView : UIView
  @property (assign,nonatomic) double chargePercent;
  @property (assign,nonatomic) bool saverModeActive;
  @property (assign,nonatomic) long long chargingState;
  - (void) _updateBatteryFillColor;
@end

%hook _UIBatteryView 
// TODO: _UIBatteryView bodyColor is outline

-(id)_batteryFillColor {
    NSDictionary *settings = [[NSUserDefaults standardUserDefaults]
    persistentDomainForName:@"com.wilsonthewolf.elizaprefrences"];
    id enabled = [settings valueForKey:@"enabled"];
    id lpm = [settings valueForKey:@"lpm"];
    id charging = [settings valueForKey:@"charging"];
    if([enabled isEqual:@0]) return %orig;
    if([lpm isEqual:@0] && self.saverModeActive) return %orig;
    if([charging isEqual:@0] && self.chargingState == 1) return %orig;
    float battery = self.chargePercent;
    return [UIColor colorWithHue: (battery * .333) saturation: 1 brightness: 1 alpha: 1.00];
    
};

%end
