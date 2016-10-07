ANTLR4=java -jar /usr/local/lib/antlr-4.5.3-complete.jar
GRUN=java -cp "$$CLASSPATH:./output" org.antlr.v4.gui.TestRig
TEST_FILE=first.enk
START_RULE=compilationUnit
CUSTOM_RUNNER=None
GRAMMAR=Enkel

antlrjavafiles: grammar/$(GRAMMAR).g4
	mkdir -p antlrgenerated
	cp grammar/$(GRAMMAR).g4 antlrgenerated/
	$(ANTLR4) antlrgenerated/$(GRAMMAR).g4

antlrjavac: antlrjavafiles
	mkdir -p output
	javac -Xlint antlrgenerated/*.java -d output/
	
testriggui: antlrjavac
	$(GRUN) $(GRAMMAR) $(START_RULE) -gui $(TEST_FILE)

testrigtokens: antlrjavac
	$(GRUN) $(GRAMMAR) $(START_RULE) -tokens $(TEST_FILE)


all: $(CUSTOM_RUNNER).class

$(CUSTOM_RUNNER).class: antlrjavafiles src/$(CUSTOM_RUNNER).java
	mkdir -p output
	javac -Xlint src/$(GRAMMAR)*.java -sourcepath antlrgenerated/ -d output/

test: $(CUSTOM_RUNNER).class
	java -cp "$$CLASSPATH:./output" $(CUSTOM_RUNNER) $(TEST_FILE)

clean:
	if [ -d "output" ]; then rm -r output; fi
	if [ -d "antlrgenerated" ]; then rm -r antlrgenerated; fi
