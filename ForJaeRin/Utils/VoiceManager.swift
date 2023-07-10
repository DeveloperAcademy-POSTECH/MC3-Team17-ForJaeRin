//
//  VoiceManager.swift
//  ForJaeRin
//
//  Created by Yun Dongbeom on 2023/07/10.
//

import Foundation
import AVFoundation

class VoiceManager {
    
    static var shared = VoiceManager()

    private init() {}

    private var audioRecorder: AVAudioRecorder?
    private var audioPlayer : AVAudioPlayer?
    var currentPath: URL?
    
    @Published var isRecording : Bool = false
    @Published var countSec = 0
    @Published var timerCount : Timer?
    @Published var timer : String = "0:00" {
        didSet {
            print(timer)
        }
    }
    
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
    
    func startRecording() {
        let dirPath = AppFileManager.shared.directoryPath
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd'at'HH:mm:ss"
        
        let fileName = dirPath.appendingPathComponent(
            "\(dateFormatter.string(from: Date())).m4a",
            conformingTo: .mpeg4Audio)
        
        currentPath = fileName
        
        // recoder 세팅 (내부 녹음 품질을 정함)
        let recorderSettings: [String: Any] = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
                
        do {
            // url을 통해서 기록
            audioRecorder = try AVAudioRecorder(url: fileName, settings: recorderSettings)
            // 오디오 파일 생성 및 준비
            audioRecorder?.prepareToRecord()
            // 해당 오디오파일에 녹음시작
            audioRecorder?.record()
            isRecording = true
            
//            // 타이머 on
//            timerCount = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
//                self.countSec += 1
//                self.timer = self.covertSecToMinAndHour(seconds: self.countSec)
//            })
            
        } catch {
            print("Failed to Setup the Recording")
        }
    }
    
    func stopRecording(index: Int) {
        // 녹음 중지
        audioRecorder?.stop()
        isRecording = false
        
        // timer init
//        self.countSec = 0
//        timerCount!.invalidate()
    }
    
    func playRecording() {
        let filePath = currentPath!
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: filePath)
            audioPlayer?.play()
        } catch {
            print("faild to play file")
        }
    }
    
    private func covertSecToMinAndHour(seconds : Int) -> String {
        
        let (_,minute,second) = (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
        let _second : String = second < 10 ? "0\(second)" : "\(second)"
        return "\(minute):\(_second)"
        
    }
}
