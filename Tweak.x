#import <UIKit/UIKit.h>

@interface NSUserDefaults (Tweak_Category)
- (id)objectForKey:(NSString *)key inDomain:(NSString *)domain;
- (void)setObject:(id)value forKey:(NSString *)key inDomain:(NSString *)domain;
@end

static NSString * nsDomainString = @"com.wilsonthewolf.elizaprefrences";
static NSString * nsNotificationString = @"com.wilsonthewolf.eliza/preferences.changed";
static BOOL enabled;
static BOOL lpm;
static BOOL charging; 

static void notificationCallback(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo) {
	NSNumber * enabledValue = (NSNumber *)[[NSUserDefaults standardUserDefaults] objectForKey:@"enabled" inDomain:nsDomainString];
	enabled = (enabledValue)? [enabledValue boolValue] : YES;
  NSNumber * lpmValue = (NSNumber *)[[NSUserDefaults standardUserDefaults] objectForKey:@"lpm" inDomain:nsDomainString];
  lpm = (lpmValue)? [lpmValue boolValue] : YES;
  NSNumber * chargingValue = (NSNumber *)[[NSUserDefaults standardUserDefaults] objectForKey:@"charging" inDomain:nsDomainString];
  charging = (chargingValue)? [chargingValue boolValue] : YES;
}

%ctor {
	// Set variables on start up
	notificationCallback(NULL, NULL, NULL, NULL, NULL);

	// Register for 'PostNotification' notifications
	CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, notificationCallback, (CFStringRef)nsNotificationString, NULL, CFNotificationSuspensionBehaviorCoalesce);
}

@interface _UIBatteryView : UIView
  @property (assign,nonatomic) double chargePercent;
  @property (assign,nonatomic) bool saverModeActive;
  @property (assign,nonatomic) long long chargingState;
  - (void) _updateBatteryFillColor;
@end

@interface BCUIChargeRing : UIView
  @property (assign,nonatomic) NSInteger percentCharge;
  @property (assign,nonatomic) BOOL charging;
  @property (assign,nonatomic) BOOL lowPowerModeEnabled;
@end

@interface BCUIRingView : UIView
  @property (nonatomic, retain) BCUIChargeRing *superview;
@end

%hook _UIBatteryView 

-(id)_batteryFillColor {
    if(!enabled) return %orig;
    if(!lpm && self.saverModeActive) return %orig;
    if(!charging && self.chargingState == 1) return %orig;
    float battery = self.chargePercent;
    return [UIColor colorWithHue: (battery * .333) saturation: 1 brightness: 1 alpha: 1.00];
    
};

%end

%hook BCUIRingView

-(void)setStrokeColor:(id)arg1 {
  if(!enabled) return %orig;

  float alpha = [arg1 alpha];
  if(alpha != 1) return %orig;
  
  BCUIChargeRing *ring = (BCUIChargeRing *)self.superview;

  if(!lpm && [ring valueForKey:@"lowPowerModeEnabled"]) return %orig;
  if(!charging && [ring valueForKey:@"charging"]) return %orig;
  float battery = ring.percentCharge / 100.0;

  UIColor *color = [UIColor colorWithHue: (battery * .333) saturation: 1 brightness: 1 alpha: 1.00];

  %orig(color);
}

%end
