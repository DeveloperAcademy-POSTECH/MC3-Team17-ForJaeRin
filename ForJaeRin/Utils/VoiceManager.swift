//
//  VoiceManager.swift
//  ForJaeRin
//
//  Created by Yun Dongbeom on 2023/07/10.
//

import Foundation
import AVFoundation

class VoiceManager {
    static func requestMicrophonePermission() {
        switch AVCaptureDevice.authorizationStatus(for: .audio) {
        case .authorized:
            // Microphone access is already authorized.
            print("Microphone access authorized")
        case .notDetermined:
            // Request microphone access.
            AVCaptureDevice.requestAccess(for: .audio) { granted in
                if granted {
                    print("Microphone access granted")
                } else {
                    print("Microphone access denied")
                }
            }
        case .denied, .restricted:
            // Microphone access is denied or restricted.
            print("Microphone access denied or restricted")
        @unknown default:
            break
        }
    }
}
