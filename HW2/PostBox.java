//repeats? name in front

// This is the starter code. You are free to add methods and fields
// to this class.

import java.util.*;
import java.util.concurrent.*;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;

class PostBox implements Runnable {
    private final int MAX_SIZE;
    
    ReentrantLock sharedMessages;

    class Message {
        String sender;
        String recipient;
        String msg;
        Message(String sender, String recipient, String msg) {
            this.sender = sender;
            this.recipient = recipient;
            this.msg = msg;
        }
    }

    private final LinkedList<Message> messages;
    private LinkedList<Message> myMessages;
    private String myId;
    private volatile boolean stop = false;

    public PostBox(String myId, int max_size) {
        messages = new LinkedList<Message>();
        this.myId = myId;
        this.myMessages = new LinkedList<Message>();
        this.MAX_SIZE = max_size;
        new Thread(this).start();
    }

    public PostBox(String myId, int max_size, PostBox p) {
        ReentrantLock privateMessages;
        this.myId = myId;
        this.messages = p.messages;
        this.MAX_SIZE = max_size;
        this.myMessages = new LinkedList<Message>();
        new Thread(this).start();
    }

    public String getId() { return myId; }

    public void stop() {
        // make it so that this Runnable will stop when it next wakes
        stop = true;
    }

    public void send(String recipient, String msg) {
        // add a message to the shared message queue i.e message
        synchronized(messages){
        messages.add(new Message(this.myId, recipient, msg));
        }
    }

    public List<String> retrieve() {
        // return the contents of myMessages
        //and empty myMessages
        
        synchronized(myMessages){
            List<String> returnM = new ArrayList<String>();
            for(int i =0;i<myMessages.size();i++){
                returnM.add(myMessages.get(i).msg);
            }
            myMessages.clear();//try clr
            return returnM;
        }      
    }

    public void run() {
        // loop while not stopped
        List<Message> temp = new ArrayList<Message>();
        while(!stop){
        //      1. approximately once every second move all messages
        //      addressed to this post box from the shared message
        //      queue to the private myMessages queue
            synchronized(messages){
                temp.clear();
                for(int i=0;i<messages.size();i++){
                    if(this.myId == messages.get(i).sender){
                        synchronized(temp){
                        temp.add(messages.get(i));
                        }
                        messages.remove(i);
                    }
                }
            }
            synchronized(myMessages){
                synchronized(temp){
                for(int i=0;i<temp.size();i++){
                    myMessages.add(temp.get(i)); 
                }
            }
            temp.clear();
            }
            //      2. also approximately once every second, if the private or
            //      shared message queue has more than MAX_SIZE messages,
            //      delete oldest messages so that the size of myMessages
            //      and messages is at most MAX_SIZE.
            synchronized(messages){
                while(messages.size() > MAX_SIZE){
                    messages.removeLast();
                }
            }
            synchronized(myMessages){ 
                while(myMessages.size() > MAX_SIZE){ 
                    myMessages.removeLast();   
                }
            }
            try {
                temp.clear();
                Thread.sleep(1000);
            } 
            catch (InterruptedException e) {
                e.printStackTrace();
            }     
        }           
    }
}