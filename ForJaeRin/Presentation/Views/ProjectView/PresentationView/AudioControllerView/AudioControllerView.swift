//
//  AudioControllerView.swift
//  ForJaeRin
//
//  Created by Yun Dongbeom on 2023/07/12.
//

import SwiftUI

struct AudioControllerView: View {
    var body: some View {
        HStack {
            HStack {
                Button {
                    print("Play")
                } label: {
                    Text("Play")
                }
                Button {
                    print("Pause")
                } label: {
                    Text("Pause")
                }
                Button {
                    print("stop")
                } label: {
                    Text("stop")
                }
            }
            .border(.blue)
        }
        .frame(maxWidth: .infinity, maxHeight: 64, alignment: .center)
        .border(.blue)
    }
}

struct AudioControllerView_Previews: PreviewProvider {
    static var previews: some View {
        AudioControllerView()
    }
}
