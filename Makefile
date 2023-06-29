CXX := g++
CXXFLAGS := -O3 -march=native
all: mcsp

mcsp: mcsplit+RL.cpp graph.cpp graph.h
	$(CXX) $(CXXFLAGS) -Wall -std=c++11 -o mcsp graph.cpp mcsplit+RL.cpp -pthread

build:
	g++ -Wall -std=c++11 *.cpp -pthread -o bin/run.o

test:
	./bin/run.o min_max data/sample/test_pattern data/sample/test_target -l