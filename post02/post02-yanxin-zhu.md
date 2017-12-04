How to Use ggmap for Spatial Visualization
================
Yanxin Zhu
12/3/2017

``` r
library(ggplot2)
library(ggmap)
library(readr)
```

Introduction
------------

In this post, I'm going to explore ggmap and its applications in the real world. According to David Kahle and Hadley Wickham, ggmap is a new tool which enables data and models visualization by combining the spatial information of static maps from Google Maps, OpenStreetMap, Stamen Maps or CloudMade Maps with the layered grammar of graphics im- plementation of ggplot2.So I think ggmap is very beautiful and effective tool for spacial visualization. And I first would like to introduce some basic functions of ggmap, various styles of ggmaps and its advantages over other maps in R.

Basic functions of ggmap & Different looks of ggmap
---------------------------------------------------

First, we need to download a map as an image and formatting the image for plotting, so we will have a basemap to start with by simly using get\_map funcion to reach out to all the maps from Google Maps, OpenStreetMap, Stamen Maps or CloudMade Maps. same functionality as all of those combined. And we can provide get\_map with location data, color, source, maptype, and zoom of the base map. So let's start getting the map from the location's name and from googlemap.

googlemap & get\_map function

``` r
sf <- get_map("San Fransisco",zoom=13,maptype="terrain",source="google")
```

    ## Map from URL : http://maps.googleapis.com/maps/api/staticmap?center=San+Fransisco&zoom=13&size=640x640&scale=2&maptype=terrain&language=en-EN&sensor=false

    ## Information from URL : http://maps.googleapis.com/maps/api/geocode/json?address=San%20Fransisco&sensor=false

``` r
ggmap(sf)
```

![](post02_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-2-1.png)

The resource to produce the above map is googlemap, but there are many other different resources of maps with various styles in ggmap, and in the next step I am going to show you some other goodlooking maps from Stamen Maps using the function qmap,which is quick map plot and is a wrapper for ggmap and get\_map

Stamen map & qmap function

``` r
qmap("San Fransisco", zoom = 13, source = "stamen", maptype = "watercolor")
```

    ## Map from URL : http://maps.googleapis.com/maps/api/staticmap?center=San+Fransisco&zoom=13&size=640x640&scale=2&maptype=terrain&sensor=false

    ## Information from URL : http://maps.googleapis.com/maps/api/geocode/json?address=San%20Fransisco&sensor=false

    ## Map from URL : http://tile.stamen.com/watercolor/13/1309/3165.jpg

    ## Map from URL : http://tile.stamen.com/watercolor/13/1310/3165.jpg

    ## Map from URL : http://tile.stamen.com/watercolor/13/1311/3165.jpg

    ## Map from URL : http://tile.stamen.com/watercolor/13/1309/3166.jpg

    ## Map from URL : http://tile.stamen.com/watercolor/13/1310/3166.jpg

    ## Map from URL : http://tile.stamen.com/watercolor/13/1311/3166.jpg

    ## Map from URL : http://tile.stamen.com/watercolor/13/1309/3167.jpg

    ## Map from URL : http://tile.stamen.com/watercolor/13/1310/3167.jpg

    ## Map from URL : http://tile.stamen.com/watercolor/13/1311/3167.jpg

    ## Warning: `panel.margin` is deprecated. Please use `panel.spacing` property
    ## instead

![](post02_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-3-1.png)

Maptypes can be used to change the look of ggmap to look awesome.

``` r
qmap("San Fransisco", zoom = 13, source = "stamen", maptype = "toner")
```

    ## Map from URL : http://maps.googleapis.com/maps/api/staticmap?center=San+Fransisco&zoom=13&size=640x640&scale=2&maptype=terrain&sensor=false

    ## Information from URL : http://maps.googleapis.com/maps/api/geocode/json?address=San%20Fransisco&sensor=false

    ## Map from URL : http://tile.stamen.com/toner/13/1309/3165.png

    ## Map from URL : http://tile.stamen.com/toner/13/1310/3165.png

    ## Map from URL : http://tile.stamen.com/toner/13/1311/3165.png

    ## Map from URL : http://tile.stamen.com/toner/13/1309/3166.png

    ## Map from URL : http://tile.stamen.com/toner/13/1310/3166.png

    ## Map from URL : http://tile.stamen.com/toner/13/1311/3166.png

    ## Map from URL : http://tile.stamen.com/toner/13/1309/3167.png

    ## Map from URL : http://tile.stamen.com/toner/13/1310/3167.png

    ## Map from URL : http://tile.stamen.com/toner/13/1311/3167.png

    ## Warning: `panel.margin` is deprecated. Please use `panel.spacing` property
    ## instead

![](post02_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-4-1.png)

How to make a satellite graph and add a title on it?
----------------------------------------------------

``` r
qmap("SAn Fransisco", zoom = 13, maptype = "satellite") + ggtitle("Satellite Map")
```

    ## Map from URL : http://maps.googleapis.com/maps/api/staticmap?center=SAn+Fransisco&zoom=13&size=640x640&scale=2&maptype=satellite&language=en-EN&sensor=false

    ## Information from URL : http://maps.googleapis.com/maps/api/geocode/json?address=SAn%20Fransisco&sensor=false

    ## Warning: `panel.margin` is deprecated. Please use `panel.spacing` property
    ## instead

![](post02_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-5-1.png)

And a road map

``` r
qmap("San Fransisco", zoom = 13, maptype = "roadmap") + ggtitle("Road Map")
```

    ## Map from URL : http://maps.googleapis.com/maps/api/staticmap?center=San+Fransisco&zoom=13&size=640x640&scale=2&maptype=roadmap&language=en-EN&sensor=false

    ## Information from URL : http://maps.googleapis.com/maps/api/geocode/json?address=San%20Fransisco&sensor=false

    ## Warning: `panel.margin` is deprecated. Please use `panel.spacing` property
    ## instead

![](post02_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-6-1.png)

ggmap's advantage over other maps
---------------------------------

The major advantages of ggmaps include 1 layered grammar of graphics on which ggplot2 is based on 2 consisitent aesthetic scales 3 The practical advantage of using the grammar of usual ggplot2 coding conventions

And compared to other maps, ggmaps are more detailed.

Below is an exmaple of other map.

``` r
states_map <- map_data("state") #ggplot2 function to retrieve map data
ggplot(states_map, aes(x = long, y = lat, group = group)) +
geom_polygon(fill ="white" ,color = "black")
```

![](post02_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-7-1.png)

Conclusion
----------

Now you know how to use ggmaps to graph out beaufitul and statistical maps.

References
----------

1 <https://blog.dominodatalab.com/geographic-visualization-with-rs-ggmaps/> 2 <https://journal.r-project.org/archive/2013-1/kahle-wickham.pdf> 3 <http://eriqande.github.io/rep-res-web/lectures/making-maps-with-R.html> 4 <https://statisticianinstilettosblog.wordpress.com/2017/03/10/a-simple-tutorial-of-ggmap-in-r/> 5 <https://dyerlab.ces.vcu.edu/2016/01/17/a-quick-ggmap-tutorial/> 6 <http://www.milanor.net/blog/maps-in-r-introduction-drawing-the-map-of-europe/> 7 <https://www.r-bloggers.com/r-beginners-plotting-locations-on-to-a-world-map/> 8. <http://stat405.had.co.nz/ggmap.pdf>
