all:
	mkdir -p bin
	javac -classpath java-cup-11b.jar *.java -d bin
clean:
	rm -rf bin
clean_class:
	rm -rf *.class
