import java.util.Objects;

public class Triangle extends Shape implements Comparable<Shape>{
    private final Point A, B, C;
    public Triangle(){
        this(new Point(), new Point(), new Point());
    }

    public Triangle(Point a, Point b, Point c){
        A = a;
        B = b;
        C = c;
    }
    public double area(){
        double[] sides = {Point.distance(A, B), Point.distance(B, C), Point.distance(A, C)};
        double s = (sides[0] + sides[1] + sides[2]) / 2;
        return Math.sqrt(s * (s - sides[0]) * (s - sides[1]) * (s - sides[2]));
    }
    public Point position(){
        return new Point((A.x + B.x + C.x) / 3, (A.y + B.y + C.y) / 3);
    }

    @Override
    public String toString(){
        StringBuilder sb = new StringBuilder();
        sb.append("Triangle ").append(A).append("-").append(B).append("-").append(C);
        return sb.toString();
    }

    @Override
    public boolean equals(Object obj){
        if (obj == this){
            return true;
        }
        if (!(obj instanceof Triangle)){
            return false;
        }
        Triangle triangle = (Triangle) obj;
        return (triangle.A == this.A) && (triangle.B == this.B) && (triangle.C == this.C);
    }

    @Override
    public int hashCode(){
        return Objects.hash(A, B, C);
    }
}