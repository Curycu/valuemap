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
#' @param data A sf object with polygons who has "name" & "value" columns ("value" column must be numeric type)
#' @param map A map name of leaflet::providers
#' @param legend.cut A numeric vector which means color legend boundary values
#' @param palette A color name of RColorBrewer palettes
#' @param show.text A boolean who determines showing "value" number on center of polygons
#' @param text.color A color name for "value" number text on center of polygons
#' @param text.format A format function for "value" number text on center of polygons
#' @return
#' An Leaflet object.
#' @export
#'
#' @examples
#' # Only run this example in interactive R sessions
#' if (interactive()) valuemap(seoul)
#'
#' # Emphasize great of equal to 20 polygons
#' if (interactive()) valuemap(seoul, legend.cut=c(20))
#'
#' # Visualize without center number on polygons
#' if (interactive()) valuemap(seoul, legend.cut=c(15,17,20), show.text=FALSE)
#'
#' # Change color palette & center number on polygons text color, format & change background map
#' if (interactive())
#'   valuemap(
#'     seoul, map=providers$Stamen.Toner, palette='YlOrRd',
#'     text.color='blue', text.format=function(x) paste(x,'EA')
#'   )
valuemap <- function(data,
                     map=leaflet::providers$OpenStreetMap,
                     legend.cut=NULL,
                     palette='Blues',
                     show.text=TRUE,
                     text.color='black',
                     text.format=function(x) x){

  # label & highlight setting
  popup.labels <- sprintf('<strong>%s</strong><br/>value: %s', data$name, text.format(data$value)) %>% lapply(htmltools::HTML)
  popup.label.options <- leaflet::labelOptions(style=list(padding='3px 8px'), textsize='15px')
  highlight.options <- leaflet::highlightOptions(weight=5, color='white', dashArray='', fillOpacity=.7, bringToFront=TRUE)

  # color setting
  bins <- if(is.null(legend.cut)) data$value %>% summary %>% unclass %>% unique else c(-Inf, legend.cut, Inf)
  pals <- leaflet::colorBin(palette, domain=data$value, bins=bins)

  # base plot
  base.map <- leaflet::leaflet(data) %>% leaflet::addProviderTiles(provider=map)

  # plot detail
  if(show.text){
    centers <- suppressWarnings(sf::st_centroid(data))
    labels <- sprintf('<strong>%s</strong>', text.format(data$value)) %>% lapply(htmltools::HTML)
    label.options <- leaflet::labelOptions(noHide=TRUE, direction='center', textOnly=TRUE, textsize='12px', style=list(color=text.color))

    base.map %>%
      leaflet::addPolygons(
        color='white', weight=2, opacity=1, dashArray=3,
        fillColor=~pals(value), fillOpacity=.7, highlightOptions=highlight.options,
        label=popup.labels, labelOptions=popup.label.options
      ) %>%
      leaflet::addLabelOnlyMarkers(data=centers, label=labels, labelOptions=label.options) %>%
      leaflet::addLegend(pal=pals, values=data$value, opacity=.7, title=NULL, position='bottomright')
  }else{
    base.map %>%
      leaflet::addPolygons(
        color='white', weight=2, opacity=1, dashArray=3,
        fillColor=~pals(value), fillOpacity=.7, highlightOptions=highlight.options,
        label=popup.labels, labelOptions=popup.label.options
      ) %>%
      leaflet::addLegend(pal=pals, values=data$value, opacity=.7, title=NULL, position='bottomright')
  }
}

