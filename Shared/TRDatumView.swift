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
            Text(nameAndDateString)
                .lineLimit(1)
            Text(datum.datumDescription.trimHTMLTags() ?? "")
                .lineLimit(2)
                .multilineTextAlignment(.leading)
                .truncationMode(.tail)
        }
    }
}

//struct TRDatumView_Previews: PreviewProvider {
//    static var previews: some View {
//        TRDatumView()
//    }
//}
