// Package util provides functions used by the programs in package auger.
package util

import (
	"github.com/evolbioinf/clio"
	"log"
	"os"
)

const (
	author  = "Bernhard Haubold"
	email   = "haubold@evolbio.mpg.de"
	license = "Gnu General Public License, " +
		"https://www.gnu.org/licenses/gpl.html"
)

var version, date string

// PrintInfo prints a program's name, version, and commit date. It also prints the author, email address, and license of the auger package. Then it exits. To achieve this, we wrap the generic function for printing program information from the package clio.
func PrintInfo(name string) {
	clio.PrintInfo(name, version, date, author, email,
		license)
	os.Exit(0)
}

// Check tests the error passed and calls log.Fatal on the error if it isn't nil.
func Check(err error) {
	if err != nil {
		log.Fatal(err)
	}
}
