//
//  ContentView.swift
//  Agora
//
//  Created by Nyi Ye Han on 04/03/2023.
//

import SwiftUI

struct ContentView: View {
    @State var joinedChannel: Bool = false

        var body: some View {
            ZStack {
                AgoraViewerHelper.agview
                if !joinedChannel {
                    Button("Join Channel") {
                        self.joinChannel()
                    }
                }
            }
        }

        func joinChannel() {
            self.joinedChannel = true
            AgoraViewerHelper.agview.join(
                channel: Utils.CHANNEL_ID, with: Utils.TOKEN,
                as: .broadcaster
            )
        }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
