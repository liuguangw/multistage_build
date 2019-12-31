package main

import (
	"fmt"
	"github.com/liuguangw/multistage_build/apppkg"
	"log"
	"os"
)

//go:generate go run . git-version
func main() {
	if len(os.Args) > 1 {
		if os.Args[1] == "git-version" {
			if err := apppkg.CreateCommitVersion(); err != nil {
				log.Fatalln(err)
			}
			return
		}
	}
	fmt.Println("hello world")
	fmt.Println("#Git Commit: " + apppkg.GetCommitVersion())
}
