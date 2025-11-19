# 기본 Shiny 앱 예제
# 실행: shiny::runApp("code/shiny_apps/01_basic_app")

library(shiny)
library(ggplot2)

# UI: 사용자가 보는 화면
ui <- fluidPage(
  titlePanel("첫 번째 Shiny 앱"),

  sidebarLayout(
    sidebarPanel(
      sliderInput(
        "num_points",
        "점의 개수:",
        min = 10,
        max = 200,
        value = 50
      )
    ),

    mainPanel(
      plotOutput("scatter_plot")
    )
  )
)

# Server: 실제 연산이 일어나는 곳
server <- function(input, output) {

  output$scatter_plot <- renderPlot({
    # input$num_points 값에 따라 자동으로 재실행됨!
    n <- input$num_points

    data <- data.frame(
      x = rnorm(n),
      y = rnorm(n)
    )

    ggplot(data, aes(x, y)) +
      geom_point(color = "steelblue", size = 3) +
      labs(title = paste("N =", n, "개 점")) +
      theme_minimal()
  })
}

# 앱 실행
shinyApp(ui = ui, server = server)
