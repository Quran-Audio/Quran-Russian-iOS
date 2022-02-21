//
//  Quran_Russian_iOSApp.swift
//  Shared
//
//  Created by AbuTalha on 22/02/2022.
//

import SwiftUI
import QuranAudioPlayerKit
import StoreKit

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        UIApplication.shared.beginReceivingRemoteControlEvents()
        print("App Delegate Called")
        return true
    }
}

@main
struct QuranTamilApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    init() {
        PushService.shared.askForPushPermission()
        QuranAudioPlayerKit.registerFonts()
    }
    
    var body: some Scene {
        WindowGroup {
            QuranAudioPlayerKit()
                .onAppear(perform: { requestReviewIfNeeded() })
        }
    }
    
    private func requestReviewIfNeeded() {
        let shoudlRequest = RatingService.shared.shouldRequest()
        if shoudlRequest == true,
           let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            SKStoreReviewController.requestReview(in: scene)
        }
    }
}
