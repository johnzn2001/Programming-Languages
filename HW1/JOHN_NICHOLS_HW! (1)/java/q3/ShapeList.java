/*
THE CODE FOR THIS QUESITON IS INCOMPLETE,
4 ERRORS OCCUR WHEN RUNNING
JUST TURNED IN WHAT I COULD BY THE DEADLINE

*/

import java.util.*;
public class ShapeList<T> implements Iterable<T>, Comparable<ShapeList<T>>{

	public Node<T> n;
	public int length;
	ShapeList(){
		n = null;
		length = 0;
	}

	ShapeList(Iterable<T> iterable){
		Node<T> ptr = null;
		length = 0;

		Vector<T> v = new Vector<T>();
		for(T i : iterable){
			v.add(i);
		}
		for(int i = v.size()-1; i >= 0; i--){
			ptr = new Node<T>(v.get(i), ptr);
			length ++;
		}

		n = ptr;
	}

	public int getLength(){
		return length;
	}
	public Iterator<T> iterator(){
		return n.iterator();
	}

	public boolean equals(ShapeList<T> rhs){
		if(rhs == null){
			return false;
		}
		if(this.hashCode() != rhs.hashCode()){
			return false;
		}
		Vector<T> v1 = new Vector<T>();
		for(T i : this){
			v1.add(i);
		}

		Vector<T> v2 = new Vector<T>();
		for(T i : rhs){
			v2.add(i);
		}
		for(int i = 0; i < v1.size(); i++){
			for(int j = 0; j < v2.size(); j++){
				if( v1.get(i).equals(v2.get(j)) ){
					v2.remove(j);
					break;
				}
				if(j == v2.size()-1){
					return false;
				}
			}
		}
		return true;

	}

	public int hashCode(){
		return length;
	}	


	public void sample(T item){ // used for rev
		if(length == 0){
			n = new Node<T>(item); 
		}
		else{
			n = new Node<T>(item, n);
		}
		length++;
	}

	public ShapeList<T> reverse(){
		ShapeList<T> rev = new ShapeList<T>();
		if(length == 0){
			return rev;
		}
		for(T i : this){
			rev.sample(i);
		}

		this.n = rev.n;
		return this;
	}


	public String toString(){
		if(n == null){
			return "";
		}
		String ret = "";
		for(T i : this){
			ret += " (" + i + ") ->";
		}
		ret = ret.substring(2, ret.length() - 3);
		ret = "[(head: " + ret + "]";

		return ret;
	}


	public static void main(String args[]) {
        Shape shape[] = new Shape[args.length];

        /* Some initialization from the args ... */ 

        Circle c1 = new Circle(1,1,1);
        Circle d1 = new Circle(2,2,2);
        Circle e1 = new Circle(3,3,3);

        ShapeList<Shape> emptyShapes = new ShapeList<Shape>();
        ShapeList<Circle> someCircles = new ShapeList<Circle>(Arrays.asList(c1, d1, e1));

        System.out.println("emptyShapes = " + emptyShapes);
        System.out.println("reversed emptyShapes = " + emptyShapes.reverse());
        System.out.println("someCircles = " + someCircles);
        System.out.println("reversed someCircles = " + someCircles.reverse());

        double sumOfXs = 0.0;
        double sumOfYs = 0.0;
        for (Circle c: someCircles) {
            sumOfXs += c.position().x;
            sumOfYs += c.position().y;
        }
        System.out.println("Some of Xs = " + sumOfXs);
        System.out.println("Some of Ys = " + sumOfYs);
}

}