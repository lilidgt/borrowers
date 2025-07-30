//
//  ObaachanIntroView.swift
//  borrowers
//
//  Created by Lissa Deguti on 30/07/25.
//

import SwiftUI

struct ObaachanIntroView: View {
    @State private var step = 0
    @State private var isTyping = true
    @State private var textFullyDisplayed = false
    
    @State private var obaachanTalking = false
    @State private var minaTalking = false
    
    @State private var obaachanImageIndex = 0
    @State private var minaImageIndex = 0
    
    @State private var showSpeechBubble = false
    @State private var currentSpeaker: Speaker? = nil
    
    enum Speaker {
        case obaachan
        case mina
    }

    var body: some View {
        ZStack {
            Color(.defaultBackground)
                .ignoresSafeArea()
            
            VStack {
                VStack(alignment: .leading, spacing: 24) {
                    if step == 0 {
                        TextTypingView(
                            fullText: "In our world, there are small creatures, and we call them borrowers.\nThey hide close to our homes to borrow things. Like sugar or tea.",
                            isTyping: $isTyping,
                            textFullyDisplayed: $textFullyDisplayed,
                            textColor: Color("DarkBrown"),
                            font: .custom("Baby Doll", size: 22)
                        )
                    }
                    
                    if step == 1 {
                        TextTypingView(
                            fullText: "In the agitated urban life, a little house still existed, and that’s where Mina and Obaachan lived, between the trees’ roots.",
                            isTyping: $isTyping,
                            textFullyDisplayed: $textFullyDisplayed,
                            textColor: Color("DarkBrown")
                        )
                    }
                }
                .padding(.top, 80)
                .padding(.horizontal)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            }

            //imagens das personagens
            if step >= 1 {
                VStack {
                    Spacer()
                    HStack(spacing: 40) {
                        Image(minaTalking ? (minaImageIndex == 0 ? "mina_talking1" : "mina_serious") : "mina_serious")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100)
                        Image(obaachanTalking ? (obaachanImageIndex == 0 ? "obaachan_talking1_sofa" : "obaachan_talking2_sofa") : "obaachan_smile_sofa")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 200)
                    }
                    .padding(.bottom, 130)
                }
            }

            //fala da obaachan
            if step == 2 && showSpeechBubble && currentSpeaker == .obaachan {
                VStack {
                    ZStack(alignment: .topLeading) {
                        Image("speech_bubble_right")
                            .resizable()
                            .frame(width: 350, height: 260)

                        TextTypingView(
                            fullText: "Mina... Did you close the hatch behind the roots?",
                            isTyping: $isTyping,
                            textFullyDisplayed: $textFullyDisplayed,
                            textColor: Color("DarkBrown")
                        )
                        .padding(.top, 115)
                        .padding(.horizontal, 20)
                    }
                    .padding(.bottom, 280)
                }
            }

            //fala da mina
            if step == 3 && showSpeechBubble && currentSpeaker == .mina {
                VStack {
                    ZStack(alignment: .topLeading) {
                        Image("speech_bubble_left")
                            .resizable()
                            .frame(width: 350, height: 260)

                        TextTypingView(
                            fullText: "Yes, Obaachan, no one saw me.",
                            isTyping: $isTyping,
                            textFullyDisplayed: $textFullyDisplayed,
                            textColor: Color("DarkBrown")
                        )
                        .padding(.top, 115)
                        .padding(.horizontal, 20)
                    }
                    .padding(.bottom, 280)
                }
            }
        }
        .contentShape(Rectangle())
        .onTapGesture {
            if isTyping {
                isTyping = false
            } else if textFullyDisplayed {
                step += 1
                isTyping = true
                textFullyDisplayed = false

                if step == 2 {
                    currentSpeaker = .obaachan
                    showSpeechBubble = true
                    obaachanTalking = true
                    obaachanTalkingAnimation()
                } else if step == 3 {
                    currentSpeaker = .mina
                    showSpeechBubble = true
                    minaTalking = true
                    minaTalkingAnimation()
                } else if step == 4 {
                    showSpeechBubble = false
                    currentSpeaker = nil
                }
            }
        }
    }

    func obaachanTalkingAnimation() {
        Timer.scheduledTimer(withTimeInterval: 0.4, repeats: true) { timer in
            if !isTyping {
                obaachanTalking = false
                obaachanImageIndex = 0
                timer.invalidate()
                return
            }
            obaachanImageIndex = (obaachanImageIndex == 0) ? 1 : 0
        }
    }
    
    func minaTalkingAnimation() {
        Timer.scheduledTimer(withTimeInterval: 0.4, repeats: true) { timer in
            if !isTyping {
                minaTalking = false
                minaImageIndex = 0
                timer.invalidate()
                return
            }
            minaImageIndex = (minaImageIndex == 0) ? 1 : 0
        }
    }
}

#Preview {
    ObaachanIntroView()
}
