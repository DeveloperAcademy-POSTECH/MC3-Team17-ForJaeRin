//
//  ProjectPlanView.swift
//  ForJaeRin
//
//  Created by Yun Dongbeom on 2023/07/14.
//

import SwiftUI

struct ProjectPlanView: View {
    @State var values = [
        "a", "b", "c", "d",
        "e", "f", "g", "h"
    ]
    
    @State var isHovering: Bool = false
    var body: some View {
        VStack {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            List {
                        ForEach(0..<values.count, id: \.self) { index in
                            HStack {
                                Image(systemName: "line.horizontal.3")
                                    .onHover { hovering in
                                        isHovering = hovering
                                    }
                                
                                TextField("Value", text: $values[index])
                            }
//                            .moveDisabled(!isHovering)
                        }
                        .onMove { indices, newOffset in
                            values.move(
                                fromOffsets: indices,
                                toOffset: newOffset
                            )
                        }
                    }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct ProjectPlanView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectPlanView()
    }
}
