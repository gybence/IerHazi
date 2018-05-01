package Gui;
// Environment code for project ierHazi

import jason.asSyntax.*;
import jason.environment.*;
import java.util.logging.*;
import java.util.Random;

public class StoreHouseEnv extends Environment {

	public static final int maxCapacity = 100;
	
	public static final Literal truckArrived  = Literal.parseLiteral("truck(box)");
	public static final Literal putOnBox  = Literal.parseLiteral("putBox(shelf)");
	public static final Literal takeOffBox  = Literal.parseLiteral("takeBox(shelf)");
	
	private GUI gui;
	private int numOfForklifts;
	private int numOfTrucks;
	private int capacity = 100;
	private boolean isRunning = true;
	private boolean truckAtEntry = false;
	private Random randomGen;
	private String lastArrivedTruckName;
	
    private Logger logger = Logger.getLogger("ierHazi."+StoreHouseEnv.class.getName());

	

    public StoreHouseEnv() {
    	randomGen = new Random(2); // ez pont jo seed 2,1,3
    	gui = new GUI(this);
    	numOfForklifts = 2;
    	numOfTrucks = 3;
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
        		addPercept("entryGate",Literal.parseLiteral("wtf")); 
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
    		addPercept("entryGate",Literal.parseLiteral("opengate("+lastArrivedTruckName+")")); 
    		addPercept("forklift1",Literal.parseLiteral("put"));
	    	truckAtEntry = false;
	    	gui.entryButton.setEnabled(false);
	    	gui.out("Truck entered!");
    	}
    }
    
    public void truckArrived() {
    	if(!truckAtEntry) {
    		
    		//TODO: nem jo a random, vhogy meg kell jegyezni melyik kamionok vannak epp megerkezve
    		// es a nem megerkezettek kozul valasztani.. but its something
    		int truckNum = randomGen.nextInt(numOfTrucks) + 1 ;
    		String agName = "truck" + Integer.toString(truckNum); //osszeallitja melyik truck agens erezze magat ugy h eppen megjott 
    		
    		addPercept(agName,Literal.parseLiteral("arrived")); 
    		
    		lastArrivedTruckName = agName;
	    	truckAtEntry = true;
	    	gui.entryButton.setEnabled(true);
	    	gui.out("Truck waiting at entry!");
    	}
    }
}
