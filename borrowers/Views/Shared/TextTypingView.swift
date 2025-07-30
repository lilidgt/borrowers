//
//  TextTypingView.swift
//  borrowers
//
//  Created by Lissa Deguti on 30/07/25.
//

import SwiftUI

struct TextTypingView: View {
    let fullText: String
    @Binding var isTyping: Bool
    @Binding var textFullyDisplayed: Bool
    var textColor: Color = .white
    var font: Font = .custom("Baby Doll", size: 20)
    
    @State private var displayedText = ""
    @State private var timer: Timer?
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            Text(displayedText)
                .font(font) // aqui usa a fonte customizada
                .multilineTextAlignment(.leading)
                .foregroundColor(textColor)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .onAppear {
                    startTyping()
                }
                .onChange(of: isTyping) {
                    if !isTyping && displayedText != fullText {
                        showFullText()
                    }
                }
            
            if textFullyDisplayed {
                Image(systemName: "chevron.right")
                    .foregroundColor(textColor)
                    .padding()
                    .transition(.opacity)
            }
        }
    }
    
    private func startTyping() {
        displayedText = ""
        textFullyDisplayed = false
        var charIndex = 0
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.035, repeats: true) { timer in
            if charIndex < fullText.count {
                let index = fullText.index(fullText.startIndex, offsetBy: charIndex)
                displayedText += String(fullText[index])
                charIndex += 1
            } else {
                timer.invalidate()
                isTyping = false
                textFullyDisplayed = true
            }
        }
    }
    
    private func showFullText() {
        timer?.invalidate()
        displayedText = fullText
        isTyping = false
        textFullyDisplayed = true
    }
}

