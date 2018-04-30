package Gui;

import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import javax.swing.*;


public class GUI extends JFrame {
	
    private Box box;
    private StoreHouseEnv env;
    private JTextArea output;
    
    public GUI(StoreHouseEnv storeHouseEnv) {
        super("Raktár részletek");
        env = storeHouseEnv;
        init();
    }

	public void init() {

        Container c = getContentPane();
        
        //forklifts
        JPanel numOfForklifts = new JPanel();
        numOfForklifts.add(new JLabel("Targoncák száma:"));
        JComboBox forklifts = new JComboBox();
        for(int i = 0;i<10;i++) {
        	forklifts.addItem(i);
        }
        numOfForklifts.add(forklifts);
        
        //open the gate
        JButton entryButton = new JButton("Kapu nyitása");
        entryButton.addActionListener(onGateClick());
        
        //capacity
        JPanel capacityPanel = new JPanel();
        capacityPanel.add(new JLabel("Raktár aktuális kapacitása:" + env.getCapacity() + "/" + env.maxCapacity));
        
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
	
	public void out(String out) {
        output.append(out + "\n");
        output.setCaretPosition(output.getDocument().getLength());
    }
	
}
