//
//  EditButton.swift
//  EarthQuakes
//
//  Created by Igor Polousov on 26.12.2024.
//

import SwiftUI

struct EditButton: View {
    @Binding var editMode: EditMode
    var action: () -> Void = {}
    var body: some View {
        Button {
            withAnimation {
                if editMode == .active {
                    action()
                    editMode = .inactive
                } else {
                    editMode = .active
                }
            }
        } label: {
            if editMode == .active {
                Text("Cancel").bold()
            } else {
                Text("Edit")
            }
        }
    }
}

struct EditButton_Previews: PreviewProvider {
    static var previews: some View {
        EditButton(editMode: .constant(.inactive))
            .previewLayout(.sizeThatFits)
        EditButton(editMode: .constant(.active))
            .previewLayout(.sizeThatFits)
        EditButton(editMode: .constant(.transient))
            .previewLayout(.sizeThatFits)
    }
}

//#Preview {
//    EditButton()
//}
