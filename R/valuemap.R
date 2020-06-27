#' Making colored map with sf polygons
#'
#' This function make a Leaflet object.
#' You can easily visualize your sf polygons based on "value" column.
#' You have options :
#'   background map (= map)
#'   color legend boundary values (= legend.cut)
#'   color palette for color legend (= palette)
#'   showing "value" number on center of polygons (= show.text)
#'   color for "value" number text on center of polygons (= text.color)
#' @param data A sf object with polygons who has "name" & "value" columns. "value" column must be numeric type.
#' @param map A map name of leaflet::providers
#' @param legend.cut A numeric vector which means color legend boundary values
#' @param palette A color name of RColorBrewer palettes
#' @param show.text A boolean who determines showing "value" number on center of polygons
#' @param text.color A color name for "value" number text on center of polygons
#' @return
#' An Leaflet object.
#' @export
#'
#' @examples
#' # Only run this example in interactive R sessions
#' if (interactive()) valuemap(seoul)
#'
#' # Visualize without center number on polygons
#' if (interactive()) valuemap(seoul, show.text=FALSE)
#'
#' # Emphasize great of equal to 20 polygons
#' if (interactive()) valuemap(seoul, legend.cut=c(20))
#'
#' # Change color palette & center number on polygons text color & change background map
#' if (interactive()) valuemap(seoul, map=providers$Stamen.Toner, palette='YlOrRd', text.color='blue')
#'
valuemap <- function(data,
                     map=providers$OpenStreetMap,
                     legend.cut=NULL,
                     palette='Blues',
                     show.text=TRUE,
                     text.color='black'){

  # label & highlight setting
  popup.labels <- sprintf('<strong>%s</strong><br/>value: %g', data$name, data$value) %>% lapply(htmltools::HTML)
  popup.label.options <- labelOptions(style=list(padding='3px 8px'), textsize='15px')
  highlight.options <- highlightOptions(weight=5, color='white', dashArray='', fillOpacity=.7, bringToFront=TRUE)

  # color setting
  bins <- if(is.null(legend.cut)) data$value %>% summary %>% unclass %>% unique else c(-Inf, legend.cut, Inf)
  pals <- colorBin(palette, domain=data$value, bins=bins)

  # base plot
  base.map <- leaflet(data) %>% addProviderTiles(provider=map)

  # plot detail
  if(show.text){
    centers <- suppressWarnings(st_centroid(data))
    labels <- sprintf('<strong>%g</strong>', data$value) %>% lapply(htmltools::HTML)
    label.options <- labelOptions(noHide=TRUE, direction='center', textOnly=TRUE, textsize='12px', style=list(color=text.color))

    base.map %>%
      addPolygons(
        color='white', weight=2, opacity=1, dashArray=3,
        fillColor=~pals(value), fillOpacity=.7, highlightOptions=highlight.options,
        label=popup.labels, labelOptions=popup.label.options
      ) %>%
      addLabelOnlyMarkers(data=centers, label=labels, labelOptions=label.options) %>%
      addLegend(pal=pals, values=data$value, opacity=.7, title=NULL, position='bottomright')
  }else{
    base.map %>%
      addPolygons(
        color='white', weight=2, opacity=1, dashArray=3,
        fillColor=~pals(value), fillOpacity=.7, highlightOptions=highlight.options,
        label=popup.labels, labelOptions=popup.label.options
      ) %>%
      addLegend(pal=pals, values=data$value, opacity=.7, title=NULL, position='bottomright')
  }
}
