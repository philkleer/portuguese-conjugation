//
// CustomNavView.swift
// conjugate-portuguese
//
// Created by Philipp Kleer on 29. October 2024
// Licensed by CC-BY-NC-SA 4.0
//
import SwiftUI

/// custom navigation view that inherits ``CustomNavBarContainerView``
struct CustomNavView<Content: View>: View {
    
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
        
    }
    
    var body: some View {
        NavigationView{
            CustomNavBarContainerView{
                content
            }
            .navigationBarHidden(true)
        }
        .navigationViewStyle(StackNavigationViewStyle())
        
    }
}   

struct CustomNavView_Previews: PreviewProvider{
    static var previews: some View{
        CustomNavView {
            Color.red.ignoresSafeArea()
        }
    }
}

extension UINavigationController {
     open override func viewDidLoad() {
        super.viewDidLoad()
        
        interactivePopGestureRecognizer?.delegate = nil
    }
}
