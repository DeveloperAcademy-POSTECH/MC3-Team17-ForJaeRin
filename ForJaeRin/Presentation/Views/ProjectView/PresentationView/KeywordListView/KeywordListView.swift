//
//  KeywordListView.swift
//  ForJaeRin
//
//  Created by Yun Dongbeom on 2023/07/12.
//

import SwiftUI

struct KeywordListView: View {
    @State var isSheetActive = false
    
    var body: some View {
        VStack {
            Text("KeywordListView View")
            Button {
                isSheetActive = true
            } label: {
                Text("Show Sheet")
            }

        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .border(.red, width: 2)
        .sheet(isPresented: $isSheetActive) {
            editKeywordListView()
                .frame(minWidth: 650, minHeight: 320)
        }
    }
}

extension KeywordListView {
    func editKeywordListView () -> some View {
        VStack {
            Text("Edit!")
        }
    }
}

struct KeywordListView_Previews: PreviewProvider {
    static var previews: some View {
        KeywordListView()
    }
}
