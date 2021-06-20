ui <- miniUI::miniPage(
  shiny::tags$head(
    shiny::tags$style(htmltools::HTML(
      paste(
        sprintf(
          '@font-face {
      font-family: "Unicode BMP Fallback SIL;
      src: url("%s") format("truetype");}',
          system.file("fonts/UnicodeBMPFallback.ttf", package = "fontregisteter"))
      ))
      )
  ),
  miniUI::gadgetTitleBar("Search Your Favorite Fonts", left = NULL),
  miniUI::miniContentPanel(
    DT::dataTableOutput("fonts")
  )
)


server <- function(input, output, session) {
  family = sort(unique(systemfonts::system_fonts()$family))

  d <- data.frame(
    family = family, text = SAMPLETEXT
  )
  d <- DT::datatable(
    d,
    rownames = F
  )
  d <- DT::formatStyle(
    d,
    "text",
    valueColumns = "family",
    target = "cell",
    fontFamily = DT::styleEqual(family,  sprintf("%s, Unicode BMP Fallback SIL", family))
  )
  output$fonts <- DT::renderDataTable(d)

  shiny::observeEvent(input$done, {

    shiny::stopApp()
  })
}

font_selector <- function(){
  shiny::runGadget(ui, server, viewer = shiny::dialogViewer(dialogName = "Font Selector"))
}
font_selector()

