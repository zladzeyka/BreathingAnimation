//
//  BlurFadeTransition.swift
//  BreathAnimation
//
//  Created by Nadzeya Karaban on 12.05.20.
//  Copyright © 2020 Nadzeya Karaban. All rights reserved.
//

import Foundation
import SwiftUI

extension AnyTransition {
    static var blurFade: AnyTransition {
        get {
            AnyTransition.modifier(
                active: BlurFadeModifier(isActive: true),
                identity: BlurFadeModifier(isActive: false)
            )
        }
    }
}

struct BlurFadeModifier: ViewModifier {
    let isActive: Bool

    func body(content: Content) -> some View {
        content
            .scaleEffect(isActive ? 1.5 : 1) // lagging behind effect
            .blur(radius: isActive ? 8 : 0)
            .opacity(isActive ? 0 : 0.7)
    }
}
