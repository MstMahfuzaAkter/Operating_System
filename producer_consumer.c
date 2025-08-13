#include <stdio.h>
#include <stdlib.h>

int buffer = 0;     // Shared buffer
int full = 0;       // Buffer state: 0 = empty, 1 = full

void produce() {
    if (full == 1) {
        printf("Buffer is Full\n");
    } else {
        printf("Enter the value: ");
        scanf("%d", &buffer);
        full = 1;
    }
}

void consume() {
    if (full == 0) {
        printf("Buffer is Empty\n");
    } else {
        printf("The consumed value is %d\n", buffer);
        buffer = 0;
        full = 0;
    }
}

int main() {
    int choice;

    while (1) {
        printf("\n1. Produce\t2. Consume\t3. Exit\n");
        printf("Enter your choice: ");
        scanf("%d", &choice);

        switch (choice) {
            case 1:
                produce();
                break;
            case 2:
                consume();
                break;
            case 3:
                exit(0);
            default:
                printf("Invalid choice\n");
        }
    }

    return 0;
}
