public abstract class Shape implements Comparable<Shape>{
    public abstract double area();
    public abstract Point position();
    public abstract boolean equals(Object obj);
    public abstract int hashCode();
    @Override
    public int compareTo(Shape shape) {
        return (int) (this.area() - shape.area());
    }
}