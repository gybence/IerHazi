package Gui;
// Environment code for project ierHazi

import jason.asSyntax.*;
import jason.environment.*;
import java.util.logging.*;

import Gui.*;

public class StoreHouseEnv extends Environment {

	public static final int maxCapacity = 100;
	
	private GUI gui;
	private int numOfForklifts = 0;
	private int capacity = 100;
	private boolean isRunning = true;
	private boolean truckAtEntry = false;
	
    private Logger logger = Logger.getLogger("ierHazi."+StoreHouseEnv.class.getName());

    public StoreHouseEnv() {
    	gui = new GUI(this);
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
        logger.info("executing: "+action+", but not implemented!");
        if (true) { // you may improve this condition
             informAgsEnvironmentChanged();
        }
        return true; // the action was executed with success
    }

    /** Called before the end of MAS execution */
    @Override
    public void stop() {
        super.stop();
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
