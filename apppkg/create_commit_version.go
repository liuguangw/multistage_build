package apppkg

import (
	"errors"
	"fmt"
	"io/ioutil"
	"os"
	"os/exec"
	"path/filepath"
	"strings"
)

func readCommitVersion(workingDir string) (string, error) {
	cmd := exec.Command("git", "rev-parse", "HEAD")
	cmd.Dir = workingDir
	out, err := cmd.CombinedOutput()
	if err != nil {
		return "", err
	}
	commitVersion := strings.Trim(string(out), "\r\n")
	return commitVersion, nil
}

func CreateCommitVersion() error {
	//获取工作目录
	workingDir, err := os.Getwd()
	if err != nil {
		return errors.New("Get main application working dir error, " + err.Error())
	}
	//read commit version
	commitVersion, err := readCommitVersion(workingDir)
	if err != nil {
		return errors.New("Get commit version error, " + err.Error())
	}
	fmt.Println("git commit version: " + commitVersion)
	outputPath := filepath.Join(workingDir, "apppkg", "get_commit_version.go")
	fileContent := `package apppkg

//GENERATED CODE, DON'T EDIT!
func GetCommitVersion() string {
	return "` + commitVersion + `"
}`
	return ioutil.WriteFile(outputPath, []byte(fileContent), 0755)
}
