//
//  About.swift
//  dicodingSubmission2
//
//  Created by Maitri Vira on 17/08/21.
//

import SwiftUI

struct About: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @GestureState private var dragOffset = CGSize.zero
    @EnvironmentObject var profile: ProfileViewModel
    @State var edit: Bool
    @State private var showImagePicker = false
    @State private var image: Image?
    @State private var inputImage: UIImage?
    @State private var name: String = "Maitri Vira"
    @State private var job: String = "Learner at Apple Developer Academy"
    @State private var desc: String = "Hi, I'm Maitri Vira a Learner at Apple Developer Academy Batam. Currently focusing on mobile and web development."
    var body: some View {
        ScrollView {
            VStack {
                ZStack {
                    Image("maitri")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 150.0, height: 150.0)
                        .clipShape(Circle())
                        .padding(.bottom)
                        .shadow(radius: 5)
                }
                if edit {
                    TextField("Enter your name", text: $name)
                        .font(.body)
                        .padding(.horizontal, 5)
                        .accentColor(.gray)
                        .frame(height: 50)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                               .stroke(Color("Green"), lineWidth: 3)
                        )
                    TextField("Enter your job", text: $job)
                        .font(.body)
                        .padding(.horizontal, 5)
                        .accentColor(.gray)
                        .frame(height: 50)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                               .stroke(Color("Green"), lineWidth: 3)
                        )
                    TextEditor(text: $desc)
                        .font(.body)
                        .accentColor(.gray)
                        .frame(height: 200)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color("Green"), lineWidth: 3)
                        )
                } else {
                    Text(profile.getName().isEmpty ? name : profile.getName())
                        .font(.title2)
                        .multilineTextAlignment(.center)
                    Text(profile.getJob().isEmpty ? job : profile.getJob())
                        .font(.caption)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.gray)
                    Text(profile.getDesc().isEmpty ? desc : profile.getDesc())
                        .font(.subheadline)
                        .multilineTextAlignment(.center)
                        .padding()
                }
            }
            .padding(20)
        }
        .navigationBarTitle(Text(edit == true  ? "Edit" : "Profile"), displayMode: .inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(
            leading: Button(action: {
                edit ? edit = false : mode.wrappedValue.dismiss()
            }, label: {
                if edit {
                    Text("Cancel")
                } else {
                    Image(systemName: "arrow.left")
                        .foregroundColor(Color.white)
                }
            }),
            trailing: Button(action: {
                if edit {
                    profile.addBio(name: name, job: job, desc: desc)
                    edit = false
                } else {
                    edit = true
                    name = profile.getName().isEmpty ? name : profile.getName()
                    job = profile.getJob().isEmpty ? job : profile.getJob()
                    desc = profile.getDesc().isEmpty ? desc : profile.getDesc()
                }
            }, label: {
                if edit {
                    Text("Save")
                } else {
                    Text("Edit")
                }
            })
        )
        .gesture(DragGesture().updating($dragOffset, body: { (value, _, _) in
            if value.startLocation.x < 20 && value.translation.width > 100 {
                mode.wrappedValue.dismiss()
            }
        }))
    }
}

struct About_Previews: PreviewProvider {
    static var previews: some View {
        About(edit: false)
    }
}