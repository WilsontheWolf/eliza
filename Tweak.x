#import <UIKit/UIKit.h>

@interface _UIBatteryView : UIView
  @property (assign,nonatomic) double chargePercent;
  @property (assign,nonatomic) long long chargingState;
  @property (assign,nonatomic) bool saverModeActive;
@end

%hook _UIBatteryView 
// TODO: _UIBatteryView bodyColor is outline

-(id)_batteryFillColor {
    if (self.chargingState == 1 || self.saverModeActive) {
        return %orig;
    } else {
        CGFloat percent = self.chargePercent * 0.448366;
        if (percent <= 0.057516) {
            return [UIColor colorWithHue: (0.942484 + percent) saturation: 1.00 brightness: 1.00 alpha: 1.00];
        } else {
            return [UIColor colorWithHue: (percent - 0.057516) saturation: 1.00 brightness: 1.00 alpha: 1.00];
        }
    }
};

%end
