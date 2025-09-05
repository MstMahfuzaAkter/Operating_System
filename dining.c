#include <stdio.h>
#include <stdlib.h>

int main() {
    int n, h, choice;
    int hungry[20];
    int i, j, found;

    printf("DINING PHILOSOPHER PROBLEM\n");
    printf("Enter the total no. of philosophers: ");
    scanf("%d", &n);

    printf("How many are hungry: ");
    scanf("%d", &h);

    for (i = 0; i < h; i++) {
        printf("Enter philosopher %d position: ", i + 1);
        scanf("%d", &hungry[i]);
    }

    while (1) {
        printf("\nOUTPUT\n");
        printf("1. One can eat at a time\n");
        printf("2. Two can eat at a time\n");
        printf("3. Exit\n");
        printf("Enter your choice: ");
        scanf("%d", &choice);

        if (choice == 1) {
            printf("\nAllow one philosopher to eat at any time\n");
            for (i = 0; i < h; i++) {
                printf("P %d is granted to eat\n", hungry[i]);
                for (j = 0; j < h; j++) {
                    if (i != j)
                        printf("P %d is waiting\n", hungry[j]);
                }
            }
        }
        else if (choice == 2) {
            printf("\nAllow two philosophers to eat at the same time\n");
            found = 0;
            for (i = 0; i < h; i++) {
                for (j = i + 1; j < h; j++) {
                    // check if they are not neighbors
                    if (abs(hungry[i] - hungry[j]) != 1 &&
                        abs(hungry[i] - hungry[j]) != (n - 1)) {
                        printf("P %d and P %d are granted to eat\n", hungry[i], hungry[j]);
                        for (int k = 0; k < h; k++) {
                            if (k != i && k != j)
                                printf("P %d is waiting\n", hungry[k]);
                        }
                        found = 1;
                        break;
                    }
                }
                if (found) break;
            }
            if (!found) {
                printf("No two philosophers can eat at the same time (all are neighbors).\n");
            }
        }
        else if (choice == 3) {
            printf("Exiting...\n");
            break;
        }
        else {
            printf("Invalid choice! Try again.\n");
        }
    }

    return 0;
}
