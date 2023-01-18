FROM maven:3.8.6-openjdk-11 as build
RUN git clone https://github.com/anji1649github/spring-petclinic.git && \
    cd spring-petclinic && \
    mvn package
# jar location /spring-petclinic/target/spring-petclinic-2.7.3.jar

FROM openjdk:11
LABEL project="java"
LABEL author="anji"
EXPOSE 8080
COPY --from=build /spring-petclinic/target/spring-petclinic-2.7.3.jar /spring-petclinic-2.7.3.jar
CMD ["java", "-jar", "/spring-petclinic-2.7.3.jar"]