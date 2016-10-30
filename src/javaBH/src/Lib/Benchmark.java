/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Lib;

import java.util.*;
import java.util.stream.Collectors;
import java.util.stream.Stream;

/**
 *
 * @author leojin
 */
public class Benchmark {
    private Boolean detail;
    public void setDetailOn () {
        this.detail = true;
    }
    public void setDetailOff () {
        this.detail = false;
    }
    public void execute (BenchmarkCase bc, Integer times) {
        System.out.println("Benchmark For " + bc.name + "(" + times + " times)");
        System.out.println("\t" + String.join("\t", bc.title));
        
        ArrayList<ArrayList> rec;
        rec = new ArrayList<>();
        
        for (Integer i = 0; i < times; i++) {
            List<Double> tmp;
            tmp = bc.execute();
            if (this.detail) {
                System.out.println((1 + i) + "/" + times + ":\t" + String.join("\t", this.getStringList(tmp)));
            }
            rec.add((ArrayList) tmp);
        }
        
        List<Double> rst;
        
        Stream<ArrayList> stm;
        stm = rec.stream();
        
        List<Double> total;
        total = stm.reduce((result, ele) -> {
            Integer len;
            len = result.size();
            for (Integer i = 0; i < len; i++) {
                Double tmp = (Double)result.get(i) + (Double)ele.get(i);
                result.set(i, tmp);
            }
            return result;
        }).get();
        rst = total.stream().map(o -> Math.round(o * 1e5 / times) / 1e5).collect(Collectors.toList());
        System.out.println("AVE:\t" + String.join("\t", this.getStringList(rst)));
    }

    private List<String> getStringList(List<Double> arr) {
        List<String> rst;
        rst = new ArrayList<>();
        
        Stream<Double> stm;
        stm = arr.stream();
        
        stm.forEach(o -> {
            String tmp = o.toString();
            rst.add(tmp);
        });
        return rst;
    }

}
