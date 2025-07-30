
import UIKit
import UserNotifications

class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        // 1. Push통신 허가 받기
        //TODO: Apple Developer Program 요금 지불 후 APNs 설정 필요
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if let error = error {
                print("Push notification authorization error: \(error.localizedDescription)")
                return
            }
            
            guard granted else {
                print("Push notification permission denied.")
                return
            }
            
            print("Push notification permission granted.")
            
            // 2. APNs 디바이스 등록
            DispatchQueue.main.async {
                application.registerForRemoteNotifications()
            }
        }
        
        UNUserNotificationCenter.current().delegate = self
        
        return true
    }
    
    // 3. 디바이스 토큰 취득
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let tokenParts = deviceToken.map { data in String(format: "%02.2hhx", data) }
        let token = tokenParts.joined()
        print("Device Token: \(token)")
        // TODO: 여기서 취득한 토큰을 FCM으로 등록
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Failed to register for remote notifications: \(error.localizedDescription)")
    }
    
    // 앱이 포그라운드에서 알림을 받았을때 처리
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        // 배너+사운드+뱃지로 알람을 표시
        completionHandler([.banner, .sound, .badge])
    }
}
