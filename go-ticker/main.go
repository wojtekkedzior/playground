package main

import (
	"fmt"
	"sync"
	"time"
)

var wg = &sync.WaitGroup{}
var cache map[string]IfsJWT
var retryStats = &RetryStatus{}

type IfsJWT struct {
	Expiration int
	Added      time.Time
}

type RetryStatus struct {
	FirstFailure  bool
	SecondFailure bool
}

func fetchToken() error {
	return nil
}

func getToken() error {
	err := fetchToken()
	if err != nil {
		// try one more time
		err = fetchToken()
		if err != nil {
			return err
		}
	}

	return nil
}

func checkCache() {
	ticker := time.NewTicker(10 * time.Second)
	quit := make(chan struct{})
	go func() {
		for {
			select {
			case <-ticker.C:
				fmt.Println("dsffsdf")
				token := cache["token"]
				now := time.Now()

				if retryStats.FirstFailure == true && retryStats.SecondFailure == true {
					err := getToken()
					if err != nil {
						//set response to rediness probe to error
					} else {
						//We got a token.
						retryStats.FirstFailure = false
						retryStats.SecondFailure = false

						//reset rediness probe
					}
				}

				if now.After(token.Added.Add(time.Duration(token.Expiration) * time.Millisecond)) {
					//Token has expired and we couldnt get a new one, this pod should be killed
					//return negative health check

				} else if now.After(token.Added.Add(4*time.Minute)) && now.Before(token.Added.Add(8*time.Minute)) {
					// 4m check
					err := getToken()
					if err != nil {
						//log the first failures
						retryStats.FirstFailure = true
					}
				} else if now.After(token.Added.Add(8 * time.Minute)) {
					// 8m check
					err := getToken()
					if err != nil {
						retryStats.SecondFailure = true
						//set response to rediness probe to erro
					}
				}
			case <-quit:
				ticker.Stop()
				return
			}
		}
	}()
}

func readiness() {

}

func main() {
	getToken()

	fmt.Println("ada")

	go checkCache()

	wg.Add(1)
	wg.Wait()
}
