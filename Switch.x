#import "FSSwitchDataSource.h"
#import "FSSwitchPanel.h"
#import "notify.h"

#define batteryPercentPlist @"/var/mobile/Library/Preferences/com.apple.springboard.plist"
#define kBatteryPercentKey @"SBShowBatteryPercentage"

@interface BatteryPercentFSSwitch : NSObject <FSSwitchDataSource>
@end

@implementation BatteryPercentFSSwitch

- (FSSwitchState)stateForSwitchIdentifier:(NSString *)switchIdentifier
{
	NSDictionary *batteryPercentSettings = [NSDictionary dictionaryWithContentsOfFile:batteryPercentPlist];
	return [[batteryPercentSettings objectForKey:@"SBShowBatteryPercentage"] boolValue] ? FSSwitchStateOn : FSSwitchStateOff;
}

-(void)applyState:(FSSwitchState)newState forSwitchIdentifier:(NSString *)switchIdentifier {
	NSMutableDictionary *batteryPercentSettings = [NSMutableDictionary dictionaryWithContentsOfFile:batteryPercentPlist];

	if(newState == FSSwitchStateIndeterminate) {
		return;
	} else if(newState == FSSwitchStateOn) {
		[batteryPercentSettings setObject:[NSNumber numberWithBool:YES] forKey:@"SBShowBatteryPercentage"];
	} else if(newState == FSSwitchStateOff) {
		[batteryPercentSettings setObject:[NSNumber numberWithBool:NO] forKey:@"SBShowBatteryPercentage"]; 
	}
	[batteryPercentSettings writeToFile:batteryPercentPlist atomically:YES];
	notify_post("com.apple.springboard-prefsChanged");
}

-(NSString *)titleForSwitchIdentifier:(NSString *)switchIdentifier {
	return @"Battery Percentage";
}

@end