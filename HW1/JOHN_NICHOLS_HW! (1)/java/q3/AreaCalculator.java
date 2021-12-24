public class AreaCalculator {
    public static double calculate(Shape[] shapes) {
        double result = 0;
        for (Shape s : shapes) {
            result += s.area();
        }
        return result;
    }
}