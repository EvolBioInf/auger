package main

import (
	"bytes"
	"os"
	"os/exec"
	"strconv"
	"testing"
)

func TestMerwin(t *testing.T) {
	var tests []*exec.Cmd
	f := "../data/test.cm"
	test := exec.Command("./merwin", "-t", "0.99", f)
	tests = append(tests, test)
	test = exec.Command("./merwin", "-t", "0.9954", f)
	tests = append(tests, test)
	test = exec.Command("./merwin", "-t", "0.9954",
		"-w", "50000", f)
	tests = append(tests, test)
	test = exec.Command("./merwin", "-t", "0.49", "-i", f)
	tests = append(tests, test)
	for i, test := range tests {
		get, err := test.Output()
		if err != nil {
			t.Error(err)
		}
		f := "r" + strconv.Itoa(i+1) + ".txt"
		want, err := os.ReadFile(f)
		if err != nil {
			t.Error(err)
		}
		if !bytes.Equal(get, want) {
			t.Errorf("get:\n%s\nwant:\n%s\n", get, want)
		}
	}
}
