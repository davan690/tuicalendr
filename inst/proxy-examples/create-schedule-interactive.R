

library(shiny)
library(tuicalendr)

ui <- fluidPage(
  tags$h2("Create schedule(s) into calendar"),
  calendarOutput(outputId = "my_calendar"),
  tags$b("Last created schedule:"),
  verbatimTextOutput(outputId = "created")
)

server <- function(input, output, session) {
  
  output$my_calendar <- renderCalendar({
    calendar(defaultView = "month", useCreationPopup = TRUE, readOnly = FALSE) %>% 
      set_calendars_props(id = "a", name = "Schedule A", color = "#FFF", bgColor = "#E41A1C") %>% 
      set_calendars_props(id = "b", name = "Schedule B", color = "#FFF", bgColor = "#377EB8") %>% 
      set_calendars_props(id = "c", name = "Schedule C", color = "#FFF", bgColor = "#4DAF4A")
  })
  
  observeEvent(input$my_calendar_add, {
    calendarProxy("my_calendar") %>%
      cal_proxy_create(
        .list = input$my_calendar_add
      )
  })
  
  output$created <- renderPrint({
    input$my_calendar_add
  })

}

shinyApp(ui, server)
