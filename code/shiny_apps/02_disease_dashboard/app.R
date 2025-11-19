# 감염병 감시 대시보드
# 실행: shiny::runApp("code/shiny_apps/02_disease_dashboard")

library(shiny)
library(tidyverse)
library(plotly)
library(DT)

# 모의 데이터 생성
set.seed(42)
disease_data <- tibble(
  date = rep(seq.Date(as.Date("2024-01-01"), by = "day", length.out = 365), 3),
  region = rep(c("서울", "부산", "대구"), each = 365),
  cases = rpois(365 * 3, lambda = 50) + rnorm(365 * 3, mean = 0, sd = 10),
  deaths = rpois(365 * 3, lambda = 2)
) %>%
  mutate(
    cases = pmax(0, cases),  # 음수 제거
    deaths = pmax(0, deaths),
    cfr = deaths / cases * 100  # Case Fatality Rate
  )

# UI
ui <- fluidPage(
  # 제목
  titlePanel(
    div(
      style = "background-color: #2C3E50; color: white; padding: 20px; margin: -15px -15px 20px -15px;",
      h1("감염병 실시간 감시 대시보드", style = "margin: 0;"),
      p("Infectious Disease Surveillance System", style = "margin: 5px 0 0 0; font-size: 14px;")
    )
  ),

  # 레이아웃
  sidebarLayout(
    sidebarPanel(
      width = 3,

      h4("📊 필터 옵션"),

      selectInput(
        "region_select",
        "지역 선택:",
        choices = c("전체" = "All", "서울", "부산", "대구"),
        selected = "All"
      ),

      dateRangeInput(
        "date_range",
        "기간 선택:",
        start = as.Date("2024-01-01"),
        end = as.Date("2024-12-31"),
        min = as.Date("2024-01-01"),
        max = as.Date("2024-12-31")
      ),

      hr(),

      h4("📈 표시 옵션"),

      checkboxInput("show_deaths", "사망자 표시", value = TRUE),

      hr(),

      actionButton("update", "업데이트", class = "btn-primary btn-block")
    ),

    mainPanel(
      width = 9,

      # 요약 통계 카드
      fluidRow(
        column(
          3,
          div(
            style = "background-color: #3498DB; color: white; padding: 15px; border-radius: 5px;",
            h4("총 확진자", style = "margin: 0;"),
            h2(textOutput("total_cases", inline = TRUE), style = "margin: 10px 0 0 0;")
          )
        ),
        column(
          3,
          div(
            style = "background-color: #E74C3C; color: white; padding: 15px; border-radius: 5px;",
            h4("총 사망자", style = "margin: 0;"),
            h2(textOutput("total_deaths", inline = TRUE), style = "margin: 10px 0 0 0;")
          )
        ),
        column(
          3,
          div(
            style = "background-color: #F39C12; color: white; padding: 15px; border-radius: 5px;",
            h4("평균 CFR", style = "margin: 0;"),
            h2(textOutput("avg_cfr", inline = TRUE), style = "margin: 10px 0 0 0;")
          )
        ),
        column(
          3,
          div(
            style = "background-color: #27AE60; color: white; padding: 15px; border-radius: 5px;",
            h4("관찰 기간", style = "margin: 0;"),
            h2(textOutput("obs_days", inline = TRUE), style = "margin: 10px 0 0 0;")
          )
        )
      ),

      br(),

      # 탭 패널
      tabsetPanel(
        type = "tabs",

        # 탭 1: 시계열 그래프
        tabPanel(
          "시계열 추세",
          br(),
          plotlyOutput("time_series_plot", height = "500px")
        ),

        # 탭 2: 지역별 비교
        tabPanel(
          "지역별 비교",
          br(),
          plotlyOutput("region_comparison", height = "500px")
        ),

        # 탭 3: 데이터 테이블
        tabPanel(
          "데이터 테이블",
          br(),
          DTOutput("data_table")
        )
      )
    )
  )
)

# Server
server <- function(input, output, session) {

  # 반응형 데이터
  filtered_data <- reactive({
    data <- disease_data

    # 지역 필터
    if (input$region_select != "All") {
      data <- data %>% filter(region == input$region_select)
    }

    # 날짜 필터
    data <- data %>%
      filter(date >= input$date_range[1],
             date <= input$date_range[2])

    data
  }) %>% bindEvent(input$update)

  # 요약 통계
  output$total_cases <- renderText({
    format(sum(filtered_data()$cases), big.mark = ",")
  })

  output$total_deaths <- renderText({
    format(sum(filtered_data()$deaths), big.mark = ",")
  })

  output$avg_cfr <- renderText({
    cfr <- mean(filtered_data()$cfr, na.rm = TRUE)
    paste0(round(cfr, 2), "%")
  })

  output$obs_days <- renderText({
    n_days <- length(unique(filtered_data()$date))
    paste(n_days, "일")
  })

  # 시계열 플롯
  output$time_series_plot <- renderPlotly({
    data <- filtered_data()

    p <- ggplot(data, aes(x = date)) +
      geom_line(aes(y = cases, color = region), linewidth = 1) +
      labs(
        title = "일일 확진자 추세",
        x = "날짜",
        y = "확진자 수",
        color = "지역"
      ) +
      theme_minimal(base_size = 12)

    # 사망자 추가
    if (input$show_deaths) {
      p <- p + geom_line(aes(y = deaths * 10, linetype = "사망자 (×10)"),
                         color = "red", linewidth = 0.8, alpha = 0.7)
    }

    ggplotly(p) %>%
      layout(hovermode = "x unified")
  })

  # 지역별 비교
  output$region_comparison <- renderPlotly({
    data <- filtered_data() %>%
      group_by(region) %>%
      summarize(
        total_cases = sum(cases),
        total_deaths = sum(deaths),
        avg_cfr = mean(cfr, na.rm = TRUE)
      )

    plot_ly(data) %>%
      add_bars(
        x = ~region,
        y = ~total_cases,
        name = "총 확진자",
        marker = list(color = "#3498DB")
      ) %>%
      layout(
        title = "지역별 총 확진자",
        xaxis = list(title = "지역"),
        yaxis = list(title = "확진자 수")
      )
  })

  # 데이터 테이블
  output$data_table <- renderDT({
    datatable(
      filtered_data() %>%
        select(날짜 = date, 지역 = region, 확진자 = cases,
               사망자 = deaths, CFR = cfr) %>%
        mutate(CFR = round(CFR, 2)),
      options = list(
        pageLength = 20,
        lengthMenu = c(10, 20, 50, 100),
        searching = TRUE,
        ordering = TRUE
      ),
      filter = "top",
      rownames = FALSE
    )
  })
}

# 앱 실행
shinyApp(ui, server)
