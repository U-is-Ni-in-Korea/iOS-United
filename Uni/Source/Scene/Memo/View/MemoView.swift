//
//  MemoView.swift
//  Uni
//
//  Created by 부창현 on 2023/09/10.
//

import SwiftUI
import SDSKit

struct MemoView: View {
    @State var Shown = false
    @State var buttonClicked: ClickedButton = .none
    @State private var memoText: String = ""
    @State private var showAlert = false
    
    @Environment (\.dismiss) var dismiss
    @Environment(\.presentationMode) var presentationMode//
    

    var body: some View {
        
        
        NavigationView{
            ZStack {
                Color(uiColor: .gray100).ignoresSafeArea()
                //배경(텍스트 에디터 밖 영역) 색 채우기 용
                let placeHolder: String = "묻고 답한 내용을 기록해보세요"
                //placeHolder용 코드입니다.
                
                TextEditor(text: $memoText)
                    .accentColor(Color(uiColor: .lightBlue600))
                    //커서 색 변경 속성->accentColor
                    .colorMultiply(Color(uiColor: .gray100))//텍스트 에디터 내 색을 변경하기 위해선 백그라운드()가 아니라 컬러멀티플라이 사용!!!
                    .frame(minWidth: 327, maxWidth: 500, minHeight: 0, maxHeight: .infinity)
                    .border(Color.black, width: 0) // 테두리 스타일을 설
                 //   .navigationTitle("메모장")
                    .font(Font(SDSFont.body1Regular.font))
                    .foregroundColor(Color(uiColor: .gray600))
                    .navigationBarTitle(Text("메모장").font(Font(SDSFont.subTitle.font)), displayMode: .inline)
                    .padding(.top, 16)
                    .padding(.leading, 24)
                    .toolbar{
                        ToolbarItem(placement: .navigationBarLeading){
                            
                            VStack {
                                HStack{
                                    Button{
                                        Shown.toggle()
                                        
                                    }
                                    
                                label: {
                                    Image(systemName: "chevron.left")
                                        .foregroundColor(Color(uiColor: .gray600))
                                    //이거 gray900이라는데 이거 머임
                                    }
                                }
                            }
                        }
                    }
              
                VStack{
                    HStack{
                        
                        if memoText.isEmpty{
                            Text(placeHolder)
                                .padding(.top, 24)
                                .padding(.leading, 28)
                                .foregroundColor(Color(uiColor: .gray300))
                                .font(Font(SDSFont.body1Regular.font))
                            //placeHolder용 코드입니다.
                            
                            
                        }
                        Spacer()
                    }
                    Spacer()
                }
                if Shown {
                    CustomAlertView(Shown: $Shown, buttonClicked: $buttonClicked)
                    //왜 if의 위치가 여기여야 했는지 다시 생각해 보자
                }
                
                
            }
            
            
            
        }
        
    }
}


struct MemoView_Previews: PreviewProvider {
    static var previews: some View {
        MemoView()
    }
}

