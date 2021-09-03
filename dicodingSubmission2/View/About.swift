//
//  About.swift
//  dicodingSubmission2
//
//  Created by Maitri Vira on 17/08/21.
//

import SwiftUI

struct About: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    Image("maitri")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 150.0, height: 150.0)
                        .clipShape(Circle())
                        .padding(.bottom)
                    Text("Maitri Vira")
                        .font(.title2)
                        .multilineTextAlignment(.center)
                    Text("Learner at Apple Developer Academy")
                        .font(.caption)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.gray)
                    Text("Hi, I'm Maitri Vira a Learner at Apple Developer Academy Batam. Currently focusing on mobile and web development.")
                        .font(.subheadline)
                        .multilineTextAlignment(.center)
                        .padding()
                    Spacer()
                }
                .padding(.top, 40)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            }
            .navigationBarTitle(Text("Profile"), displayMode: .inline)
        }
    }
}

struct About_Previews: PreviewProvider {
    static var previews: some View {
        About()
    }
}
