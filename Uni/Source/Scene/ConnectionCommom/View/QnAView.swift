//
//  Setting.swift
//  Uni
//
//  Created by 부창현 on 2023/10/04.
//

import SwiftUI
import SDSKit

struct QnAView: View {
    
   
    @State var Shown = false
    @State var buttonClicked: ClickedButton = .none
    
    @State private var showSettingAlert = false
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var viewModel: QnAViewModel
    init(viewModel: QnAViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        
        NavigationView{
            ZStack{
                VStack(spacing: 0){
                    ZStack{
                        HStack{
                            Button(action: {
                                viewModel.popViewController()
                            }, label: {
                                Image(systemName: "chevron.left")
                                    .resizable()
                                    .foregroundColor(Color(uiColor: .gray600))
                                    .frame(width: 10.5, height: 20)
                            })
                        .frame(width: 24, height: 24)
                        .padding(.leading, 10)
                            Spacer()
                        }
                        HStack{
                            Text("문의하기")
                                .font(Font(SDSFont.subTitle.font))
                                .foregroundColor(Color(uiColor: .gray600))
                                
                        }
                    }
                    .frame(height: 52)
                    
                    /*HStack{
                        Button{}
                    label: {
                        Image(systemName: "chevron.left")
                            .resizable()
                            .foregroundColor(Color(uiColor: .gray600))
                            .frame(width: 10.5, height: 20)
                    }
                    .padding(.leading, 10)
                        
                        Spacer()
                        Text("문의하기")
                            .padding(.trailing, 10)
                        Spacer()
                        
                    }
                    .frame(height: 52)
                    */
                    
                    Link(destination: URL(string: "https://www.notion.so/UNI-38021ad1d0624528b8b56263c7868d6f")!) {
                        HStack{
                            Text("QnA")
                                .font(Font(SDSFont.body2.font))
                                .foregroundColor(Color(uiColor: .gray600))
                                .padding(.leading, 20)
                            Spacer()
                            //op 1
                            Image(systemName: "chevron.right")
                                .resizable()
                                .foregroundColor(Color(uiColor: .gray300))
                                .frame(width: 9.47, height: 15.09)
                                .padding(.trailing, 30)
                                .frame(width: 24, height: 24)
                            /*
                             //op2
                            Button{}
                        label: {
                            Image(systemName: "chevron.right")
                                .resizable()
                                .foregroundColor(Color(uiColor: .gray600))
                                .frame(width: 9.47, height: 15.09)
                        }
                        .padding(.trailing, 20)
                        .frame(width: 24, height: 24)
                            */
                        }
                        
                        .frame(height: 56)
                    }
                    HStack{
                        Button(action: {
                            viewModel.showDeleteUserAlert()
                        }, label: {
                            Text("계정 탈퇴")
                                .font(Font(SDSFont.body2.font))
                                .foregroundColor(Color(uiColor: .gray600))
                                .padding(.leading, 20)
                            Spacer()
                        })
                        .frame(height: 56)
                    }
                    ZStack{
                        Color(uiColor: .gray000).ignoresSafeArea()
                        
                        VStack(spacing: 0){
                            Spacer()
                            ZStack{
                                Rectangle()
                                    .ignoresSafeArea()
                                    .foregroundColor(Color(uiColor: .gray100))
                                //.frame(width: 400, height: 184)
                                    .padding(.bottom, 0)
                                VStack(spacing: 0){
                            
                                    HStack{
                                        Text("Contact us")
                                            .foregroundColor(Color(uiColor: .gray600))
                                            .font(Font(SDSFont.title2.font))
                                            .frame(width: 93, height: 24)
                                            .padding(.leading, 20)
                                        Spacer()
                                    }
                                    HStack(spacing: 0){
                                        Text("이메일")
                                            .foregroundColor(Color(uiColor: .gray350))
                                            .font(Font(SDSFont.caption.font))
                                            .frame(width: 32, height: 18)
                                            .padding(.leading, 20)
                                        Text("sopt.uni@gmail.com")
                                            .accentColor(Color(uiColor: .gray350))//이메일은 엑센트 컬러 사용
                                            .font(Font(SDSFont.caption.font))
                                            .frame(width: 111, height: 18)
                                            .padding(.leading, 8)
                                        Spacer()
                                    }
                                    .padding(.top, 20)
                                    HStack(spacing: 0){
                                        Text("instagram")
                                            .foregroundColor(Color(uiColor: .gray350))
                                            .font(Font(SDSFont.caption.font))
                                            .frame(width: 59, height: 18)
                                            .padding(.leading, 20)
                                        Text("sparkle.uni.official")
                                            .foregroundColor(Color(uiColor: .gray350))
                                            .font(Font(SDSFont.caption.font))
                                            .frame(width: 100, height: 18)
                                            .padding(.leading, 8)
                                        Spacer()
                                    }
                                    
                                    .padding(.top, 8)
                                    
                                }
                                .padding(.bottom, 72)
                            }
                            .frame(width: 400, height: 184)
                        }
                    }
                }
                if Shown {
                    QnAViewAlert(Shown: $Shown, buttonClicked: $buttonClicked)
                 
                }
            }
          
        }
        .navigationBarBackButtonHidden()
    }
}

struct Setting_Previews: PreviewProvider {
    static var previews: some View {
        QnAView(viewModel: .init(navigationController: .init()))
    }
}
