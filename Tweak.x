#import <UIKit/UIKit.h>
#include <stdlib.h>

@interface _UIBatteryView : UIView
  @property (assign,nonatomic) double chargePercent;
@end

%hook _UIBatteryView
// TODO: _UIBatteryView bodyColor is outline

-(id)_batteryFillColor {
    float battery = self.chargePercent;
    int batteryPercent = battery * 100;
    switch (batteryPercent) {
      case 0 ... 10:
      for (;;)
      {
        int randNum = arc4random_uniform(100);
        float randBatt = randNum / 100;
      return [UIColor colorWithRed: (1 - randBatt) green: battery blue: 0 alpha: 1.00];
  }
          break;
        default:
            return [UIColor colorWithRed: (1 - battery) green: battery blue: 0 alpha: 1.00];
    }

};

%end
