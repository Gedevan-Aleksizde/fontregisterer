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
  miniUI::gadgetTitleBar("Click Any Font Family Name To Copy"),
  miniUI::miniContentPanel(
    DT::dataTableOutput("fonts")
  )
)


server <- function(input, output, session) {
  family = sort(unique(systemfonts::system_fonts()$family))
  d <- DT::datatable(
    data.frame(family = family,
    text = SAMPLETEXT),
    rownames = F,
    extensions = c("Buttons", "Select"),
    options =
      list(
        select = T,
        dom = "Bfrtip",
        buttons = list(
          list(
            extend = "copy",
            text = 'Copy Font Name',
            exportOptions = list(modifier = list(selected = T))
            )
          )
        )
      )
  d <- DT::formatStyle(
      d,
      "text",
      valueColumns = "family",
      target = "cell",
      fontFamily = DT::styleEqual(family,  sprintf("%s, Unicode BMP Fallback SIL", family))
    )
  output$fonts <- DT::renderDT(d)

  shiny::observeEvent(input$done, {

    shiny::stopApp()
  })
}

font_selector <- function(){
  shiny::runGadget(ui, server, viewer = shiny::dialogViewer(dialogName = "Font Selector"))
}

