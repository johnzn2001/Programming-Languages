import java.util.Scanner;

public class Main{
	public static void main (String[] args){
		AnimalShelter animalShelter = new AnimalShelter ();
		int i = 0;
		while (i < args.length){
			String [] s= args[i].split (" ");
			if (s[0].equals ("d")){
				animalShelter.addAnimal (new Dog (s[1]));
			}
			else if (s[0].equals ("c")){
				animalShelter.addAnimal (new Cat (s[1]));
			}
			++i;
		}

		int pick = 0;
		Scanner input = new Scanner (System.in);
		do {
			System.out.println ("\n\n1: Add new animal");
            System.out.println ("2: Adopt an animal");
            System.out.println ("3: Adopt a cat");
            System.out.println ("4: Adopt a dog");
            System.out.println ("5: Show animals in the shelter");
            System.out.println ("6: Show cats in the shelter");
            System.out.println ("7: Show dogs in the shelter");
            System.out.println ("0: Exit");
			System.out.print("\nEnter a number: ");

			pick = input.nextInt ();
			switch (pick){
				case 1:
					System.out.print ("Enter name of the animal: ");
					String name = input.next();
					System.out.print ("Enter d for dog or c for cat: ");
					char aType = input.next().charAt(0);

					if(aType == 'd'){
						animalShelter.addAnimal (new Dog (name));
					}
					else{
						animalShelter.addAnimal (new Cat (name));
					}
					break;
				
				case 2:
					animalShelter.adopt ();

				case 3:
					animalShelter.adoptCat ();

				case 4:
					animalShelter.adoptDog ();

				case 5:
					animalShelter.remainingAnimals ();
					break;

				case 6:
					animalShelter.remainingCats ();
					break;

				case 7:
					animalShelter.remainingDogs ();
					break;
			}
		} while (pick != 0);
	}
}