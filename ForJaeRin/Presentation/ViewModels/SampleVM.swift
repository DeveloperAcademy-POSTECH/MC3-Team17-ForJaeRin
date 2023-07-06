//
//  SampleVM.swift
//  ForJaeRin
//
//  Created by Yun Dongbeom on 2023/07/07.
//

import Foundation

class SampleVM: ObservableObject {
    @Published var sample = Sample()

    func greet() -> String {
        sample.greet()
    }
}