#' Making colored map with data.frame of h3 address
#'
#' This function make a Leaflet object.
#' You can easily visualize your data.frame with h3 address "name" column based on "value" column.
#' You have options :
#'   background map (= map)
#'   color legend boundary values (= legend.cut)
#'   color palette for color legend (= palette)
#'   showing "value" number on center of polygons (= show.text)
#'   color for "value" number text on center of polygons (= text.color)
#' @param data A data.frame object who has "h3_addr" & "value" columns ("value" column must be numeric type)
#' @param map A map name of leaflet::providers
#' @param legend.cut A numeric vector which means color legend boundary values
#' @param palette A color name of RColorBrewer palettes
#' @param show.text A boolean who determines showing "value" number on center of polygons
#' @param text.color A color name for "value" number text on center of polygons
#' @param text.format A format function for "value" number text on center of polygons
#' @return
#' An Leaflet object.
#' @export
#'
#' @examples
#' if (interactive()){
#'   seoul_h3 %>%
#'     h3_valuemap(legend.cut=1:6, show.text=FALSE)
#' }
h3_valuemap <- function(data,
                        map=providers$OpenStreetMap,
                        legend.cut=NULL,
                        palette='Blues',
                        show.text=TRUE,
                        text.color='black',
                        text.format=function(x) x){

  if(!'devtools' %in% installed.packages()){
    message('install devtools package to use devtools::install_github...')
    rp <- c('https://cran.rstudio.com/')
    names(rp) <- 'CRAN'
    install.packages('devtools', repos=rp)
  }

  if(!'h3jsr' %in% installed.packages()){
    message('install h3jsr package to make h3 polygons from h3 address...')
    devtools::install_github('obrl-soil/h3jsr')
  }

  data %>%
    dplyr::mutate(geometry = h3jsr::h3_to_polygon(data$name)) %>%
    sf::st_as_sf %>%
    dplyr::select(data$name, data$value) %>%
    valuemap(
      map=map,
      legend.cut=legend.cut,
      palette=palette,
      show.text=show.text,
      text.color=text.color,
      text.format=text.format
    )
}

#' Making colored map with data.frame of Korea administrative area code
#'
#' This function make a Leaflet object.
#' You can easily visualize your data.frame with administrative area code "name" column based on "value" column.
#' You have options :
#'   background map (= map)
#'   color legend boundary values (= legend.cut)
#'   color palette for color legend (= palette)
#'   showing "value" number on center of polygons (= show.text)
#'   color for "value" number text on center of polygons (= text.color)
#'   administrative area code type by digit (= code.digit)
#' @param data A data.frame object who has "code" & "value" columns ("value" column must be numeric type)
#' @param map A map name of leaflet::providers
#' @param legend.cut A numeric vector which means color legend boundary values
#' @param palette A color name of RColorBrewer palettes
#' @param show.text A boolean who determines showing "value" number on center of polygons
#' @param text.color A color name for "value" number text on center of polygons
#' @param text.format A format function for "value" number text on center of polygons
#' @param code.digit A integer meaning korea administrative area code type
#' @return
#' An Leaflet object.
#' @export
#'
#' @examples
#' if (interactive()){
#'   suwon %>%
#'     korea_valuemap(legend.cut=c(10,20,30,40), show.text=FALSE)
#' }
korea_valuemap <- function(data,
                           map=providers$OpenStreetMap,
                           legend.cut=NULL,
                           palette='Blues',
                           show.text=TRUE,
                           text.color='black',
                           text.format=function(x) x,
                           code.digit=7){

  if(code.digit == 7){
    data %>%
      dplyr::select(data$name, data$value) %>%
      dplyr::inner_join(valuemap::korea, by=c('name'='hcode_7')) %>%
      sf::st_as_sf %>%
      dplyr::select(data$name, data$value) %>%
      valuemap(
        map=map,
        legend.cut=legend.cut,
        palette=palette,
        show.text=show.text,
        text.color=text.color,
        text.format=text.format
      )
  }else{
    data %>%
      dplyr::select(data$name, data$value) %>%
      dplyr::inner_join(valuemap::korea, by=c('name'='hcode_10')) %>%
      sf::st_as_sf %>%
      dplyr::select(data$name, data$value) %>%
      valuemap(
        map=map,
        legend.cut=legend.cut,
        palette=palette,
        show.text=show.text,
        text.color=text.color,
        text.format=text.format
      )
  }
}
