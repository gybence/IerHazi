package Gui;
// Environment code for project ierHazi

import jason.asSyntax.*;
import jason.environment.*;
import java.util.logging.*;

public class StoreHouseEnv extends Environment {

	public static final int maxCapacity = 100;
	
	public static final Literal truckArrived  = Literal.parseLiteral("truck(box)");
	public static final Literal putOnBox  = Literal.parseLiteral("putBox(shelf)");
	public static final Literal takeOffBox  = Literal.parseLiteral("takeBox(shelf)");
	
	private GUI gui;
	private int numOfForklifts;
	private int capacity = 100;
	private boolean isRunning = true;
	private boolean truckAtEntry = false;
	
    private Logger logger = Logger.getLogger("ierHazi."+StoreHouseEnv.class.getName());

    public StoreHouseEnv() {
    	gui = new GUI(this);
    	numOfForklifts = 2;
    	
    	Thread truckThread = new Thread(() -> {
    		try {
    			while(isRunning) {
    				truckArrived();
    				Thread.sleep(10000);
    			}
    		}
    		catch(InterruptedException e) {
    			throw new RuntimeException("InterruptedException caught", e);
    		}
    	});
    	truckThread.start();
    }

    @Override
    public boolean executeAction(String agName, Structure action) {
    	logger.info(agName+" executing: "+action+"!");
        try {
        	if(action.equals(truckArrived)) {
				//TODO
			}
        	if(action.equals(putOnBox)) {
				capacity -=1;
				gui.changeCapacity(capacity);
			}
    		if(action.equals(takeOffBox)) {
				//TODO
			}
        } catch(Exception e) {}
        
        informAgsEnvironmentChanged();
        
        return true; // the action was executed with success
    }

    /** Called before the end of MAS execution */
    @Override
    public void stop() {
        super.stop();
    }
    
    public int getNumOfForklifts() {
    	return numOfForklifts;
    }
    
    public int getCapacity() {
    	return capacity;
    }
    
    public void openGate() {
    	if(truckAtEntry) {
	    	truckAtEntry = false;
	    	gui.out("Truck entered!");
    	}
    }
    
    public void truckArrived() {
    	if(!truckAtEntry) {
	    	truckAtEntry = true;
	    	gui.out("Truck waiting at entry!");
    	}
    }
}
