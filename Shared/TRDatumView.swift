//
//  TRDatumView.swift
//  TRTakeHome
//
//  Created by אהרן שלמה אדלמן on 05/07/2021.
//

import SwiftUI

struct TRDatumView: View {
    var datum: Datum
        
    var body: some View {
        let nameAndDateString = datum.author.name + " / " + datum.date.formattedFromTimestamp
        
        VStack {
            Text(datum.title)
                .font(.title)
                .lineLimit(1)
            
            Text(nameAndDateString)
                .lineLimit(1)
            
            Text(datum.datumDescription.withoutHTMLTags())
                .lineLimit(2)
                .multilineTextAlignment(.leading)
                .truncationMode(.tail)
        } // VStack
    }
}

//struct TRDatumView_Previews: PreviewProvider {
//    static var previews: some View {
//        TRDatumView()
//    }
//}
