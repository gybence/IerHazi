package Gui;

import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import javax.swing.*;


public class GUI extends JFrame {
	
	private static final long serialVersionUID = 1L;
	private Box box;
    private StoreHouseEnv env;
    private JTextArea output;
    private JLabel capacityLabel;
    private JLabel numOfFLsLabel;
    public JButton entryButton;
    
    public GUI(StoreHouseEnv storeHouseEnv) {
        super("Warehouse details");
        env = storeHouseEnv;
        init();
    }

	public void init() {

        Container c = getContentPane();
        
        //forklifts
        JPanel numOfForklifts = new JPanel();
        numOfFLsLabel = new JLabel("Number of Forklifts: " + env.getNumOfForklifts());
        numOfForklifts.add(numOfFLsLabel);
        
        //open the gate
        entryButton = new JButton("Open the gate");
        entryButton.setEnabled(false);
        entryButton.addActionListener(onGateClick());
        
        //capacity
        JPanel capacityPanel = new JPanel();
        capacityLabel = new JLabel();
        updateLoad();
        capacityPanel.add(capacityLabel);
        
        //output
        output = new JTextArea(6, 18);
        output.setEditable(false);
        JScrollPane outScroll = new JScrollPane();
        outScroll.setViewportView(output);
        outScroll.setVerticalScrollBarPolicy(JScrollPane.VERTICAL_SCROLLBAR_ALWAYS);
        
        //box
        box = new Box(BoxLayout.Y_AXIS);
        box.add(capacityPanel);
        box.add(numOfForklifts);
        box.add(entryButton);
        box.add(outScroll);

        c.add(box);
        setSize(400, 300);
        setVisible(true);
    }
	
	private ActionListener onGateClick() {
        ActionListener action = new ActionListener() {
			@Override
			public void actionPerformed(ActionEvent arg0) {
				env.openGate();
			}
        };
        return action;
    }
	
	public void updateLoad() {
		capacityLabel.setText("Current load: " + env.getLoad() + " / " + StoreHouseEnv.maxCapacity);
	}
	
	public void changeForkliftNum(int num) {
		numOfFLsLabel.setText("Number of Forklifts: " + env.getNumOfForklifts());
	}	
	public void out(String out) {
        output.append(out + "\n");
        output.setCaretPosition(output.getDocument().getLength());
    }	
}
