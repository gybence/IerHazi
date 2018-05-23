package Gui;
// Environment code for project ierHazi

import jason.asSyntax.*;
import jason.environment.*;
import java.util.logging.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;
import java.util.concurrent.ThreadLocalRandom;

public class StoreHouseEnv extends Environment {

	public static final int maxCapacity = 100;
	private GUI gui;
	private int numOfForklifts = 0;
	private int numOfTrucks = 3;
	private int load = 0;
	private boolean isRunning = true;
	private boolean truckAtEntry = false;
	private Random randomGen;
	private String lastArrivedTruckName;

	private Logger logger = Logger.getLogger("ierHazi." + StoreHouseEnv.class.getName());

	public StoreHouseEnv() {
		randomGen = new Random(2); 
		gui = new GUI(this);
		generateTrucks();
	}

	@Override
	public boolean executeAction(String agName, Structure action) {
		
		if(action.getFunctor().equals("refresh")) {
				String t0 = action.getTerm(0).toString();
				load = Integer.parseInt(t0);
				gui.updateLoad();
		}
		else if(action.getFunctor().equals("removeEntryGatePercepts")) {
			String t0 = action.getTerm(0).toString();
			removePercept(agName,Literal.parseLiteral("opengate(" + t0 + ")"));
			removePercept(t0,Literal.parseLiteral("arrived"));
		}
		else if(action.getFunctor().equals("write")) {
			String t0 = action.getTerm(0).toString();
			gui.out(t0.substring(1,t0.length()-1));
			
		}
		else if(action.getFunctor().equals("freeforklift")) {
			numOfForklifts += 1;
			gui.updateForkliftNum();	
			
		}
		else if(action.getFunctor().equals("enablebutton")) {
			truckAtEntry = true;
			gui.entryButton.setEnabled(true);
			gui.out("Truck waiting at entry!");
		}
		else if(action.getFunctor().equals("opensuccess")) {
			truckAtEntry = false;
			numOfForklifts -= 1;
			gui.updateForkliftNum();	
			gui.entryButton.setEnabled(false);
			gui.out("Truck entered!");
			
		}
		else if(action.getFunctor().equals("openfailure")) {
			
			truckAtEntry = false;
			gui.entryButton.setEnabled(false);
			gui.out("Truck could not enter!");
			
		}
		else logger.info("Executing an action which is not implemented: "+ action);
		
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

	public int getLoad() {
		return load;
	}

	public void openGate() { //gombnyomas kezelo fv
		if (truckAtEntry) {	
			addPercept("entryGate", Literal.parseLiteral("opengate(" + lastArrivedTruckName + ")")); 
		}
	}



	@SuppressWarnings("unused")
	private String listAgentPercepts(String agName) {
		List<Literal> perceptList = consultPercepts(agName);
		String percepts = "";
		for(Literal p : perceptList)
			percepts = percepts + " " + p.toString();	

		logger.info(agName +" percepts: " + percepts);
		return percepts;
	}
	
	public void truckArrived() {
		if (!truckAtEntry) {
			
			int truckNum = randomGen.nextInt(numOfTrucks) + 1;
			String agName = "truck" + Integer.toString(truckNum);
																	
			//jelzes az agensek es az UI fele
			addPercept(agName, Literal.parseLiteral("arrived"));
			lastArrivedTruckName = agName;
		}
	}
	
	private void generateTrucks() {
		Thread truckThread = new Thread(() -> {
			try {
				while (isRunning) {
						truckArrived();
					
					Thread.sleep(5000);
				}
			} catch (InterruptedException e) {
				throw new RuntimeException("InterruptedException caught", e);
			}
		});
		truckThread.start();
	}
}
