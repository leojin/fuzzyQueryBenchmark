/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Lib;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 *
 * @author leojin
 */
public class TimeRecord {
    private List<Double> recordList;
    public TimeRecord () {
        this.recordList = new ArrayList<>(); 
    }
    public void tag () {
        Double curTime;
        curTime = (double)new Date().getTime() / 1000;
        this.recordList.add(curTime);
    }
    public List<Double> report () {
        List<Double> rst;
        rst = this.reportInner();
        return rst;
    }

    public List<Double> report (Integer extInfo) {
        List<Double> rst;
        rst = this.reportInner();
        rst.add(extInfo.doubleValue());
        return rst;
    }

    public List<Double> report (Double extInfo) {
        List<Double> rst;
        rst = this.reportInner();
        rst.add(extInfo);
        return rst;
    }
    
    private List<Double> reportInner () {
        List<Double> rst = new ArrayList<>();
        Integer recordLength = this.recordList.size();
        for (Integer i = 1; i < recordLength; i++) {
            rst.add(this.recordList.get(i) - this.recordList.get(i - 1));
        }
        return rst;  
    }
}
