//
// CustomNavBarContainerView.swift
// conjugate-portuguese
//
// Created by Philipp Kleer on 29. October 2024
// Licensed by CC-BY-NC-SA 4.0
//
import SwiftUI

/// custom navigation bar container
///
/// The structure delivers a customized navigation bar container view that is used in ``CustomNavLink`` and ``CustomNavView``.
///
struct CustomNavBarContainerView<Content: View>: View {
    let content: Content
    @State private var title: String = ""
    @State private var subtitle: String? = nil
    @State private var showBackButton: Bool = true
    @State private var showOptionsButton: Bool = true
    @State private var showResetButton: Bool = true
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
        
    }
    
     
    var body: some View {
        VStack(spacing:0) {
            CustomNavBarView(title: title, subtitle: subtitle, showBackButton: showBackButton, showOptionsButton: showOptionsButton, showResetButton: showResetButton);            content
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .onPreferenceChange(CustomNavBarTitlePreferenceKey.self, perform: {
            value in self.title = value
        }
        )
        .onPreferenceChange(CustomNavBarSubtitlePreferenceKey.self, perform: {
            value in self.subtitle = value
        }
        )
        .onPreferenceChange(CustomNavBarBackButtonHiddenPrefenceKey.self, perform: {
            value in self.showBackButton = !value
        }
        )
        .onPreferenceChange(CustomNavBarOptionsHiddenPreferenceKey.self, perform: {
            value in self.showOptionsButton = !value
        }
        )
        .onPreferenceChange(CustomNavBarResetHiddenPreferenceKey.self, perform: {
            value in self.showResetButton = !value
        }
        )
    }
}

struct CustomNavBarContainerView_Previews: PreviewProvider{
    static var previews: some View{
        CustomNavBarContainerView {
            Text("Color")
                .customNavigationOptionsHidden(false)
                .customNavigationResetHidden(true)
                .customNavigationBackButtonHidden(true)
                .customNavigationTitle("Opções")
        }
    }
}
