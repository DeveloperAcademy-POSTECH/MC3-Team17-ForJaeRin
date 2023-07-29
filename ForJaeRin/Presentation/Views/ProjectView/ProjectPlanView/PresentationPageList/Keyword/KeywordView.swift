//
//  KeywordView.swift
//  ForJaeRin
//
//  Created by 이용준의 Macbook on 2023/07/20.
//

import SwiftUI

struct KeywordView: View {
    
    @EnvironmentObject var myData: MyData
    @State var pageNumber: Int
    @State var lastIndex: Int
    
    @State var editSomething = false
    @State private var startIndex: String = ""
    @State var cursorIndex: Int = 7
//    @State var keywordIndexList = Array(repeating: [Int](), count: 7)
//    var frameWidth = 345.0
//    @State var test = ""
    
    var body: some View {
        ZStack {
            GeometryReader { geometry in
                var width = 0.0
                var height = 0.0
                ZStack(alignment: .topLeading) {
                    ForEach(myData.keywords[pageNumber].indices, id: \.self) { keywordIndex in
                        if keywordIndex <= lastIndex {
                            KeywordFieldView(
                                newKeyword: $myData.keywords[pageNumber][keywordIndex],
                                cursorIndex: cursorIndex,
                                index: keywordIndex,
                                editSomething: $editSomething
                            )
                                .alignmentGuide(.leading) { item in
                                    if abs(width - item.width) > geometry.size.width {
                                        width = 0.0; height -= item.height + 12
                                    }
                                    let result = width
                                    if keywordIndex == lastIndex {
                                        width = 0
                                    } else {
                                        width -= item.width
                                    }
                                    return result
                                }
                                .alignmentGuide(.top) { _ in
                                    let result = height
                                    if keywordIndex == lastIndex {
                                        height = 0
                                    }
                                    return result
                                }
                        }
                    }
                }
            }.onAppear {
                resetKeywords()
            }
        }
        
        
        
//        VStack(spacing: 0) {
//            ForEach(keywordIndexList.indices, id: \.self) { rowIndex in
//                let rowIndexes = keywordIndexList[rowIndex]
//                HStack(spacing: 0) {
//                    ForEach(rowIndexes, id: \.self) { index in
//                        if index != 7 {
//                            KeywordFieldView(
//                                newKeyword: $myData.keywords[pageNumber][index],
//                                cursorIndex: cursorIndex,
//                                index: index,
//                                editSomething: $editSomething
//                            )
//                                .onChange(of: editSomething, perform: { newValue in
//                                    if newValue == false {
//                                        resetKeywordIndexList()
//                                        print(keywordIndexList)
//                                    }
//                                })
//                                .onDrag {
//                                    NSItemProvider(object: String(index) as NSString)
//                                }
//                                .onDrop(of: ["public.text"],
//                                        delegate:
//                                            DelegateForCursor(
//                                            keywordview: self,
//                                            startIndex: $startIndex,
//                                            cursorIndex: $cursorIndex,
//                                            endIndex: String(index)
//                                            )
//                                )
//                        } else {
//                            Button(action: {
//                                lastIndex += 1
//                                resetKeywordIndexList()
//                            }, label: {
//                                Image(systemName: "plus.circle.fill")
//                                    .foregroundColor(Color(red: 172 / 255, green: 159 / 255, blue: 255 / 255))
//                                    .frame(width: 18.18, height: 18.18)
//                                    .frame(width: 48, height: 45)
//                            }).buttonStyle(.plain)
//                        }
//                    }
//                    Spacer()
//                }
//            }
//        }.onAppear {
//            print(myData.keywords)
//            withAnimation {
//                resetKeywordIndexList()
//            }
//        }
    }
    private func resetKeywords() {
        let tempList = myData.keywords[pageNumber]
        myData.keywords[pageNumber] = []
        for index in 0..<7 where tempList[index] != "" {
            myData.keywords[pageNumber].append(tempList[index])
        }
        let lenghtList = myData.keywords[pageNumber].count
        for _ in myData.keywords[pageNumber].count..<7 {
            myData.keywords[pageNumber].append("")
        }
    }
    
//    func resetKeywordIndexList() {
//        var rowNumber = 0
//        var filledWidth = 0.0
//        for index in 0..<7 {
//            keywordIndexList[index] = []
//        }
//        for index in 0...lastIndex {
//            print("myData.keywords[pageNumber: \(pageNumber)].count: ", myData.keywords[pageNumber].count, ", index: \(index) ")
//            filledWidth = filledWidth + (myData.keywords[pageNumber][index] == "" ?
//                                         "키워드 입력" :
//                                            myData.keywords[pageNumber][index])
//            .widthOfString(fontStyle: NSFont.systemFont(ofSize: 18, weight: .semibold)) + 36
//            // print("추가되었을 때", filledWidth)
//            if filledWidth > frameWidth {
//                rowNumber += 1
//                filledWidth = (myData.keywords[pageNumber][index] == "" ? "키워드 입력" :
//                                myData.keywords[pageNumber][index])
//                .widthOfString(fontStyle: NSFont.systemFont(ofSize: 18, weight: .semibold)) + 36
//                // print("그래서 줄였어", filledWidth)
//            }
//            keywordIndexList[rowNumber].append(index)
//        }
//        if lastIndex < 6 {
//            filledWidth += 48
//            if filledWidth > frameWidth {
//                rowNumber += 1
//            }
//            keywordIndexList[rowNumber].append(7)
//        }
//    }

//    private func deleteKeyword(index: Int) {
//        withAnimation {
//            myData.keywords[pageNumber].remove(at: index)
//            myData.keywords[pageNumber].append("")
//            lastIndex -= 1
//            resetKeywordIndexList()
//        }
//    }
    
//    func moveItems(from: Int, destination: Int) {
//        withAnimation {
//            let from_value = myData.keywords[pageNumber][from]
//            myData.keywords[pageNumber].remove(at: from)
//            myData.keywords[pageNumber].insert(from_value, at: destination)
//            resetKeywordIndexList()
//        }
//    }
}

//struct DelegateForCursor: DropDelegate {
//    let keywordview: KeywordView
//    @Binding var startIndex: String
//    @Binding var cursorIndex: Int
//    var endIndex: String
//
//    func performDrop(info: DropInfo) -> Bool {
//        guard info.hasItemsConforming(to: ["public.text"]) else {
//            return false
//        }
//        let items = info.itemProviders(for: ["public.text"])
//        for item_ in items {
//            _ = item_.loadObject(ofClass: NSString.self) { (provider, _) in
//                if let text = provider as? String {
//                    DispatchQueue.main.async {
//                        startIndex = text
//                        keywordview.moveItems(from: Int(startIndex)!, destination: Int(endIndex)!)
//                    }
//                }
//            }
//        }
//        return true
//    }
//    func dropEntered(info: DropInfo) {
//        cursorIndex = Int(endIndex)!
//        print(cursorIndex)
//        NSCursor.hide()
//    }
//    func dropExited(info: DropInfo) {
//        cursorIndex = 7
//        NSCursor.unhide()
//        print(cursorIndex)
//    }
//}
