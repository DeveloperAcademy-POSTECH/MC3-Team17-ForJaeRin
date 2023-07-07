//
//  SampleView.swift
//  ForJaeRin
//
//  Created by Yun Dongbeom on 2023/07/07.
//

import SwiftUI

struct SampleView: View {
    var viewModel = SampleVM()

    var body: some View {
        greetView()
    }
}

extension SampleView {
    func greetView() -> some View {
        Text(viewModel.greet())
    }
}

struct SampleView_Previews: PreviewProvider {
    static var previews: some View {
        SampleView()
    }
}
