package Gui;

import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import javax.swing.*;


public class GUI extends JFrame {
	
    private Box box;
    private StoreHouseEnv env;
    private JTextArea output;
    private JLabel capacityLabel;
    
    public GUI(StoreHouseEnv storeHouseEnv) {
        super("Warehouse details");
        env = storeHouseEnv;
        init();
    }

	public void init() {

        Container c = getContentPane();
        
        //forklifts
        JPanel numOfForklifts = new JPanel();
        numOfForklifts.add(new JLabel("Number of Forklifts:" + env.getNumOfForklifts()));
        
        //open the gate
        JButton entryButton = new JButton("Open the gate");
        entryButton.addActionListener(onGateClick());
        
        //capacity
        JPanel capacityPanel = new JPanel();
        capacityLabel = new JLabel("Current capacity:" + env.getCapacity() + "/" + env.maxCapacity);
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
	
	public void changeCapacity(int cap) {
		capacityLabel.setText("Current capacity:" + env.getCapacity() + "/" + env.maxCapacity);
	}
	
	public void out(String out) {
        output.append(out + "\n");
        output.setCaretPosition(output.getDocument().getLength());
    }
	
}
