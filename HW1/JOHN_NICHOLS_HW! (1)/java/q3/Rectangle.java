import java.util.Objects;

public class Rectangle extends Shape{
    private final Point A, B;
    public Rectangle(){
        this(new Point(), new Point());
    }

    public Rectangle(Point a, Point b){
        A = a;
        B = b;
    }
    public double area(){
        double[] sides = {Point.distance(A, new Point(B.x, A.y)), Point.distance(new Point(B.x, A.y), B)};
        return sides[0] * sides[1];
    }
    public Point position(){
        return new Point((A.x + B.x) / 2, (A.y + B.y) / 2);
    }

    @Override
    public String toString(){
        StringBuilder sb = new StringBuilder();
        sb.append("Rectangle ").append(A).append("-").append(B);
        
        return sb.toString();
    }

    @Override
    public boolean equals(Object obj){
        if (obj == this){
            return true;
        }
        if (!(obj instanceof Rectangle)){
            return false;
        }
        Rectangle rectangle = (Rectangle) obj;
        return (rectangle.A == this.A) && (rectangle.B == this.B);
    }

    @Override
    public int hashCode(){
        return Objects.hash(A, B);
    }
}