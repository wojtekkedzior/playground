package main

import (
	"fmt"
	"os"

	"github.com/aws/aws-sdk-go/aws"
	"github.com/aws/aws-sdk-go/aws/credentials"
	"github.com/aws/aws-sdk-go/aws/endpoints"
	"github.com/aws/aws-sdk-go/aws/session"
	"github.com/aws/aws-sdk-go/service/s3/s3manager"
)

func upload() {

	// The session the S3 Uploader will use

	// sess := session.Must(session.NewSession())

	sess, err := session.NewSession(&aws.Config{
		Region:      aws.String(endpoints.EuWest1RegionID),
		Credentials: credentials.NewSharedCredentials("", "wpuser"),
	})

	if err != nil {
		fmt.Println(err)
	}

	// Create an uploader with the session and default options
	fn := "zaloha"

	uploader := s3manager.NewUploader(sess)
	f, err := os.Open("/media/wojtek/media/" + fn + ".zip")

	if err != nil {
		fmt.Println(err)
	}

	// Upload the file to S3.
	result, err := uploader.Upload(&s3manager.UploadInput{
		Bucket: aws.String("my-backup123"),
		Key:    aws.String(fn),
		Body:   f,
	})

	if err != nil {
		fmt.Println(err)
	}

	fmt.Printf("file uploaded to, %v\n", result)

}

func main() {
	upload()
}
