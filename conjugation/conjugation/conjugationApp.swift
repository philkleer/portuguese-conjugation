import SwiftUI

@main
struct conjugationApp: App {

    var body: some Scene {
        WindowGroup {
            mainView()
                .environmentObject(UserSettings())  // assign environment
        }
    }
}
