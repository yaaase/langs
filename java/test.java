import java.io.*;

class Program {
  public static void main(String[] args) {
    int result = 1;
    for (int i = 11; i < 20; i += 2) {
      result *= i;
    }
    System.out.println(result);
  }
}
