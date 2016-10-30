/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Main;

import Lib.*;
import java.lang.reflect.Constructor;
import java.lang.reflect.InvocationTargetException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author leojin
 */
public class Main {
    public static void main(String[] args) {
        if (args.length < 4) {
            System.exit(1);
        }
        
        String testName;
        testName = "TestCase." + args[0];
        
        String queryWord;
        queryWord = args[1];
        
        Integer times; 
        times = Integer.parseInt(args[2]);
        
        Boolean needDetail;
        needDetail = args[3].equals("on");

        Benchmark bM = new Benchmark();
        if (needDetail) {
            bM.setDetailOn();
        } else {
            bM.setDetailOff();
        }
        
        try {
            Class testCaseClass;
            testCaseClass = Class.forName(testName);
            
            Constructor testCaseCon;
            testCaseCon = testCaseClass.getDeclaredConstructor(new Class[]{String.class});
            
            testCaseCon.setAccessible(true);
            
            BenchmarkCase testCase;
            testCase = (BenchmarkCase) testCaseCon.newInstance(new Object[]{queryWord});
            
            bM.execute(testCase, times);
            
        } catch (ClassNotFoundException | NoSuchMethodException | SecurityException | InstantiationException | IllegalAccessException | IllegalArgumentException | InvocationTargetException ex) {
            Logger.getLogger(Main.class.getName()).log(Level.SEVERE, null, ex);
        }

    }
}
