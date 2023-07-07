//
//  ContentView.swift
//  ForJaeRin
//
//  Created by Yun Dongbeom on 2023/07/06.
//
//rinsu 와따감

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("rin 수정")
            Image("test_landscape")
                .resizable()
            SampleView()
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
