//
//  SearchBar.swift
//  MainScreen
//
//  Created by Sharvil Deepak Arjunwadkar on 08/02/21.
//

import Foundation
import SwiftUI

struct SearchBar: UIViewRepresentable {
    @Binding var text: String
    @Binding var isSearching: Bool
//    var isFirstResponder: Bool = false

    func makeUIView(context: Context) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator

        searchBar.placeholder = "Search"
        searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: "Search", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 181/255, green: 161/255, blue: 161/255, alpha: 100)])
        searchBar.backgroundImage = UIImage()
        searchBar.searchTextField.leftView?.tintColor = UIColor(red: 181/255, green: 161/255, blue: 161/255, alpha: 100/100)
        searchBar.searchTextField.backgroundColor = UIColor(red: 255/255, green: 219/255, blue: 219/255, alpha: 22/100)

        return searchBar
    }

    func updateUIView(_ uiView: UISearchBar, context: Context) {
        uiView.text = text
        if isSearching && !context.coordinator.didBecomeFirstResponder  {
                    uiView.becomeFirstResponder()
                    context.coordinator.didBecomeFirstResponder = true
                }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(text: $text, isSearching: $isSearching)
    }

    class Coordinator: NSObject, UISearchBarDelegate {
        @Binding var text: String
        @Binding var isSearching: Bool
        var didBecomeFirstResponder = false


        init(text: Binding<String>, isSearching: Binding<Bool>){
            _text = text
            _isSearching = isSearching
        }

        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            text = searchText
        }

        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            isSearching = false
//            searchBar.setShowsCancelButton(false, animated: true)
            searchBar.endEditing(true)
        }
        
        func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
            DispatchQueue.main.async {
                self.isSearching = true
            }
            
//            searchBar.setShowsCancelButton(true, animated: true)
//            print("Editing")
        }
        
        func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
            isSearching = false
            didBecomeFirstResponder = false
        }
        
        func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            isSearching = false
            didBecomeFirstResponder = false
//            searchBar.setShowsCancelButton(false, animated: true)
            searchBar.endEditing(true)
        }
    }
}



//struct SearchBar: UIViewRepresentable {
//
//  @Binding var text: String
//
//
//
//  class Coordinator: NSObject, UISearchBarDelegate {
//
//    @Binding var text: String
//
//    init(text: Binding<String>) {
//      _text = text
//    }
//
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//      text = searchText
//    }
//  }
//
//  func makeCoordinator() -> SearchBar.Coordinator {
//    return Coordinator(text: $text)
//  }
//
//    func makeUIView(context: Context) -> UISearchBar {
//    let searchBar = UISearchBar()
//    searchBar.delegate = context.coordinator
//
//    searchBar.placeholder = "Search"
//    searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: "Search", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 181/255, green: 161/255, blue: 161/255, alpha: 100)])
//    searchBar.backgroundImage = UIImage()
//    searchBar.searchTextField.leftView?.tintColor = UIColor(red: 181/255, green: 161/255, blue: 161/255, alpha: 100/100)
//    searchBar.searchTextField.backgroundColor = UIColor(red: 255/255, green: 219/255, blue: 219/255, alpha: 22/100)
//
//
//    return searchBar
//  }
//
//  func updateUIView(_ uiView: UISearchBar, context: Context) {
//    uiView.text = text
//  }
//}








