.PHONY: test clean lint

test:
	curl -Ls https://raw.githubusercontent.com/package-url/purl-spec/de752b1160c7dc309482aaa80fd31884005aaec5/test-suite-data.json -o testdata/test-suite-data.json
	go test -v -cover ./...

fuzz:
	go test -fuzztime=1m -fuzz .

clean:
	find . -name "test-suite-data.json" | xargs rm -f

lint:
	go get -u golang.org/x/lint/golint
	golint -set_exit_status
