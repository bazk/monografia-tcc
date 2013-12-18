#!/bin/bash

# bash ./boxplot-reeval.sh f1 3a44b244 f2 effa05e7 f3 90cab6f2 f4 d6ee63e3
# bash ./fitness.sh -ylim 0.28 f1 2205d0d9 f2 6845e02a f3 4fe33877 f4 6a55ee51
# bash ./fitness.sh GA aff92ce4 CGPGA 6b9fca40 PSO 9374890a DPSO 0266861b
bash ./compare.sh -ylim 0.25 GA aff92ce4 GA 3ba45ee9 GA 6845e02a GA 0ba989c4 GA 2ca4870e CGPGA 6b9fca40 CGPGA e921b673 CGPGA 6232ef7f CGPGA 41aa8198 CGPGA f7c3d636 PSO 9374890a PSO 86fc81aa PSO fcef30cc PSO cb8cd444 PSO f5ba68e6 DPSO 0266861b DPSO 58bd6026 DPSO 6aac4564 DPSO e646480b DPSO 9aaa97fb
# bash ./elitism.sh "Com elitismo" aff92ce4 "Com elitismo" 3ba45ee9 "Com elitismo" 6845e02a "Sem elitismo" 80f6ea47 "Sem elitismo" c07c3b9b "Sem elitismo" e5ec623a
# bash ./mutation.sh 0.03 6845e02a 0.04 6a2fcc28 0.01 8e33cc58 0.10 d01f7e9f