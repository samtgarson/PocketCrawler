//
//  Wall.swift
//  PocketCrawler WatchKit Extension
//
//  Created by Sam Garson on 19/12/2021.
//

import SwiftUI

struct Wall: View {
    var dir: Direction
    var canMove: Bool
    var onTap: () -> Void
    
    let THICKNESS: CGFloat = 5
    
    var body: some View {
        switch dir {
        case .left, .right:
            VStack {
                Spacer()
                if canMove { door }
                Spacer()
            }.frame(width: THICKNESS)
        case .up, .down:
            HStack {
                Spacer()
                if canMove { door }
                Spacer()
            }.frame(height: THICKNESS)
        }
    }
    
    var door: some View {
        let (width, height) = doorFrame
        
        return Rectangle()
            .fill(.white)
            .frame(width: width, height: height)
            .onTapGesture(perform: onTap)
    }
    
    var doorFrame: (CGFloat?, CGFloat?) {
        switch dir {
        case .left, .right:
            return (nil, 40)
        case .up, .down:
            return (40, nil)
        }
    }
}

struct Door_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Wall(dir: .up, canMove: true) { debugPrint("Tapped!") }
            Wall(dir: .left, canMove: true) { debugPrint("Tapped!") }
            Wall(dir: .up, canMove: false) { debugPrint("Tapped!") }
            Wall(dir: .left, canMove: false) { debugPrint("Tapped!") }
        }.background(.gray)
    }
}
