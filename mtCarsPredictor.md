---
title: "mtCarsPredictor"
author: "Nick Lim"
date: "22 October 2015"
output: 
  ioslides_presentation: 
    incremental: yes
    keep_md: yes
    smaller: yes
    transition: faster
    widescreen: yes
runtime: shiny
---

## Motivation

Often time, it is difficult to estimate the performance of a car, This app is written to provide an estimate of the performance in terms of fuel efficiency, engine power, quarter mile time and size from the weight of the vehicle, number of cylinders, and transmission type 
This app provides a simple user interface where users may adjust the weight and the chracteristic of the car, and visually see how the predicted performance fare against other vehicles in the market. 

## Model


From our linear model (lm(response~ wt*(am+cyl) )) we found the following performance metric 

* fuel efficiency (in MPG) = 25.13 + isManual * 15.62 + isCyl6 * -2.37 + isCyl8 * 0.34 + weight * (-0.85 + isManual * -5.30 + isCyl6 * -0.26 + isCyl8 * -1.66)

* Power (in HP) = 276.14 + isManual * -290.16 + isCyl6 * -219.57 + isCyl8 * -149.33 + weight * (-67.86 + isManual * 116.22 + isCyl6 * 84.81 + isCyl8 * 84.83)

* Quarter Mile Time (in s) = 16.76 + isManual * 0.42 + isCyl6 * -2.97 + isCyl8 * -1.51 + weight * (1.44 + isManual * -0.81 + isCyl6 * 0.16 + isCyl8 * -0.97)

* Displacement (in cu In.) = 39.46 + isManual * -23.68 + isCyl6 * -0.95 + isCyl8 * 45.39 + weight * (31.94 + isManual * 6.65 + isCyl6 * 15.25 + isCyl8 * 35.18)

## Interface {.columns-2}
![Sidebar interface](mtCarsPredictorInterface.png)

The Sidebar on the left provides a slider where the user may adjust the weight of the vehicle,
a set of radio buttons for the transmission type, and another set of radio buttons for the number of cylinders

This app can be previewed by clicking [here](https://martianunlimited.shinyapps.io/mtCarsPredictor)


## Sample output

```
## Error in eval(expr, envir, enclos): could not find function "inputPanel"
```

```
## Error in eval(expr, envir, enclos): could not find function "renderPlot"
```
