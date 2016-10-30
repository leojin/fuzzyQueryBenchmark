/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Lib;

import java.util.List;

/**
 *
 * @author leojin
 */
public abstract class BenchmarkCase {

    public String name;
    public String[] title;
    
    public abstract List<Double> execute();
}
