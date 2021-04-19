//
//  ContentView.swift
//  Drawing
//
//  Created by Sharvil Arjunwadkar on 07/01/21.
//

import SwiftUI

//struct Flower: Shape {
//    var petalOffset: Double = -20
//    var petalWidth: Double = 100
//
//    func path(in rect: CGRect) -> Path {
//        var path = Path()
//
//        for number in stride(from: 0, to: CGFloat.pi * 2, by: CGFloat.pi / 8){
//            let rotation = CGAffineTransform(rotationAngle: number)
//            let position = rotation.concatenating(CGAffineTransform(translationX: rect.width / 2, y: rect.height / 2))
//
//            let originalPetal = Path(ellipseIn: CGRect(x: CGFloat(petalOffset), y: 0, width: CGFloat(petalWidth), height: rect.width / 2))
//            let rotatedPetal = originalPetal.applying(position)
//
//            path.addPath(rotatedPetal)
//        }
//
//        return path
//    }
//}

//struct ColorCyclingCircle: View {
//    var amount = 0.0
//    var steps = 100
//
//    var body: some View {
//        ZStack{
//            ForEach(0..<steps) {value in
//                Circle()
//                    .inset(by: CGFloat(value))
//                    .strokeBorder(LinearGradient(gradient: Gradient(colors: [
//                        self.color(for: value, brightness: 1),
//                        self.color(for: value, brightness: 0.5)
//                    ]), startPoint: .top, endPoint: .bottom), lineWidth: 2)
//            }
//        }
//        .drawingGroup()
//    }
//
//    func color(for value: Int, brightness: Double) -> Color {
//        var targetHue = Double(value) / Double(self.steps) + self.amount
//
//        if targetHue > 1 {
//            targetHue -= 1
//        }
//
//        return Color(hue: targetHue, saturation: 1, brightness: brightness)
//    }
//}

//struct Trapezoid: Shape {
//    var insetAmount: CGFloat
//
//    var animatableData: CGFloat {
//        get { insetAmount }
//        set { self.insetAmount = newValue }
//    }
//
//    func path(in rect: CGRect) -> Path {
//        var path = Path()
//
//        path.move(to: CGPoint(x: 0, y: rect.maxY))
//        path.addLine(to: CGPoint(x: insetAmount, y: rect.minY))
//        path.addLine(to: CGPoint(x: rect.maxX - insetAmount, y: rect.minY))
//        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
//        path.addLine(to: CGPoint(x: 0, y: rect.maxY))
//
//        return path
//    }
//}

//struct Checkerboard: Shape {
//    var rows: Int
//    var columns: Int
//
//    public var animatableData: AnimatablePair<Double, Double> {
//        get{
//            AnimatablePair(Double(rows), Double(columns))
//        }
//        set{
//            self.rows = Int(newValue.first)
//            self.columns = Int(newValue.second)
//        }
//    }
//
//    func path(in rect: CGRect) -> Path {
//        var path  = Path()
//
//        let rowSize = rect.height / CGFloat(rows)
//        let columnSize = rect.width / CGFloat(columns)
//
//        for row in 0..<rows {
//            for column in 0..<columns {
//                if (row + column).isMultiple(of: 2) {
//                    let startX = columnSize * CGFloat(column)
//                    let startY = rowSize * CGFloat(row)
//
//                    let rect = CGRect(x: startX, y: startY, width: columnSize, height: rowSize)
//                    path.addRect(rect)
//                }
//            }
//        }
//
//        return path
//    }
//}

//struct Arrow: Shape {
//    func path(in rect: CGRect) -> Path {
//        var path = Path()
//        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
//        path.addLine(to: CGPoint(x: rect.minX, y: rect.midY))
//        path.addLine(to: CGPoint(x: rect.midX / 2, y: rect.midY))
//        path.addLine(to: CGPoint(x: rect.midX / 2, y: rect.maxY))
//        path.addLine(to: CGPoint(x: rect.midX * 1.5, y: rect.maxY))
//        path.addLine(to: CGPoint(x: rect.midX * 1.5, y: rect.midY))
//        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
//        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
//        path.addLine(to: CGPoint(x: rect.minX, y: rect.midY))
//
//        return path
//    }
//}

struct ColorCyclingRectangle: View {
    var amount = 0.0
    var steps = 100

    var body: some View {
        ZStack{
            ForEach(0..<steps) {value in
                Rectangle()
                    .inset(by: CGFloat(value))
                    .strokeBorder(LinearGradient(gradient: Gradient(colors: [
                        self.color(for: value, brightness: 1),
                        self.color(for: value, brightness: 0.5)
                    ]), startPoint: .top, endPoint: .bottom), lineWidth: 2)
            }
        }
        .drawingGroup()
    }

    func color(for value: Int, brightness: Double) -> Color {
        var targetHue = Double(value) / Double(self.steps) + self.amount

        if targetHue > 1 {
            targetHue -= 1
        }

        return Color(hue: targetHue, saturation: 1, brightness: brightness)
    }
}


struct ContentView: View {
    @State private var colorRectangle = 0.0
//    @State private var thickness: CGFloat = 10
//    @State private var rows = 4
//    @State private var columns = 4
//    @State private var insetAmount: CGFloat = 50
//    @State private var colorCycle = 0.0
//    @State private var petalOffset = -20.0
//    @State private var petalWidth = 100.0
    var body: some View {
        VStack {
            ColorCyclingRectangle(amount: self.colorRectangle)
                .frame(width: 300, height: 300)

            Slider(value: $colorRectangle)
                .padding()
        }
//        VStack(spacing: 100){
//            Arrow()
//                .stroke(Color.blue, lineWidth: thickness)
//                .frame(width: 200, height: 200)
//
//            Slider(value: $thickness, in: 10...40)
//                .padding()
//        }
//        Checkerboard(rows: rows, columns: columns)
//            .onTapGesture {
//                withAnimation(.linear(duration: 3)){
//                    self.rows = 8
//                    self.columns = 16
//                }
//            }
//        Trapezoid(insetAmount: insetAmount)
//            .frame(width: 200, height: 100)
//            .onTapGesture {
//                withAnimation {
//                    self.insetAmount = CGFloat.random(in: 10...90)
//                }
//            }
//        VStack {
//            ColorCyclingCircle(amount: self.colorCycle)
//                .frame(width: 300, height: 300)
//
//            Slider(value: $colorCycle)
//        }
//        VStack{
//            Flower(petalOffset: petalOffset, petalWidth: petalWidth)
//                .fill(Color.red, style: FillStyle(eoFill: true))
//
//            Text("Offset")
//            Slider(value: $petalOffset, in: -40...40)
//                .padding([.horizontal, .bottom])
//
//            Text("Width")
//            Slider(value: $petalWidth, in: 0...100)
//                .padding(.horizontal)
//        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
