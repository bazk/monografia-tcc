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
lattice.options(default.theme = modifyList(standard.theme(color =  FALSE),
                list(strip.background = list(col = "transparent"))))

postscript('${output}-${instance_name}.eps', width = 6.0, height = 4.5,
           horizontal = FALSE, onefile = FALSE, paper = "special")

autokey = list(x = 0.02, y = 0.98, corner = c(0, 1),
               lines = T, points = F,
               background = 'white')

fitness = read.csv('${file}', col.names=c('generation', 'fitness', 'grouping'))
fitness\$grouping = factor(fitness\$grouping, c('Melhor', 'Média'))

xyplot(fitness ~ generation, data = fitness, groups = grouping, type = c('l'), grid = T,
ylab= 'Fitness', xlab='Gerações', auto.key = autokey, ylim = c(0, ${ylim}), xlim = c(0, 500))
EOF

done
