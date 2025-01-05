package main

import (
	"fmt"
	"io/ioutil"
	"log"
	"net/http"
	"os"
	"strconv"
	"sync"
	"time"

	"github.com/gorilla/websocket"
)

// /usr/local/go/src/github.com/gorilla/websocket
// /home/wojtek/go/src/github.com/gorilla/websocket
func main() {
	var wg sync.WaitGroup

	threads, _ := strconv.Atoi(os.Args[1])
	messages, _ := strconv.Atoi(os.Args[2])
	delay, _ := strconv.Atoi(os.Args[3])
	install := os.Args[4]
	tenant := os.Args[5]
	lid := os.Args[6]

	d := http.Header{}
	d.Add("tenantId", tenant)

	url := fmt.Sprintf("wss://asdas-%sdsa.com/records", install)
	fmt.Println(fmt.Sprintf("Starting test against %s - using tenant %s", url, tenant))

	content, err := ioutil.ReadFile("payload")
	if err != nil {
		log.Fatal(err)
	}
	msg := fmt.Sprintf("{\"payload\":\"%s\",\"objectName\":\"country\",\"fromLogicalId\":\"%s\"}", content, lid)
	fmt.Println(fmt.Sprintf("The message that will be sent: %s", msg))

	for index := 0; index <= threads; index++ {
		wg.Add(1)
		go func() {
			defer wg.Done()

			c, _, err := websocket.DefaultDialer.Dial(url, d)
			if err != nil {
				log.Fatal("dial:", err)
			}

			defer c.Close()

			for i := 0; i < messages; i++ {
				err = c.WriteMessage(websocket.TextMessage, []byte(msg))
				if err != nil {
					log.Println("write:", err)
					return
				}

				time.Sleep(time.Duration(delay) * time.Millisecond)
			}
		}()
	}

	fmt.Println("Sleeping!")
	time.Sleep(10 * time.Minute)
	fmt.Println("Finishing test!")
}
