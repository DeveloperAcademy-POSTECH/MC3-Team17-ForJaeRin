//
//  ContentView.swift
//  ForJaeRin
//
//  Created by Yun Dongbeom on 2023/07/06.
//

import SwiftUI

struct ContentView: View {
    @State private var path = NavigationPath()
    
    var body: some View {
        NavigationStack {
                SplitLayoutView()
            }
        }
    }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
