import UIKit
import OneSignal

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions:
[UIApplication.LaunchOptionsKey: Any]?) -> Bool {
  // Remove this method to stop OneSignal Debugging
  OneSignal.setLogLevel(.LL_VERBOSE, visualLevel: .LL_NONE)
  
  // OneSignal initialization
  OneSignal.initWithLaunchOptions(launchOptions)
  OneSignal.setAppId("5ce27e52-c16d-4464-aa50-d9f493c9bd6a")
  
  // promptForPushNotifications will show the native iOS notification permission prompt.
  // We recommend removing the following code and instead using an In-App Message to prompt for notification permission (See step 8)
  OneSignal.promptForPushNotifications(userResponse: { accepted in
    print("User accepted notifications: \(accepted)")
  })
  
  // Set your customer userId
  // OneSignal.setExternalUserId("userId")
  
  

   return true
}
  
// Remaining contents of your AppDelegate Class...
}
