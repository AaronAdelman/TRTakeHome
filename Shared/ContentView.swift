//
//  ContentView.swift
//  Shared
//
//  Created by אהרן שלמה אדלמן on 05/07/2021.
//

import SwiftUI

struct ContentView: View {
    @State var queryString: String = ""
    @ObservedObject var model: TRModel = TRModel.shared

//    private var threeColumnGrid = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    
    @State var isNavigationBarHidden: Bool = true

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("Query", text: $queryString)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Button(action: {
                        //                debugPrint(#file, #function, "Pressed search button", queryString)
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                        TRModel.shared.getFirstPage(queryString: queryString)
                    }) {
                        Text("🔍").foregroundColor(.accentColor).bold()
                    }
                    .keyboardShortcut(.defaultAction)
                    .frame(width: 30.0, height: 30.0)
                }
                .padding(8.0)
                
                if model.isWaitingForNewQueryResponse {
                    TRProgressView()
                    Spacer()
                }
                else if model.error != nil {
                    TRTextMessage(text: model.error!.localizedDescription)
                } else {

                    if model.queryResponses.count > 0 {
                        HStack {
                            Text("Showing results for query:  ")
                            Text(model.queryString)
                        }
                        ScrollView {
//                            LazyVGrid(columns: threeColumnGrid) {
//                                ForEach(0..<model.hits.count, id: \.self) {
//                                    PBHitView(model: model, index: $0)
//                                }
//                            }
                        }
                        Spacer()
                    } else {
                        TRTextMessage(text: NSLocalizedString("No results.  Please enter a search term to see cool images.", comment: ""))
                    }
                }
            } // VStack
            .navigationBarHidden(self.isNavigationBarHidden)
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarBackButtonHidden(true)
        } // NavigationView
        .navigationViewStyle(StackNavigationViewStyle())
    } // var body
}


// MARK:  -

struct TRTextMessage: View {
    var text: String
    
    var body: some View {
        List {
            Text(text)
                .padding()
            Spacer()
        }

    }
}

// MARK:  -

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
