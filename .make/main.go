package main

import (
	"os"

	. "github.com/anchore/go-make"
	"github.com/anchore/go-make/run"
	"github.com/anchore/go-make/tasks/golint"
	"github.com/anchore/go-make/tasks/gotest"
	"github.com/anchore/go-make/tasks/release"
)

func main() {
	Makefile(
		gotest.Tasks(),
		golint.Tasks(),
		release.ChangelogTask(),
		release.TagAndCreateGHRelease(),

		// custom fuzz testing task
		Task{
			Name:        "fuzz",
			Description: "run fuzz tests",
			Run: func() {
				Run("go test -fuzztime=1m -fuzz .", run.Stdout(os.Stdout), run.Stderr(os.Stderr))
			},
		}.RunOn("test"),
	)
}
