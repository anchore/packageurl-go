.PHONY: test clean lint

test:
	curl -Ls https://raw.githubusercontent.com/package-url/purl-spec/1951d217bde29590a73f075db4ab71cc00011459/test-suite-data.json -o testdata/test-suite-data.json
	go test -v -cover ./...

fuzz:
	go test -fuzztime=1m -fuzz .

clean:
	find . -name "test-suite-data.json" | xargs rm -f

lint:
	go get -u golang.org/x/lint/golint
	golint -set_exit_status
