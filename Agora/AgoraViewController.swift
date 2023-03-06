//
//  AgoraViewController.swift
//  Agora
//
//  Created by Nyi Ye Han on 04/03/2023.
//

import Foundation
import AgoraRtcKit
import SwiftUI

class AgoraViewController : UIViewController{
    
    var agoraKit: AgoraRtcEngineKit?
    var agoraDelegate: AgoraRtcEngineDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 2
        view.backgroundColor = .systemPink
        
        // 3
        view.addSubview(label)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            label.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
        ])
        initializeAgoraEngine()
        setupVideo()
        joinChannel()
    }
    
    private var label : UIView = {
        let label = UIView()
        label.translatesAutoresizingMaskIntoConstraints = false
//        label.font = UIFont.preferredFont(forTextStyle: .title1)
//        label.text = "Hello UI Kit"
//        label.textAlignment = .center
        
        return label
    }()
    func setupVideo() {
        if let agoraKit = agoraKit{
            agoraKit.enableVideo()
            agoraKit.enableAudio()
            let videoCanvas = AgoraRtcVideoCanvas()
            
            videoCanvas.view = view
            
            agoraKit.setupLocalVideo(videoCanvas)
        }
       
    }
//    func setupLocalVideo() {
//        let videoCanvas = AgoraRtcVideoCanvas()
//        videoCanvas.uid = 0
//        videoCanvas.view = localVideo
//        videoCanvas.renderMode = .hidden
//        agoraKit?.setupLocalVideo(videoCanvas)
//    }
    
    func initializeAgoraEngine() {
        agoraKit = AgoraRtcEngineKit.sharedEngine(withAppId: Utils.APP_ID, delegate: agoraDelegate)
    }
    
    func joinChannel() {
        agoraKit?.joinChannel(byToken: Utils.TOKEN, channelId: Utils.CHANNEL_ID, info: nil, uid: 0, joinSuccess: {(channel, uid, elapsed) in
            print(channel)
            print(uid)
            print(elapsed)
        })
    }
    
    func leaveChannel() {
        agoraKit?.leaveChannel(nil)
    }
    func destroyInstance() {
        AgoraRtcEngineKit.destroy()
    }
    
    func didClickMuteButton(isMuted: Bool) {
        isMuted ? (agoraKit?.muteLocalAudioStream(true)) : (agoraKit?.muteLocalAudioStream(false))
      }
    
    override func viewWillDisappear(_ animated: Bool) {
        leaveChannel()
        destroyInstance()
    }
    
}

struct ContentView1: View {
    
    @State private var showCall: Bool = false
    
    
    var body: some View {
        
        Button(action: {
            showCall = true
        }) {
            
            Text("Join Call")
                .font(.title)
                .foregroundColor(.white)
                .padding(.all)
        }
        
        .background(Color.green)
        .cornerRadius(8.0)
        .fullScreenCover(isPresented: $showCall, content: {
            CallView()
        })
    }
}

struct CallView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var isMuted: Bool = false
    
    var body: some View {
        VStack {
            Text("Welcome to the call!")
                .bold()
            Spacer()
            AgoraRep(isMuted: $isMuted)
                .frame(width: 0, height: 0, alignment: .center)
            HStack {
                Image(systemName: "mic.circle.fill")
                    .font(.system(size: 64.0))
                    .foregroundColor(isMuted ? Color.yellow : Color.blue)
                    .padding()
                    .onTapGesture {
                        isMuted ? (isMuted = false) : (isMuted = true)
                    }
                
                Spacer()
                
                Image(systemName: "phone.circle.fill")
                    .font(.system(size: 64.0))
                    .foregroundColor(.red)
                    .padding()
                    .onTapGesture {
                        presentationMode.wrappedValue.dismiss()
                    }
            }
            .padding()
            
        }
    }
}

struct AgoraRep: UIViewControllerRepresentable {
    
    @Binding var isMuted: Bool
    
    func makeUIViewController(context: Context) -> AgoraViewController {
        let agoraViewController = AgoraViewController()
        agoraViewController.agoraDelegate = context.coordinator
        return agoraViewController
    }
    
    func updateUIViewController(_ uiViewController: AgoraViewController, context: Context) {
        isMuted ? (uiViewController.didClickMuteButton(isMuted: true)) : (uiViewController.didClickMuteButton(isMuted: false))
    }
    
    

    class Coordinator: NSObject, AgoraRtcEngineDelegate {
        var parent: AgoraRep
        init(_ agoraRep: AgoraRep) {
            self.parent = agoraRep
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
}


