FROM gcc:4.9

WORKDIR /app

RUN mkdir bin
RUN mkdir results
RUN mkdir configs

COPY ./*.cpp .
COPY ./*.h .
COPY data/ data/
COPY run.sh .
COPY run.env ./configs/
COPY Makefile .


RUN make build

ENTRYPOINT [ "bash", "run.sh" ]
