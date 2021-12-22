//
//  BossRoom.swift
//  PocketCrawler WatchKit Extension
//
//  Created by Sam Garson on 22/12/2021.
//

import SwiftUI

struct BossRoom: View {
    var nextFloor: () -> Void
    
    var body: some View {
        VStack(alignment: .center) {
            Spacer()
            HStack {
                Spacer()
                Button("Next floor", action: nextFloor).foregroundColor(.black).background(.red).frame(width: 120).cornerRadius(5)
                Spacer()
            }
            Spacer()
        }
            .background(RoundedRectangle(cornerRadius: 15))
    }
}

struct BossRoom_Previews: PreviewProvider {
    static var previews: some View {
        BossRoom { debugPrint("next floor") }
    }
}
