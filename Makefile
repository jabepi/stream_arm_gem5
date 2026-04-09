BIN=./bin
SRC=./src

all: dirs serial vector omp

dirs:
	mkdir -p bin
	rm -f bin/*.*

serial: dirs
	${CC} -Wall -march=armv8-a -O3  -o ${BIN}/stream_serial ${SRC}/stream.c 

vector: dirs
	for SIZE in 1000000 5000000 10000000 20000000 ; do \
	  ${CC} -Wall -march=armv8-a -DSTREAM_ARRAY_SIZE=$${SIZE} -DTUNED -O3  -o ${BIN}/stream_vectorial-$${SIZE}_elems ${SRC}/stream.c ; \
	done 

omp: dirs
	${CC} -Wall -march=armv8-a -fopenmp -DSTREAM_ARRAY_SIZE=10000000 -O3 -o ${BIN}/stream_omp ${SRC}/stream.c


clean:
	rm -rf bin/
