
<!-- README.md is generated from README.Rmd. Please edit that file -->
valuemap
========

<!-- badges: start -->
<!-- badges: end -->
The goal of valuemap is to save data analysts' efforts & time with pre-setting sf polygon visualization.

Installation
------------

You can install the released version of valuemap from [GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("Curycu/valuemap")
```

How to Use?
-----------

**Your sf data must have two columns named as `name` & `value`**
- `name` column is used for mouse over popup information
- `value` column is used for mouse over popup information & color polygons & display center number of polygons

``` r
library(valuemap)

seoul
#> Simple feature collection with 25 features and 2 fields
#> geometry type:  POLYGON
#> dimension:      XY
#> bbox:           xmin: 126.7643 ymin: 37.42901 xmax: 127.1836 ymax: 37.70108
#> geographic CRS: WGS 84
#> # A tibble: 25 x 3
#>    name  value                                                          geometry
#>    <chr> <int>                                            <POLYGON [arc_degree]>
#>  1 1111     17 ((126.969 37.56819, 126.968 37.56718, 126.9679 37.5671, 126.9673~
#>  2 1114     15 ((127.0163 37.55301, 127.0132 37.54994, 127.0117 37.54851, 127.0~
#>  3 1117     16 ((126.9825 37.51351, 126.9801 37.51212, 126.9756 37.5123, 126.96~
#>  4 1120     17 ((127.0628 37.54019, 127.0566 37.5291, 127.0491 37.53255, 127.04~
#>  5 1121     15 ((127.0923 37.52679, 127.0904 37.526, 127.0885 37.52549, 127.087~
#>  6 1123     14 ((127.0786 37.57186, 127.0782 37.57094, 127.0778 37.57008, 127.0~
#>  7 1126     16 ((127.0958 37.5711, 127.0957 37.5711, 127.0955 37.57105, 127.095~
#>  8 1129     20 ((127.0245 37.5792, 127.0232 37.57804, 127.0225 37.5781, 127.018~
#>  9 1130     13 ((127.022 37.61229, 127.0207 37.6125, 127.0206 37.61252, 127.020~
#> 10 1132     14 ((127.0464 37.63916, 127.0455 37.63783, 127.0453 37.63749, 127.0~
#> # ... with 15 more rows
```

#### Example 1

##### Quick & easy visualization of sf polygons with value

    valuemap(seoul)

![](example_1.PNG)

#### Example 2

##### Emphasize greater or equal to 20 polygons (&gt;= 20, &lt; 20 : two level only)

    valuemap(seoul, legend.cut=c(20))

![](example_2.PNG)

#### Example 3

##### Visualize without center number on polygons

    valuemap(seoul, legend.cut=c(15,17,20), show.text=FALSE)

![](example_3.PNG)

#### Example 4

##### Change color palette & center number on polygons text color, format & change background map

    valuemap(
      seoul, map=providers$Stamen.Toner, palette='YlOrRd',
      text.color='blue', text.format=function(x) paste(x,'EA')
    )

![](example_4.PNG)
