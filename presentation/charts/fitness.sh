#!/bin/bash

if [ $# -le 0 ]; then
    exit 1
fi

ylim="0.2"
if [ "$1" == "-ylim" ]; then
    ylim="$2"
    shift 2
fi

output="fitness"
file="/tmp/fitness.csv"

while [ $# -gt 0 ]; do
    instance_name="$1"
    instance_id="$2"
    shift 2

    truncate --size 0 "${file}"

    psql -h lys -U solace solace -c "COPY (
        SELECT moment+1,value,'Melhor'
            FROM run_result_values
            WHERE instance_id like '${instance_id}%' AND name='best_fitness'
            ORDER BY moment
    ) TO stdout WITH csv;" >> "${file}"
    psql -h lys -U solace solace -c "COPY (
        SELECT moment+1,value,'Média'
            FROM run_result_values
            WHERE instance_id like '${instance_id}%' AND name='avg_fitness'
            ORDER BY moment
    ) TO stdout WITH csv;" >> "${file}"

    R --vanilla << EOF
library(lattice)
# lattice.options(default.theme = modifyList(standard.theme(color =  FALSE),
#                list(strip.background = list(col = "transparent"))))

theme.novpadding = list(
    layout.heights = list(
        top.padding = 0,
        main.key.padding = 0,
        key.axis.padding = 0,
        axis.xlab.padding = 0,
        xlab.key.padding = 0,
        key.sub.padding = 0,
        bottom.padding = 5
    ),
    layout.widths = list(
        left.padding = 0,
        key.ylab.padding = 0,
        ylab.axis.padding = 0,
        axis.key.padding = 0,
        right.padding = 0
    ),
    plot.symbol = list(
        col = "#c3252e"
    ),
    plot.line = list(
        col ="#c3252e"
    ),
    plot.polygon = list(
        col = "#c3252e"
    ),
    superpose.symbol = list(
        col = c("#c3252e", "#3c3cba", "#a9c33c")
    ),
    superpose.line = list(
        col= c("#c3252e", "#3c3cba", "#a9c33c")
    ),
    superpose.polygon = list(
        col = c("#c3252e", "#3c3cba", "#a9c33c")
    )
)

png(filename = "${output}-${instance_name}.png",
    width = 320, height = 250, units = "px", pointsize = 12,
    bg = "transparent",  res = NA, type = c("cairo", "cairo-png", "Xlib", "quartz"))

autokey = list(x = 0.02, y = 0.98, corner = c(0, 1),
               lines = T, points = F,
               background = 'white')

fitness = read.csv('${file}', head = F, col.names=c('generation', 'fitness', 'grouping'))
fitness\$grouping = factor(fitness\$grouping, c('Melhor', 'Média'))

xyplot(fitness ~ generation, data = fitness, groups = grouping, type = c('l'), grid = T,
       par.settings = theme.novpadding, ylab= 'Fitness', xlab='${instance_name}',
       auto.key = autokey, ylim = c(0, ${ylim}), xlim = c(0, 500))
EOF

done
