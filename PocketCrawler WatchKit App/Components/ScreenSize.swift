//
//  ScreenSize.swift
//  PocketCrawler WatchKit Extension
//
//  Created by Sam Garson on 26/12/2021.
//

import SwiftUI

struct ScreenSize<Content : View>: View {
    internal init(@ViewBuilder content: @escaping (CGSize) -> Content) {
        self.content = content
    }
    
    var content: (CGSize) -> Content
    
    var body: some View {
        GeometryReader { geo in content(geo.size) }
    }
}

struct ScreenSize_Previews: PreviewProvider {
    static var previews: some View {
        ScreenSize { size in
            RoundedRectangle(cornerRadius: 5)
                .fill(.red)
                .frame(width: size.width / 2, height: size.height / 2)
        }
    }
}
