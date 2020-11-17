#import <UIKit/UIKit.h>

@interface _UIBatteryView : UIView
  @property (assign,nonatomic) double chargePercent;
  @property (nonatomic) long long chargingState;
  @property (nonatomic) bool saverModeActive;
@end

%hook _UIBatteryView 
// TODO: _UIBatteryView bodyColor is outline

-(id)_batteryFillColor {
    if (self.chargingState == 1 || self.saverModeActive) {
        return %orig;
    } else {
        float battery = self.chargePercent;
        return [UIColor colorWithRed: (1 - battery) green: battery blue: 0.345098 alpha: 1.00];
    }
};

%end
