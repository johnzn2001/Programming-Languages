/*
THE CODE FOR THIS QUESITON IS INCOMPLETE,
4 ERRORS OCCUR WHEN RUNNING
JUST TURNED IN WHAT I COULD BY THE DEADLINE

*/

import java.util.Iterator;
import java.util.LinkedList;
import java.io.*;

public final class Node<T> implements Iterable<T>{
	public final T v;
	public Node<T> next;

	public Node(T val){
		v = val;
		next = null;
	}
	public Node(T val, Node<T> link){
		v = val;
		next = link;
	}
	public T getV(){
		return v;
	}
	public Node<T> getN(){
		return next;
	}
	public void setNext(Node<T> node){
		next = node;
	}
	public NodeIterator<T> iterator(){
		return new NodeIterator<T> (this);
	}
	public class NodeIterator<T> implements Iterator<T>{
		private Node<T> p;
		public NodeIterator(Node<T> n){
			p = n;
		}
		public boolean hasNext(){
			return p != null;
		}
		public T next(){
			T v = p.getV();
			p = p.getN();
			return v;
		}
	}
	/*
	public int getCount()
    {
        Node temp = head;
        int count = 0;
        while (temp != null)
        {
            count++;
            temp = temp.next;
        }
        return count;
    }*/

	public static int maxArea(Node<Shape> n){
			int x = n.size();
			if (n == null){
				return 0;
			}
			int max = 0;
			for(int i = 0; i < x; i++){
				if(i > max){
					max = i;
				}
				else{
					continue;
				}
			}
			return max;
	}


	public static int boundingRect(){
		//UNFINISHED NEVER GOT TO WORK
	}
	public static void main(String[] args){
		
		
	}
}