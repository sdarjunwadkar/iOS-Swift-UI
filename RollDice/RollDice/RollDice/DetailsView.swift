//
//  DetailsView.swift
//  RollDice
//
//  Created by Sharvil Arjunwadkar on 30/01/21.
//

import SwiftUI

struct DetailsView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Dice.entity(), sortDescriptors: []) var dice: FetchedResults<Dice>
    var body: some View {
        NavigationView{
            List {
                ForEach(dice, id: \.self){ item in
                    VStack(alignment: .leading) {
                        Text("Number of Dices: \(item.numberOfDice)")
                        Text("Number of sides: \(item.numberOfSides)")
                        Text("Total: \(item.diceTotal)")
                    }
                }
            }
            .navigationBarTitle("Details")
        }
    }
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsView()
    }
}
