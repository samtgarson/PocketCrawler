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
        let (width, height) = frame
        
        return ZStack {
            if canMove {
                door
            }
        }.frame(width: width, height: height, alignment: .center).fixedSize()
    }
    
    var door: some View {
        let (width, height) = doorFrame
        
        return Rectangle()
            .fill(.white)
            .frame(width: width, height: height)
            .onTapGesture(perform: onTap)
    }
    
    var doorFrame: (CGFloat, CGFloat) {
        switch dir {
        case .left, .right:
            return (.infinity, 40)
        case .up, .down:
            return (40, .infinity)
        }
    }
    
    var frame: (CGFloat, CGFloat) {
        switch dir {
        case .left, .right:
            return (THICKNESS, .infinity)
        case .up, .down:
            return (.infinity, THICKNESS)
        }
    }
}

struct Door_Previews: PreviewProvider {
    static var previews: some View {
        Wall(dir: .up, canMove: true) { debugPrint("Tapped!") }
    }
}
