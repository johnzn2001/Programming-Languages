import java.lang.reflect.*;
import static java.lang.System.err;

class MyClass{ //testing
    public static boolean test1(){ return true;} //try1
    public static  boolean test2(){ return false;} //try1
    public static boolean testTAMU(boolean tamu){return tamu;}//rest fail
    public boolean testCSE(){return false;}
    public static int testAggie(){return 2021;}
    public static boolean fakeTestAggie(){return false;}
}

public class Main4 {
    public static void main(String[] args){
        try{
            Class<?> class1 = Class.forName(args[0]);
            Method[] methods = class1.getDeclaredMethods();
            System.out.println(args[0]);
            for(Method a : methods){
                String temp = a.getName();
                if((temp.startsWith("test")) && (a.getParameterCount() ==0) && (a.getReturnType().equals(Boolean.TYPE)) && Modifier.isStatic(a.getModifiers())){
                try {
                    System.out.println(a.getClass());
                    if(a.invoke(null).toString() == "true"){
                        System.out.println("OK: "+a.getName()+" suceeded");
                    }
                    else{
                        System.out.println("FAILED: "+a.getName()+" failed"); 
                    }
                } catch (Throwable error) { //catch errors in this interation
                    System.out.println("Method Name not found (Error)");
                    System.out.println(error);
                }
            }
        }
        }
        catch (Throwable error){ //catch errors
            System.err.println(error);  
		}
    }
}