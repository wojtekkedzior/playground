#include "/home/wojtek/apue.3e/include/apue.h"
#include <fcntl.h>
#include <time.h>
#include <malloc.h>

#define Megabyte (1024 * 1024)

int main(void) {

    // char buf[MAXLINE];
    // while (fgets(buf, MAXLINE, stdin) != NULL) {
    //     if(fputs(buf, stdout) == EOF)
    //          sprintf("%s", "m");
    // }

    char s[4] = "asdf";
    int t= 2;
    char filename[20];

    sprintf(filename, "%s-%i", s, t);

    // printf("%s", filename);
    printf("%i", getppid());


    // int r = rand();
    // char filename[20];

    // printf("%i", r);
    
    // strcpy(filename, "my-file");
    // strcpy(filename, r);

    // sprintf(filename, "%s-%i", "my-file", r); // Append str2 to str1


    // int fd = creat(filename, FILE_MODE);
    // char buf1[1000000];

    // for (size_t i = 0; i < 1000000; i++)
    // {
    //     buf1[i] = 'a';
    // }
    
    // void* data = malloc(2 * Megabyte);
    
    // // Do your work here...
    
    // free(data);

    

    // printf("%d\n",fd);

    // write(fd, buf1, 1000000);

    // time_t mytime = time(NULL);
    // char * time_str = ctime(&mytime);
    // time_str[strlen(time_str)-1] = '\0';
    // printf("Current Time : %s\n", time_str);
    // fsync(fd);

    // mytime = time(NULL);
    // time_str = ctime(&mytime);
    // time_str[strlen(time_str)-1] = '\0';
    // printf("Current Time : %s\n", time_str);


    // close(fd);

    // sleep(20);
    // while (1 == 1) {

    // }

    // if (lseek(STDIN_FILENO, 0, SEEK_CUR) == -1) {
    //     printf("cannot seekd dds\n");
    // } else {
    //     printf ("can adadaseek\n");
    // }
    exit(0);
    // _exit(1);
}
