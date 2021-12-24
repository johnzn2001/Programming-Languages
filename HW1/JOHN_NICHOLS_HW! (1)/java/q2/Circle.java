import java.util.Objects;

public class Circle extends Shape {
    private final Point C;
    private final double R;    
    public Circle(){
        this(new Point(), 1.0);
    }

    public Circle(Point c, double r){
        this.C = c;
        this.R = r;
    }
    public double area(){
        return Math.PI * Math.pow(R, 2);
    }
    public Point position(){
        return this.C;
    }

    @Override
    public String toString(){
        StringBuilder sb = new StringBuilder();
        sb.append("Circle ").append(C).append(", radius = ").append(R);
        return sb.toString();
    }

    @Override
    public boolean equals(Object obj){
        if (obj == this){
            return true;
        }
        if (!(obj instanceof Circle)){
            return false;
        }
        Circle circle = (Circle) obj;
        return (circle.C == this.C) && (circle.R == this.R);
    }

    @Override
    public int hashCode(){
        return Objects.hash(C, R);
    }
}