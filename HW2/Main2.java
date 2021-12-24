class Counter {
        int req;
        @Override
        public String toString() {
                return req + "";
        }
}
class message1 extends Thread{ //7
        private Counter count;
        public message1(Counter count){
                this.count = count;
        }
        public void run() {
                while(true) {
                        synchronized (count){
                                try {
                                    count.wait();
                                }
                                catch (InterruptedException e) {
                                    e.printStackTrace();
                                }
                                if(count.req % 7 == 0) {
                                        System.out.println("\n7 second message");
                                }
                        }
                }
        }
}
class message2 extends Thread { //15
        private Counter count;
        public message2(Counter count) {
                this.count = count;
        }
        public void run() {
                while(true) {
                        synchronized (count) {
                                try {
                                    count.wait();
                                } 
                                catch (InterruptedException e) {
                                    e.printStackTrace();
                                }
                                if(count.req % 15 == 0) {
                                        System.out.println("\n15 second message");
                                }
                        }
                }
        }
}
class printingTime extends Thread { //count
        private Counter count;
        public printingTime(Counter count) {
                this.count = count;
        }
        public void run() {
                while(true) {
                        try {
                            synchronized (count) {
                                count.req++;
                                count.notifyAll();
                            }
                            Thread.sleep(1000);
                            System.out.print(count + " ");
                        }
                        catch (InterruptedException e){
                                e.printStackTrace();
                        }
                }
        }
}

public class Main2 { //test
        public static void main(String[] args) {
                Counter count = new Counter();
                count.req = 0;
                Thread t1 = new printingTime(count);
                Thread t2 = new message1(count);
                Thread t3 = new message2(count);
                t1.start();
                t2.start();
                t3.start();
        }
}