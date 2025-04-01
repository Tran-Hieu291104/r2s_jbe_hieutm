import java.util.Scanner;


public class Arrays {
    static int [] arr = new int [100];
    static int size = 0;

    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        int choice;

        do {
            System.out.println("\n======== MENU ========");
            System.out.println("1. Input the array");
            System.out.println("2. Display the array");
            System.out.println("3. Print the array in descending order");
            System.out.println("4. Check if all elements of the array are add");
            System.out.println("5. Search a value");
            System.out.println("6. Display elements that are prime numbers in the array");
            System.out.println("7. Exit");
            System.out.println("Enter your choice (1 - 7): ");
            choice = sc.nextInt();

            switch (choice) {
                case 1:
                    inputArray(sc);
                    break;
                case 2:
                    outputArray();
                    break;
                case 3:
                    printDescendingOrder();
                    break;
                case 4:
                    checkAllOdd();
                    break;
                case 5:
                    searchValue(sc);
                    break;
                case 6:
                    displayPrimeNumbers();
                    break;
                case 7:
                    if (quit(sc))
                        choice = 0;
                    break;
                default:
                    System.out.println("Invalid choice! Please choose again between 1 and 7");

            }
        }while (choice != 7);
        sc.close();
    }

    static void inputArray(Scanner sc) {
        System.out.println("Enter the number of elements (1 - 100): ");
        size = sc.nextInt();

        if(size < 1 || size > 100) {
            System.out.println("Invalid input! Please enter a number between 1 and 100");
            size = 0;
            return;
        }

        System.out.println("Enter " + size + " elements: ");
        for(int i = 0; i < size; i++) {
            System.out.print("Element " + (i + 1) + ": ");
            arr[i] = sc.nextInt();
        }
    }

    static void outputArray() {
        if(size == 0) {
            System.out.println("Array is empty!");
            return;
        }

        System.out.println("Array elements: ");
        for(int i = 0; i < size; i++) {
            System.out.print(arr[i] + " ");
        }
        System.out.println();
    }

    static void printDescendingOrder() {
        if(size == 0) {
            System.out.println("Array is empty!");
            return;
        }

        int [] temp = new int[size];
        for(int i = 0; i < size; i++) {
            temp[i] = arr[i];
        }

        for(int i = 0; i < size - 1; i++) {
            for(int j = i+1; j < size; j++) {
                if(temp[i] < temp[j]) {
                    int swap = temp[i];
                    temp[i] = temp[j];
                    temp[j] = swap;
                }
            }
        }

        System.out.println("Array in descending order: ");
        for(int i = 0; i < size; i++) {
            System.out.print(temp[i] + " ");
        }
        System.out.println();
    }

    static void checkAllOdd() {
        if(size == 0) {
            System.out.println("Array is empty!");
            return;
        }

        boolean odd = true;
        for(int i = 0; i < size; i++) {
            if(arr[i] % 2 == 0) {
                odd = false;
                break;
            }
        }

        if(odd) {
            System.out.println("Array is odd!");
        }
        else {
            System.out.println("Array is not odd!");
        }
    }

    static void searchValue(Scanner sc) {
        if(size == 0) {
            System.out.println("Array is empty!");
            return;
        }

        System.out.println("Enter the value to be searched: ");
        int value = sc.nextInt();

        int count = 0;
        for(int i = 0; i < size; i++) {
            if(value == arr[i]) {
                count++;
            }
        }

        if(count > 0)
            System.out.println("Value " + value + " appears " + count + " times in the array");
        else
            System.out.println("Value " + value + " is not found in the array");
    }

    static boolean isPrime(int n) {
        if(n < 2) {
            return false;
        }

        for(int i = 2; i <= Math.sqrt(n); i++) {
            if(n % i == 0) {
                return false;
            }
        }
        return true;
    }

    static void displayPrimeNumbers() {
        if(size == 0) {
            System.out.println("Array is empty!");
            return;
        }

        System.out.println("Prime numbers in the array: ");
        boolean isPrime = false;
        for(int i = 0; i < size; i++) {
            if(isPrime(arr[i])) {
                isPrime = true;
                System.out.print(arr[i] + " ");
            }
        }

        if(!isPrime) {
            System.out.println("None");
        }

        System.out.println();
    }

    static boolean quit(Scanner sc) {
        System.out.println("Are you sure? Enter 1 to exit: ");
        int confirm = sc.nextInt();
        if(confirm != 1) {
            System.out.println("Returning to menu ");
            return true;
        }
        return false;
    }
}