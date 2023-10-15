
//
//  NickNameSetting.swift
//  Uni
//
//  Created by 부창현 on 2023/10/07.
//

import SwiftUI
import SDSKit

struct NickNameInputView: View {
    @Environment(\.presentationMode) var presentationMode//네비게이션 링크로 현재 뷰와 연결되면 이 버튼 누르면 원래 버튼으로 이동
    @State var Shown = false
    @State var buttonClicked: ClickedButton = .none
    @State private var showAlert = false
    //@State private var showingSettingView = false
    @State private var text: String = ""
    @State private var color: Color = Color(uiColor: .gray200)
    @State private var count: Int = 0
    
    var body: some View {
        NavigationView{
            
            ZStack{
                Color(uiColor: .gray000).ignoresSafeArea()
                
                
                VStack(spacing: 0){
                    //쉐브론 영역
                    HStack{
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()//네비게이션 링크로 현재 뷰와 연결되면 이 버튼 누르면 원래 버튼으로 이동
                        },
                               
                               
                               label: {
                            Image(systemName: "chevron.left")
                                .resizable()
                                .frame(width: 10.5, height: 20)
                                .foregroundColor(Color(uiColor: .gray600))
                        })
                        .frame(width: 24, height:24)
                        .padding(.leading, 10)
                        Spacer()
                    }
                    .frame(width: 375, height: 52)
                    //텍스트 영역
                    VStack{
                        HStack{
                            Text("사용할 닉네임을 입력하세요")
                                .font(Font(SDSFont.subTitle.font))
                                .foregroundColor(Color(uiColor: .gray600))
                                .frame(height: 24)
                                .padding(.leading, 20)
                            Spacer()
                        }
                        HStack{
                            Text("내 애인이 나를 부르는 애칭은 무엇인가요?")
                                .font(Font(SDSFont.body2Long.font))
                                .foregroundColor(Color(uiColor: .gray350))
                                .frame(height: 20)
                                .padding(.top, 6)
                                .padding(.leading, 20)
                            Spacer()
                        }
                        
                    }
                    .frame(width: 375, height: 82)
                    .padding(.top, 42)
                    //텍스트필드 영역
                    VStack{
                    VStack{
                        
                        
                        TextField("닉네임", text: $text)
                            .padding(.leading, 14)
                            .frame(width: 335, height: 48)
                            .accentColor(Color(uiColor: .lightBlue500))//임의로 지정함
                            .foregroundColor(Color(uiColor: .gray600))
                            .font(Font(SDSFont.body2Long.font))
                            .onChange(of: text) { text in
                                if text.count > 10 {
                                           // Truncate the text to 10 characters
                                    self.text = String(text.prefix(10))
                                       }

                                
                                let letters = text.trimmingCharacters(in: .whitespaces).count
                                self.count = letters
                                switch letters {
                                case 1..<6:
                                    self.color = Color(uiColor: .lightBlue500)
                                case 6..<11:
                                    self.color = Color(uiColor: .red500)
                                default:
                                    self.color = Color(uiColor: .gray200)
                                
                                }
                                
                                
                            }
                        /* .frame(width: 335, height: 48)
                         .padding(.leading, 15)
                         
                         .cornerRadius(10)
                         .background(Color(uiColor: .gray000))
                         .border(Color(uiColor: .gray200))
                         .textFieldStyle(.roundedBorder)*/
                        
                        
                        
                        
                    }
                    .foregroundColor(Color(uiColor: .gray200))
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(color, lineWidth: 1))
                    .padding(.top, 11)
                        HStack(spacing: 4){
                            Text("글자수를 초과했어요")
                                .font(Font(SDSFont.caption.font))
                             
                            .foregroundColor(self.count > 5 ? Color(uiColor: .red500) : Color(uiColor: .gray000))
                                
                        Spacer()
                        Text("\(count)")
                            .font(Font(SDSFont.caption.font))
                   
                            .foregroundColor(self.count > 5 ? Color(uiColor: .red500) : Color(uiColor: .gray400))
                            .frame(width: 13, height: 18)
                            Text("/")
                                .font(Font(SDSFont.caption.font))
                        
                                .foregroundColor(self.count > 5 ? Color(uiColor: .red500) : Color(uiColor: .gray400))
                                .frame(width: 5, height: 18)
                          
                        Text("5")
                            .font(Font(SDSFont.caption.font))
                       
                            .foregroundColor(self.count > 5 ? Color(uiColor: .red500) : Color(uiColor: .gray400))
                            .frame(width: 8, height: 18)
                            .padding(.trailing, 1)
                        
                            
                        
                    }
                        //.frame(width: 335, height: 18)
                       // .padding(.top, 4)
                }
                    .frame(width: 335, height: 70)
                    Spacer()
                    
                    
                    
                    
                    //문의하기, 로그아웃 영역
                    HStack{
                        
                        NavigationLink(destination: QnAView(), label: {
                            Text("문의하기")
                                .font(Font(SDSFont.body2.font))
                                .foregroundColor(Color(uiColor: .gray300))
                                .frame(width: 69, height: 28)
                                .padding(.leading, 20)
                            
                        })
                        /* NavigationLink(destination: Setting()) {
                         Text("문의하기")
                         .font(Font(SDSFont.body2.font))
                         .foregroundColor(Color(uiColor: .gray300))
                         .frame(width: 69, height: 28)
                         .padding(.leading, 20)
                         }
                         */
                        /*  Button("문의하기"){
                         
                         }
                         .font(Font(SDSFont.body2.font))
                         .foregroundColor(Color(uiColor: .gray300))
                         .frame(width: 69, height: 28)
                         .padding(.leading, 20)
                         */
                        
                        /* label: {
                         Text("문의하기")
                         .font(Font(SDSFont.body2.font))
                         .foregroundColor(Color(uiColor: .gray300))
                         .frame(width: 69, height: 28)
                         .padding(.leading, 20)
                         }*/
                        //   NavigationLink("", destination: Setting(), isActive: $showingSettingView)
                        
                        Spacer()
                        
                        Button{
                            Shown.toggle()
                        }
                    label: {
                        Text("로그아웃")
                            .font(Font(SDSFont.body2.font))
                            .foregroundColor(Color(uiColor: .gray300))
                            .frame(width: 69, height: 28)
                            .padding(.trailing, 20)
                    }
                    }
                    .frame(width: 375, height: 28)
                    
                    Button{}
                label: {
                    ZStack{
                        Rectangle()
                            .frame(width: 335, height: 48)
                            .cornerRadius(10)
                          //  .foregroundColor(Color(uiColor: .gray300))
                            .foregroundColor( self.count < 6 && self.count >= 1 ? Color(uiColor: .lightBlue500) : Color(uiColor: .gray300))
                        Text("다음")
                            .font(Font(SDSFont.subTitle.font))
                            .foregroundColor(Color(uiColor: .gray000))
                            
                        
                    }
                }
                .frame(width: 375, height: 80)
                    
                    
                    
                }
                if Shown {
                    NickNameViewLogOutAlert(Shown: $Shown, buttonClicked: $buttonClicked)
                    
                }
                
                
            }
        }
    }
    
}

struct NickNameSettingView_Previews: PreviewProvider {
    static var previews: some View {
        NickNameInputView()
    }

}

//남은 일:  다음 버튼 활성화 구현
//글자수가 맞게 뜰 떄 버튼 컬러 변경 및 네비게이션 링크가 activated되어야 하고 아닐 경우 pass navigation link는 다음 페이지로 연결, 오늘 집에 와서 찾아보자,
