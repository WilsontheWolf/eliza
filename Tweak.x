#import <UIKit/UIKit.h>

@interface _UIBatteryView : UIView
  @property (assign,nonatomic) double chargePercent;
@end

%hook _UIBatteryView 
// TODO: _UIBatteryView bodyColor is outline

-(id)_batteryFillColor {
    float battery = self.chargePercent;
    return [UIColor colorWithRed: (1 - battery) green: battery blue: 0 alpha: 1.00];
};

%end
