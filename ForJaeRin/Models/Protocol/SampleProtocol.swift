//
//  SampleProtocol.swift
//  ForJaeRin
//
//  Created by Yun Dongbeom on 2023/07/07.
//

import Foundation

protocol Sample {
    var name: String { get set }
    var team: String { get set }

    func greet() -> String
}
