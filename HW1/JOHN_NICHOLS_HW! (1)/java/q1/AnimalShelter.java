import java.util.ArrayList;

public class AnimalShelter{
	ArrayList<Animal> s;

	public AnimalShelter (){
		s = new ArrayList <Animal> ();
	}
	public void addAnimal (Animal animal){
		animal.order = s.size ();
		s.add(animal);
	}
	public void reset (){
		for (int j = 0; j < s.size (); ++j){
			s.get(j).order = j;
		}
	}

	public void adopt (){
		Animal animal = s.get(0);
		s.remove(0);
		reset ();
	}

	public void adoptDog (){
		for (int i=0; i < s.size(); ++i){
			if (s.get(i) instanceof Dog){
				s.remove(i);
				break;
			}
		}
		reset ();
	}

	public void adoptCat (){
		for (int i=0; i < s.size(); ++i){
			if(s.get(i) instanceof Cat){
				s.remove(i);
				break;
			}
		}

		reset ();
	}

	public void remainingAnimals (){
		for(Animal a : s){
			System.out.println (a.getName () + " " + a.getOrder () + " " + a.cry ());
		}
	}

	public void remainingDogs (){
		for (Animal a: s){
			if (a instanceof Dog){
				System.out.println (a.getName () + " " + a.getOrder () + " " + a.cry ());
			}
		}
	}

	public void remainingCats (){
		for (Animal a : s){
			if (a instanceof Cat){
				System.out.println (a.getName () + " " + a.getOrder () + " " + a.cry ());
			}
		}
	}
}