#!/bin/bash

if [ $# -le 0 ]; then
    exit 1
fi

output="reeval.eps"
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
postscript('${output}', width = 6.0, height = 8.0,
           horizontal = FALSE, onefile = FALSE, paper = "special",
           family = "ComputerModern", encoding = "TeXtext.enc")

reeval = read.csv('${file}', head = F, col.names=c('instance', 'fitness'))
reeval\$instance = factor(reeval\$instance, c(${order}))
boxplot(fitness ~ instance, reeval, ylab = 'Fitness')
EOF
