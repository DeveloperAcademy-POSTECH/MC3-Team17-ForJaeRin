//
//  VoiceVisualizationView.swift
//  ForJaeRin
//
//  Created by Yun Dongbeom on 2023/07/12.
//

import SwiftUI

struct VoiceVisualizationView: View {
    var body: some View {
        VStack {
            Text("Voice Visualization View")
        }
        .frame(maxWidth: .infinity, maxHeight: 200)
        .border(.red, width: 2)
    }
}

struct VoiceVisualizationView_Previews: PreviewProvider {
    static var previews: some View {
        VoiceVisualizationView()
    }
}
