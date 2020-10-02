FROM markadams/chromium-xvfb

ENV DEBIAN_FRONTEND noninteractive
ENV CHROMEDRIVER_SHA256 2461384f541346bb882c997886f8976edc5a2e7559247c8642f599acd74c21d4

RUN apt-get update && apt-get install -y \
    python3 python3-pip curl unzip

RUN pip3 install pytest selenium

RUN curl -SLO "https://chromedriver.storage.googleapis.com/2.36/chromedriver_linux64.zip" \
  && echo "$CHROMEDRIVER_SHA256  chromedriver_linux64.zip" | sha256sum -c - \
  && unzip "chromedriver_linux64.zip" -d /usr/local/bin \
  && rm "chromedriver_linux64.zip"

WORKDIR /usr/src/app

COPY HoeWarmIsHetInDelft.py .

CMD [ "python3", "./HoeWarmIsHetInDelft.py" ]

