//
//  FABMenu.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 04/10/2024.
//

import SwiftUI

struct FABMenu: View {
    var buttons: [(image: Image, action: () -> Void)]
    var direction = Angle(degrees: 315)
    var range = Angle(degrees: 90)
    
    @State private var isExpanded = false

    var body: some View {
        ZStack {
            SymbolButton(image: isExpanded ? Image.closeFloatIcon : Image.addIcon,
                         action: {
                withAnimation {
                    isExpanded.toggle()
                }
            })
            
            ForEach(0..<buttons.count, id: \.self) { index in
                if isExpanded {
                    if #available(iOS 17.0, *) {
                        SymbolButton(image: buttons[index].image, action: buttons[index].action)
                            .offset(computeOffset(index: index, count: buttons.count))
                            .animation(.default, value: isExpanded)
                            .animation(.interpolatingSpring(Spring(response: 0.4, dampingRatio: 0.5)), value: isExpanded)
                    } else {
                        SymbolButton(image: buttons[index].image, action: buttons[index].action)
                            .offset(computeOffset(index: index, count: buttons.count))
                            .animation(.default, value: isExpanded)
                    }
                }
            }
        }
    }

    func computeOffset(index: Int, count: Int) -> CGSize {
        let distance: CGFloat = 80
        let buttonAngle = range.radians / Double(count - 1)
        let ourAngle = buttonAngle * Double(index)
        let finalAngle = direction - (range / 2) + Angle(radians: ourAngle)
        
        let width = cos(finalAngle.radians - .pi / 2) * distance
        let height = sin(finalAngle.radians - .pi / 2) * distance
        
        return CGSize(width: width, height: height)
    }
}

struct ContentView: View {
    var body: some View {
        FABMenu(buttons: [
            (Image("addIcon"), { print("Add button tapped") }),
            (Image("videoIcon"), { print("Video button tapped") }),
            (Image("mapIcon"), { print("Map button tapped") }),
            (Image("phoneIcon"), { print("Phone button tapped") })
        ])
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
