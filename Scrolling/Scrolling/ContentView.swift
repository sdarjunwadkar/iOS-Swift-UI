//
//  ContentView.swift
//  Scrolling
//
//  Created by Sharvil Deepak Arjunwadkar on 15/02/21.
//

import SwiftUI

struct ContentView: View {
    @State private var onTop = true
    @State private var arr: [Int] = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50]
     
    
    var topBar: some View {
        VStack {
          Text("Title Bar")
          .font(.largeTitle)
          Text("On top ☝️")
        }
        .frame(maxWidth: .infinity)
        .padding(.top, 35)
        .background(Color(UIColor.systemBackground))
      }
      
      var bottomBar: some View {
        (Text("Title Bar").bold() + Text(" at the bottom 👇"))
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color(UIColor.systemBackground))
        .opacity(onTop ? 0 : 0.85)
      }

    
    var body: some View {
        ZStack {
            GeometryReader { g in
                List(0..<arr.count) {item in
                    
                    Text("\(arr[item])")
                        .transformAnchorPreference(key: MyKey.self, value: .bounds){
                            $0.append(MyFrame(id: "Example", frame: g[$1]))
                        }
                
                }
                .onPreferenceChange(MyKey.self) { _ in
                    print(g.frame(in: .global).minY)
    //                    if $0  {
    //                      withAnimation {
    //                        self.onTop = false
    //                      }
    //                    } else {
    //                      withAnimation {
    //                        self.onTop = true
    //                      }
    //                    }
                }
    //                .frame(maxWidth: .infinity)
                    
    //            .multilineTextAlignment(.center)
    //            .padding(.top, 60)
    //            .padding(.bottom, 50)
    //            .anchorPreference(key: OffsetKey.self, value: .top) {
    //              g[$0].y
    //            }
    //          }
            }
                
                  
            VStack {
                    if onTop {
                      topBar
                      .transition(.move(edge: .top))
                    }
                    Spacer()
                    bottomBar
                  }
                  .edgesIgnoringSafeArea([.top, .bottom])
        }
    }
    
    func removeRows(at offsets: IndexSet) {
        arr.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//struct OffsetKey: PreferenceKey {
//  static var defaultValue: CGFloat = 0
//  static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
//    value = nextValue()
//  }
//}

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
