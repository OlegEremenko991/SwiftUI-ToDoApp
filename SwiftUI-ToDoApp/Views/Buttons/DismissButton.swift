//
//  DismissButton.swift
//  SwiftUI-ToDoApp
//
//  Created by Олег Еременко on 15.04.2021.
//

import SwiftUI

struct DismissButton: View {
    @Binding var isShowingSheet: Bool

    var body: some View {
        HStack {
            Spacer()
            Button {
                isShowingSheet = false
            } label: {
                Image(systemName: "xmark")
                    .foregroundColor(Color(.label))
                    .imageScale(.large)
                    .frame(width: 44, height: 44)
            }
        }
        .padding()
    }
}

struct DismissButton_Previews: PreviewProvider {
    static var previews: some View {
        DismissButton(isShowingSheet: .constant(false))
            .preferredColorScheme(.dark)
    }
}
