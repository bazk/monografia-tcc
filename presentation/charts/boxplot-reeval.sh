#!/bin/bash

if [ $# -le 0 ]; then
    exit 1
fi

output="reeval"
file="/tmp/reeval.csv"

truncate --size 0 "${file}"

order=""
while [ $# -gt 0 ]; do
    instance_name="$1"
    instance_id="$2"
    shift 2

    if [ -z "${order}" ]; then
        order="'${instance_name}'"
    else
        order="${order}, '${instance_name}'"
    fi

    psql -h lys -U solace solace -c "COPY (
        SELECT '${instance_name}',value
            FROM run_result_values
            WHERE instance_id like '${instance_id}%' AND name='fitness'
            ORDER BY moment
    ) TO stdout WITH csv;" >> "${file}"
done

R --vanilla << EOF
png(filename = "${output}.png",
    width = 360, height = 500, units = "px", pointsize = 12,
    bg = "transparent",  res = NA, type = c("cairo", "cairo-png", "Xlib", "quartz"))

reeval = read.csv('${file}', head = F, col.names=c('instance', 'fitness'))
reeval\$instance = factor(reeval\$instance, c(${order}))
boxplot(fitness ~ instance, reeval, ylab = 'Fitness')
EOF
