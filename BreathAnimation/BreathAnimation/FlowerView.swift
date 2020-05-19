//
//  FlowerView.swift
//  BreathAnimation
//
//  Created by Nadzeya Karaban on 12.05.20.
//  Copyright © 2020 Nadzeya Karaban. All rights reserved.
//

import SwiftUI

struct FlowerView: View {
    @Binding var isMinimized: Bool
    @Binding var numberOfPetals: Double

    /// The duration of any animation performed to the flower.
    @Binding var animationDuration: Double

    /// The diameter of each petal.
    let circleDiameter: CGFloat = 80

    /// The color of each petal. It is recommended to also use opacity to create an overlap effect.
    var color = Color(UIColor.systemPink).opacity(0.6)

    /// This represents the absolute amount of rotation needed for each petal
    private var absolutePetalAngle: Double {
        return 360 / numberOfPetals
    }
    
    /**
     Calculates the opacity for the petal that is being added/removed.
     This is achieved by calculating the amount of travel in **degrees**
     that the petal needs to travel in order to be completely added
     to the flower and comparing it with the **nextAngle**.
     Afterwards converting this to a 0 to 1 scale.
     */
    private var opacityPercentage: Double {
        let numberOfPetals = self.numberOfPetals.rounded(.down)
        let nextAngle = 360 / (numberOfPetals + 1)
        let currentAbsoluteAngle = 360 / numberOfPetals

        let totalTravel = currentAbsoluteAngle - nextAngle
        let currentProgress = absolutePetalAngle - nextAngle
        let percentage = currentProgress / totalTravel

        return 1 - percentage
    }

    var body: some View {
        ZStack {
            ForEach(0...Int(numberOfPetals), id: \.self) {
                Circle()
                    .frame(width: self.circleDiameter, height: self.circleDiameter)
                    .foregroundColor(self.color)

                    // The color of the petal. It is recommended to also use opacity to create an overlap effect.
                    .foregroundColor(Color(UIColor.systemPink).opacity(0.6))


                    // rotate the petal around it's leading anchor to create the flower
                    .rotationEffect(.degrees(self.absolutePetalAngle * Double($0)),
                                    anchor: self.isMinimized ? .center : .leading)
                // animate opacity only to the petal being added/removed
                .opacity($0 == Int(self.numberOfPetals) ? self.opacityPercentage : 1)
            }
        }
        // Center the view along the center of the Flower
        .offset(x: isMinimized ? 0 : circleDiameter / 2)

        // create a frame around the flower,
        // helful for adding padding around the whole flower
        .frame(width: circleDiameter * 2, height: circleDiameter * 2)

        // smoothly animate any change to the Flower
        .rotationEffect(.degrees(isMinimized ? -90 : 0))
        .scaleEffect(isMinimized ? 0.3 : 1)

        // smoothly animate any change to the Flower
        .animation(.easeInOut(duration: animationDuration))

        // This modifiers are optional
        // The purpose of the code bellow is to align the orientation to perfectly match Apple's implementation
        .rotationEffect(.degrees(-60))
        .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
    }
}

struct FlowerView_Previews: PreviewProvider {
    static var previews: some View {

            FlowerView(isMinimized: .constant(false),
                       numberOfPetals: .constant(5),
                       animationDuration: .constant(4.2))
    }
}
