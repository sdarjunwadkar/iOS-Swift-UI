//
//  ContentView.swift
//  ScrollTest
//
//  Created by Sharvil Deepak Arjunwadkar on 16/02/21.
//

import SwiftUI

struct ContentView: View {
    @State private var text = ""
    @State private var isSearching = false
    @State private var searchBarOffset = CGFloat.zero
//    @State private var isFirstResponder = false
    var body: some View {
        GeometryReader { geometry in
            ZStack{
//                if isSearching {
                    
//                }
                    List {
                        Text("")
                            .transformAnchorPreference(key: MyKey.self, value: .bounds) {
                                $0.append(MyFrame(id: "tableTopCell", frame: geometry[$1]))
                            }
                            .onPreferenceChange(MyKey.self) {
                                print($0[0].frame)
                                print($0.count)
                                if !isSearching {
                                    if $0[0].frame.minY > 15.0 {
                                        searchBarOffset = ($0[0].frame.minY - 15.0)
                                    }
                                    if $0[0].frame.minY > 100.0 {
                                        withAnimation{
                                            self.isSearching = true
                                        }
                                        withAnimation{
                                            searchBarOffset = CGFloat.zero
                                        }
                                    }
                                }
                            }

                        ForEach(TestEnum.allCases) {
                            Text($0.rawValue)
                                .padding(60)
                        }
                    }
                    .onTapGesture {
                        if isSearching {
                            self.hideKeyboard()
                            self.isSearching = false
                        }
                    }
                    
                VStack {
                    HStack {
                        SearchBar(text: $text, isSearching: $isSearching)
//                            .animation(.easeIn)
                        
                        if !isSearching {
                            Button("Edit"){
                                //
                            }
                        }
                        
                        if isSearching {
                            Button("Cancel"){
                                hideKeyboard()
                            }
                        }
                    }
                    .offset(x: 0, y: searchBarOffset)

                    
                    Spacer()
                }
            }
        }
//        GeometryReader { geometry in
//            VStack {
//            SearchBar(text: $text, isSearching: $isSearching)
//                .animation(.easeIn)
//                    List(TestEnum.allCases) { listValue in
//                        Text(listValue.id)
//                            .padding(60)
//                            .transformAnchorPreference(key: MyKey.self, value: .bounds) {
//                                $0.append(MyFrame(id: listValue.id, frame: geometry[$1]))
//                            }
//                            .onPreferenceChange(MyKey.self) {
//                                print($0[0].frame)
//                                print($0.count)
//                                if !isSearching {
//                                    if $0[0].frame.minY > 100.0 {
//                                        withAnimation{
//                                            self.isSearching = true
//                                        }
////                                        self.isFirstResponder = true
//                                    }
//                            }
//                    }
//                }
//        }
//        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct MyFrame : Equatable {
    let id : String
    let frame : CGRect

    static func == (lhs: MyFrame, rhs: MyFrame) -> Bool {
        lhs.id == rhs.id && lhs.frame == rhs.frame
    }
}

struct MyKey : PreferenceKey {
    typealias Value = [MyFrame] // The list of view frame changes in a View tree.

    static var defaultValue: [MyFrame] = []

    /// When traversing the view tree, Swift UI will use this function to collect all view frame changes.
    static func reduce(value: inout [MyFrame], nextValue: () -> [MyFrame]) {
        value.append(contentsOf: nextValue())
    }
}

enum TestEnum : String, CaseIterable, Identifiable {
    case one, two, three, four, five, six, seven, eight, nine, ten

    var id: String {
        rawValue
    }
}

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

#endif
