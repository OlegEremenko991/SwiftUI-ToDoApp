//
//  ItemListCell.swift
//  SwiftUI-ToDoApp
//
//  Created by Олег Еременко on 15.04.2021.
//

import SwiftUI

struct ItemListCell: View {
    var completed: Bool
    var title: String
    var timeStamp: String

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                Text(title)
                    .font(.title2)
                    .fontWeight(.medium)
                Text("Created on \(timeStamp)")
                    .foregroundColor(.secondary)
                    .fontWeight(.semibold)
            }
            .padding(.leading)
            Spacer()
            Image(systemName: completed ? "circle.fill" : "circle")
                .padding(.trailing)
        }
    }
}

struct ItemListCell_Previews: PreviewProvider {
    static var previews: some View {
        ItemListCell(completed: false, title: "Test task", timeStamp: "01.01.2021")
    }
}
