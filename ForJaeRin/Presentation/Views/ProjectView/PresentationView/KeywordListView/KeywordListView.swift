//
//  KeywordListView.swift
//  ForJaeRin
//
//  Created by Yun Dongbeom on 2023/07/12.
//

import SwiftUI

struct KeywordListView: View {
    var body: some View {
        VStack {
            Text("KeywordListView View")
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .border(.red, width: 2)
    }
}

struct KeywordListView_Previews: PreviewProvider {
    static var previews: some View {
        KeywordListView()
    }
}
