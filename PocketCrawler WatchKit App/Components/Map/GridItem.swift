//
//  GridItem.swift
//  GridItem
//
//  Created by Sam Garson on 15/08/2021.
//

import SwiftUI

struct GridItem: View {
    let width: CGFloat
    let height: CGFloat
    let room: Room?
    var current: Bool = false
    
    var body: some View {
        ZStack {
            Rectangle().fill(.black)
            if !empty {
                RoundedRectangle(cornerRadius: 2)
                    .opacity(current ? 1 : 0.2)
                    .padding(2)
            }
        }
        .frame(width: width, height: height)
    }
    
    var empty: Bool {
        room == nil
    }
}

struct GridItem_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            GridItem(width: 30, height: 30, room: Room(position: Coordinate(0, 0)))
            GridItem(width: 30, height: 30, room: nil)
            GridItem(width: 30, height: 30, room: Room(position: Coordinate(0, 0)), current: true)
        }
    }
}
