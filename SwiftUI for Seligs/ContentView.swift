//
//  ContentView.swift
//  SwiftUI for Seligs
//
//  Created by Mustafa Yusuf on 18/11/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color.gray
        }
        .overlay(alignment: .bottom) {
            Image("meme.first")
                .resizable()
                .scaledToFill()
                .frame(width: 256, height: 256)
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
