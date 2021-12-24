import java.util.Objects;

public class Point{
    public double x;
    public double y;
    public Point(){
        this(0, 0);
    }

    public Point (double x, double y){
        this.x = x;
        this.y = y;
    }
    public static double distance(Point a, Point b){
        return Math.sqrt(Math.pow((b.x - a.x), 2) + Math.pow((b.y - a.y), 2));
    }

    @Override
    public String toString(){
        StringBuilder sb = new StringBuilder();
        sb.append('(').append(x).append(", ").append(y).append(')');
        return sb.toString();
    }

    @Override
    public boolean equals(Object obj){
        if (obj == this){
            return true;
        }
        if (!(obj instanceof Point)){
            return false;
        }
        Point p = (Point) obj;
        return (p.x == this.x) && (p.y == this.y);
    }

    @Override
    public int hashCode(){
        return Objects.hash(x, y);
    }
}