//
//  ContentView.swift
//  ForJaeRin
//
//  Created by Yun Dongbeom on 2023/07/06.
//

import SwiftUI

struct ContentView: View {
    let colors: [Color] = [.purple, .pink, .orange]
    @State private var selection: Color? = .purple // Nothing selected by default.
    @State private var isSheetActive = false
    @State private var isShowingDialog = false
    @State private var bold = false
    var title: String = "text"
    @State private var selectedFile: URL?
    @State private var showSidebar = false
    
    @State private var folders = [
        "All": [
            "Item1",
            "Item2"
        ],
        "Favorites": [
            "Item2"
        ]
    ]
    
    var body: some View {
        //        VStack {
        ////            Image(systemName: "globe")
        ////                .imageScale(.large)
        ////                .foregroundColor(.accentColor)
        ////            Text("rin 수정2222")
        ////            Image("test_landscape")
        ////                .resizable()
        ////            SampleView()
        ////            // MARK: 파일시스템을 테스트하기 위한 버튼
        ////            FileSystemView()
        ////            RecordView()
        NavigationSplitView {
            List(colors, id: \.self, selection: $selection) { color in
                NavigationLink(color.description, value: color)
            }
            .frame(minWidth: 272)
        } detail: {
            if let color = selection {
                #if os(macOS)
                HSplitView {
                    VStack {
                        Text("Pick a color \(color.description)")
                        Button {
                            toggleSheet()
                            
                        } label: {
                            Text("Show Sheet")
                        }
                        HStack {
                                    // Main content view
                                    Text("Main Content")
                                        .padding()
                                    
                                    if showSidebar {
                                        // Sidebar content
                                        VStack {
                                            Text("Sidebar")
                                                .font(.headline)
                                                .padding()
                                            // Add your sidebar components here
                                        }
                                        .frame(width: 200)
                                        .background(Color.gray.opacity(0.2))
                                    }
                                }
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .background(Color.white)
                                .toolbar {
                                    // Button to toggle the sidebar
                                    Button(action: {
                                        withAnimation {
                                            showSidebar.toggle()
                                        }
                                    }) {
                                        Image(systemName: showSidebar ? "sidebar.squares.left": "sidebar.squares.right")
                                    }
                                }
                    }
                    .sheet(
                        isPresented: $isSheetActive,
                       onDismiss: didDismiss) {
                        VStack {
                            Text("dismiss!")
                            Button {
                                toggleSheet()
                                
                            } label: {
                                Text("Show Sheet")
                            }
                            Button("Empty Trash") {
                                isShowingDialog = true
                            }
                            .confirmationDialog(
                                title,
                                isPresented: $isShowingDialog
                            ) {
                                Button("Empty Trash", role: .destructive) {
                                    // Handle empty trash action.
                                }
                                Button("Cancel", role: .cancel) {
                                    isShowingDialog = false
                                }
                            }
                            VStack {
                                Button("Open File") {
                                    let panel = NSOpenPanel()
                                    panel.allowedContentTypes = [.text, .plainText, .png, .jpeg] // Specify the allowed file types
                                    panel.begin { response in
                                        if response == .OK, let fileUrl = panel.url {
                                            selectedFile = fileUrl
                                        }
                                    }
                                }
                                .padding()
                                
                                if let file = selectedFile {
                                    Text("Selected File: \(file.path)")
                                        .padding()
                                }
                            }
                            .frame(minWidth: 200, minHeight: 100)
                        }
                        .frame(minWidth: 650, minHeight: 320)
                    }
                    .frame(idealWidth: .infinity, maxWidth: .infinity, maxHeight: .infinity)
                    Text("right \(color.description)")
                           .frame(minWidth: 272, maxWidth: .infinity, maxHeight: .infinity)
                }
                .navigationTitle("\(color.description)")
                .toolbar {
                    ToolbarItemGroup {
                        Toggle(isOn: $bold) {
                            VStack {
                                Image(systemName: "bold")
                            }
                        }
                        Toggle(isOn: $bold) {
                            VStack {
                                Image(systemName: "bold")
                            }
                        }
                        Toggle(isOn: $bold) {
                            VStack {
                                Label {
                                    Text("hello")
                                } icon: {
                                    Image(systemName: "bold")
                                }
                            }
                        }
                    }
                    ToolbarItemGroup(placement: .primaryAction, content: {
                         Button(action: {}, label: {
                             Image(systemName: "square.stack.3d.down.forward.fill")
                             Text(verbatim: "image_button")
                         })
                     })
                    ToolbarItemGroup(placement: .automatic, content: {
                        Menu(content: {
                            Button(action: {}, label: { Text(verbatim: "menu_item_1") })
                            Button(action: {}, label: { Text(verbatim: "menu_item_2") })
                        }, label: {
                            Text(verbatim: "menu")
                        })
                        .frame(minWidth: 200)
                    })
                    ToolbarItemGroup(placement: .automatic, content: {
                         Picker(selection: .constant(1), content: {
                             Text("picker").tag(0)
                             Text("inline").tag(1)
                         }, label: { })
                             .pickerStyle(InlinePickerStyle()) // same as: SegmentedPickerStyle()
                     })
                    ToolbarItemGroup(placement: .automatic, content: {
                        Picker(selection: .constant(0), content: {
                            Text("picker_1").tag(0)
                            Text("picker_2").tag(1)
                            Text("picker_3").tag(2)
                        }, label: { })
                    })
                     ToolbarItemGroup(placement: .destructiveAction, content: {
                         Button(action: {}, label: {
                             Text(verbatim: "button")
                         })
                     })
                }
                #endif
                #if os(iOS)
                VStack {
                    VStack {
                        VStack {
                            Text("Pick a color \(color.description)")
                            Button {
                                toggleSheet()
                                
                            } label: {
                                Text("Show Sheet")
                            }
                        }
                        .sheet(
                            isPresented: $isSheetActive,
                            onDismiss: didDismiss) {
                                VStack {
                                    Text("dismiss!")
                                    Button {
                                        toggleSheet()
                                        
                                    } label: {
                                        Text("Show Sheet")
                                    }
                                    Button("Empty Trash") {
                                        isShowingDialog = true
                                    }
                                    .confirmationDialog(
                                        title,
                                        isPresented: $isShowingDialog
                                    ) {
                                        Button("Empty Trash", role: .destructive) {
                                            // Handle empty trash action.
                                        }
                                        Button("Cancel", role: .cancel) {
                                            isShowingDialog = false
                                        }
                                    }
                                    
                                }
                                .frame(minWidth: 650, minHeight: 320)
                            }
                    }
                }
                #endif
            } else {
                Text("Pick a color")
            }
        }
    }
    
    private func toggleSheet() {
        isSheetActive.toggle()
    }
    
    private func didDismiss() {
        print("dismiss!")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
