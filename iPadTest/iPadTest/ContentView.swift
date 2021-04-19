//
//  ContentView.swift
//  iPadTest
//
//  Created by Sharvil Deepak Arjunwadkar on 22/02/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
//            GeometryReader { hg in
            ZStack(alignment: .myAlignment){
                    HStack{
                       Rectangle()
                        .frame(width: 50)
                        .padding()
                        Rectangle()
                            .frame(width: 50)
                            .padding()
                    }
//                    .alignmentGuide(VerticalAlignment.myAlignment)
//                                               { d in d[VerticalAlignment.top] }
                            .alignmentGuide(HorizontalAlignment.myAlignment)
                                { d in d[HorizontalAlignment.leading] }
//                            .frame(width: 100, height: 100)
                
                RoundedRectangle(cornerRadius: 25.0)
                    .foregroundColor(.blue)
                    .opacity(0.8)
//                    .alignmentGuide(HorizontalAlignment.myAlignment)
//                                               { d in d[.leading] }
//                            .alignmentGuide(VerticalAlignment.myAlignment)
//                                               { d in d[.bottom] }
//                            .frame(width: 100, height: 100)
            }
            .frame(height: 100)
//            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension HorizontalAlignment {
    enum MyHorizontal: AlignmentID {
        static func defaultValue(in d: ViewDimensions) -> CGFloat
                 { d[HorizontalAlignment.center] }
    }
    static let myAlignment =
                 HorizontalAlignment(MyHorizontal.self)
}

extension VerticalAlignment {
    enum MyVertical: AlignmentID {
        static func defaultValue(in d: ViewDimensions) -> CGFloat
                 { d[VerticalAlignment.center] }
    }
    static let myAlignment = VerticalAlignment(MyVertical.self)
}

extension Alignment {
    static let myAlignment = Alignment(horizontal: .myAlignment,
                               vertical: .myAlignment)
}
