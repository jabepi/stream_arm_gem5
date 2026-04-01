BIN=./bin
SRC=./src

all: dirs serial vector

dirs:
	mkdir -p bin
	rm -f bin/*.*

serial: dirs
	${CC} -Wall -march=armv8-a -O3 -fno-vectorize -o ${BIN}/stream_serial ${SRC}/stream.c 

vector: dirs
	for SIZE in 2048 4096 8192 16384 32768 65536 131072 262144 524288 1048576 ; do \
	  ${CC} -Wall -march=armv8-a -DSTREAM_ARRAY_SIZE=$${SIZE} -DTUNED -O3 -fno-vectorize -o ${BIN}/stream_vectorial-$${SIZE}_elems ${SRC}/stream.c ; \
	done 


clean:
	rm -rf bin/
