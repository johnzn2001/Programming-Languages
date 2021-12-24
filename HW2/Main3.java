import java.io.File;
import java.lang.reflect.Method;
import java.lang.reflect.Modifier;
import java.lang.reflect.Type;

class Main3 {
    public static void main(String args[]) {
        dispInfo(new A());
    }
    private static String createS(Method m) {
        StringBuilder sb = new StringBuilder();
        sb.append(m.getName()).append(" ").append('(');
        String s = m.toGenericString();
        if(!grabMod(m.getModifiers()).equals("static")) {
            sb.append(m.getDeclaringClass().getName());
        }
        Type p[] = m.getGenericParameterTypes();
        for( Type p1 : p) {
            sb.append(',').append(' ').append(p1.getTypeName()); //grab name of type
        }
        sb.append(')');
        sb.append("-> ");
        sb.append(m.getReturnType().getName());
       
        return sb.toString();
    }
    private static String grabMod(int modifier) {
        switch(modifier) {
            case Modifier.STATIC: return "static";
            case Modifier.FINAL: return "final";
            case Modifier.ABSTRACT: return "abstract";
        }
        return "";
    }
    private static void dispInfo(Object obj) {
        try{
            Class myclass = obj.getClass();
            Method[] grabM = myclass.getDeclaredMethods();
            for(Method m:grabM){
                System.out.println(createS( m ));
            }
        }catch(SecurityException e){
            e.printStackTrace();
        }
    }
 }
 //testing try
class A{
    void foo(int a, float b){}
    int bar(String a, Integer b, File c){
        return 0;
    }
    static double doo() {
        return 20.3;
    }
    @Override
    public String toString(){
        return "A";
    }
}