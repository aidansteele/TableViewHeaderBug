#import "AppDelegate.h"
#import "ViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;
{
  UIWindow *window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
  [window makeKeyAndVisible];
  [self setWindow:window];

  ViewController *controller = [[ViewController alloc] initWithStyle:UITableViewStylePlain];
  UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:controller];
  [window setRootViewController:nav];

  return YES;
}

@end
