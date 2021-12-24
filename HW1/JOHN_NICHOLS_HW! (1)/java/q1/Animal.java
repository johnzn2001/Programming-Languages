public abstract class Animal {
    String name;
    int order;  
    public Animal (){}
    public Animal (String name){
        this.name = name;
	}
    public String getName (){
        return this.name;
	}
    public int getOrder (){
        return this.order;
	}
    public abstract String cry ();
}