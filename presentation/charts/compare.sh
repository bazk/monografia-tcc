#!/bin/bash

if [ $# -le 0 ]; then
    exit 1
fi

ylim="0.2"
if [ "$1" == "-ylim" ]; then
    ylim="$2"
    shift 2
fi

output="compare"
file="/tmp/compare.csv"

# truncate --size 0 "${file}"

# while [ $# -gt 0 ]; do
#     instance_name="$1"
#     instance_id="$2"
#     shift 2

#     psql -h lys -U solace solace -c "COPY (
#         SELECT '${instance_name}',value
#             FROM run_result_values
#             WHERE instance_id like '${instance_id}%' AND name='best_fitness'
#                 AND moment >= ALL (SELECT moment FROM run_result_values
#                     WHERE instance_id like '${instance_id}%' AND name='best_fitness')
#     ) TO stdout WITH csv;" >> "${file}"
# #    psql -h lys -U solace solace -c "COPY (
# #        SELECT '${instance_name}',value,'Média'
# #            FROM run_result_values
# #            WHERE instance_id like '${instance_id}%' AND name='avg_fitness'
# #                AND moment = 499
# #    ) TO stdout WITH csv;" >> "${file}"
# done

R --vanilla << EOF
library(lattice)

png(filename = "${output}.png",
    width = 500, height = 450, units = "px", pointsize = 12,
    bg = "transparent",  res = NA, type = c("cairo", "cairo-png", "Xlib", "quartz"))

autokey = list(x = 0.72, y = 0.98, corner = c(0, 1),
               lines = F, points = F,
               background = 'white')

fitness = read.csv('${file}', head = F, col.names=c('instance', 'fitness'))

min = aggregate(fitness ~ instance, data = fitness, FUN = min)
mean = aggregate(fitness ~ instance, data = fitness, FUN = mean)
max = aggregate(fitness ~ instance, data = fitness, FUN = max)

min['grouping'] = 'Mínima'
mean['grouping'] = 'Média'
max['grouping'] = 'Máxima'

m = rbind(min, mean, max)

m\$instance = factor(m\$instance, levels = c('GA', 'CGPGA', 'PSO', 'DPSO'), ordered = T)

barchart(fitness ~ instance, data = m[order(m\$instance),], group = grouping, type = c('p'), grid = T,
        ylab= 'Fitness', auto.key = autokey, ylim = c(0, ${ylim}), par.settings = simpleTheme(col=c("#c3252e", "#eeba28", "#a9c33c")) )
EOF
