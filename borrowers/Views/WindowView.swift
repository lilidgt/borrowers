//
//  WindowView.swift
//  borrowers
//
//  Created by Lissa Deguti on 30/07/25.
//

import SwiftUI

struct WindowView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        .background(.defaultBackground)
    }
}

#Preview {
    WindowView()
}
