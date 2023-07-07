//
//  SampleModel.swift
//  ForJaeRin
//
//  Created by Yun Dongbeom on 2023/07/07.
//

import Foundation

protocol Samplable {
    var name: String { get set }
    var team: String { get set }

    func greet() -> String
}

struct Sample: Samplable {
    var name: String
    var team: String

    func greet() -> String {
        "Hello, \(name) welcome to our \(team)"
    }
}

extension Sample {
    init() {
        self.init(name: "Coffee", team: "Kkojangro")
    }
}
