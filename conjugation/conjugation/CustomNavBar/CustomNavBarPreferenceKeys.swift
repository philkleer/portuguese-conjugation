//
// CustomNavBarPreferenceKeys.swift
// conjugate-portuguese
//
// Created by Philipp Kleer on 29. October 2024
// Licensed by CC-BY-NC-SA 4.0
//
import Foundation
import SwiftUI

struct CustomNavBarTitlePreferenceKey: PreferenceKey {
    static var defaultValue: String { "Conjugador" }
    
    static func reduce(value: inout String, nextValue: () -> String) {
        value = nextValue()
    }
}

/// structure for the subtitle
///
///> Important not used so far
struct CustomNavBarSubtitlePreferenceKey: PreferenceKey {
    static var defaultValue: String? { nil }
    
    static func reduce(value: inout String?, nextValue: () -> String?) {
        value = nextValue()
                
    }
}

/// structure for the back button
struct CustomNavBarBackButtonHiddenPrefenceKey: PreferenceKey {
    static var defaultValue: Bool { false }
    
    static func reduce(value: inout Bool, nextValue: () -> Bool) {
        value = nextValue()
            
    }
}

/// structure for the options button
struct CustomNavBarOptionsHiddenPreferenceKey: PreferenceKey {
    static var defaultValue: Bool { false }
    
    static func reduce(value: inout Bool, nextValue: () -> Bool) {
        value = nextValue()
                
    }
}

/// structure for the reset button
struct CustomNavBarResetHiddenPreferenceKey: PreferenceKey {
    static var defaultValue: Bool { true }
    
    static func reduce(value: inout Bool, nextValue: () -> Bool) {
        value = nextValue()
    }
}

extension View {
    /// sets navigation bar title
    /// - Parameter title: `String`
    /// - Returns: modified `View`
    func customNavigationTitle(_ title: String) -> some View {
        preference(key: CustomNavBarTitlePreferenceKey.self, value: title)
    }
    
    /// sets navigation bar subtitle
    /// - Parameter subtitle: `String`
    /// - Returns: modified `View`
    func customNavigationSubtitle(_ subtitle: String?) -> some View {
        preference(key: CustomNavBarSubtitlePreferenceKey.self, value: subtitle)
    }
    
    /// sets navigation bar back button
    /// - Parameter hidden: `bool`
    /// - Returns: modified  `View`
    func customNavigationBackButtonHidden(_ hidden: Bool ) -> some View {
        preference(key: CustomNavBarBackButtonHiddenPrefenceKey.self, value: hidden)
    }
    
    /// sets navigation bar options button
    /// - Parameter hidden: `bool`
    /// - Returns: modified `View`
    func customNavigationOptionsHidden(_ hidden: Bool ) -> some View {
        preference(key: CustomNavBarOptionsHiddenPreferenceKey.self, value: hidden)
    }
    
    /// sets navigation bar reset button
    /// - Parameter hidden: `bool`
    /// - Returns: modified `View`
    func customNavigationResetHidden(_ hidden: Bool ) -> some View {
        preference(key: CustomNavBarResetHiddenPreferenceKey.self, value: hidden)
    }
    
    /// sets navigation bar all items.
    /// - Parameters:
    ///   - title: `String = ""`
    ///   - subtitle: `String? = nil`
    ///   - backButtonHidden: `Bool = false`
    ///   - optionsHidden: `Bool = false`
    ///   - resetButtonHidden: `Bool = false`
    /// - Returns: modified `View`
    func customNavbarItems(title: String = "", subtitle: String? = nil, backButtonHidden: Bool = false, optionsHidden: Bool = false, resetButtonHidden: Bool = false) -> some View {
        self
            .customNavigationTitle(title)
            .customNavigationSubtitle(subtitle)
            .customNavigationBackButtonHidden(backButtonHidden)
            .customNavigationOptionsHidden(optionsHidden)
            .customNavigationResetHidden(resetButtonHidden)
    }
}
 
