//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Sharvil Arjunwadkar on 08/01/21.
//

import SwiftUI

struct CheckoutView: View {
    @ObservedObject var order: Order
    @State private var confirmationTitle = ""
    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false
    var body: some View {
        GeometryReader { geo in
            ScrollView {
                VStack {
                    Image("cupcakes")
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width)
                    
                    Text("Your total is $\(self.order.cost, specifier: "%.2f")")
                        .font(.title)
                    
                    Button("Place order"){
                        self.placeOrder()
                    }
                    .padding()
                }
            }
        }
        .navigationBarTitle("Checkout", displayMode: .inline)
        .alert(isPresented: $showingConfirmation){
            Alert(title: Text(confirmationTitle), message: Text(confirmationMessage), dismissButton: .default(Text("Ok")))
        }
    }
    
    func placeOrder() {
        guard let encoded = try? JSONEncoder().encode(order) else {
            print("Failed to encode")
            return
        }
        
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = encoded
        
        URLSession.shared.dataTask(with: request){ data, response, error in
            guard let data = data else {
                self.confirmationTitle = "Server Error"
                self.confirmationMessage = "You are not connected to internet please check your connection"
                self.showingConfirmation = true
                print("No data in response: \(error?.localizedDescription ?? "Unknown Error").")
                return
            }
            
            if let decodedOrder = try? JSONDecoder().decode(Order.self, from: data){
                self.confirmationMessage = "Your order for \(decodedOrder.quantity) x \(Order.types[decodedOrder.type].lowercased()) cupcakes is on its way."
                self.showingConfirmation = true
                self.confirmationTitle = "Thank You"
            }
            else {
                print("Inalid response from server")
            }
            
        }.resume()
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(order: Order())
    }
}
