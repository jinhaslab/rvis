# app.R 파일

# 1. shiny 패키지 로드
library(shiny)

# 2. UI(사용자 인터페이스) 정의
ui <- fluidPage(
  
  # 애플리케이션 제목 설정
  titlePanel("간단한 히스토그램 Shiny 앱"),
  
  # 사이드바 레이아웃
  sidebarLayout(
    sidebarPanel(
      # 슬라이더 입력 위젯 추가
      sliderInput(inputId = "bins",
                  label = "막대(bins) 개수 선택:",
                  min = 1,
                  max = 50,
                  value = 30)
    ),
    
    # 메인 패널
    mainPanel(
      # 플롯 출력 영역 정의
      plotOutput(outputId = "distPlot")
    )
  )
)

# 3. Server(서버 로직) 정의
server <- function(input, output) {
  
  # output$distPlot에 렌더링할 플롯 생성
  output$distPlot <- renderPlot({
    # R의 내장 데이터셋인 'faithful' 사용
    x    <- faithful[, 2]  # 분출 대기 시간 데이터
    bins <- seq(min(x), max(x), length.out = input$bins + 1) # 사용자 입력에 따라 bins 계산
    
    # 히스토그램 그리기
    hist(x, breaks = bins, col = 'darkgray', border = 'white',
         xlab = '분출 대기 시간 (분)',
         main = 'Old Faithful Geyser 데이터 히스토그램')
  })
}

# 4. Shiny 앱 실행
shinyApp(ui = ui, server = server)
