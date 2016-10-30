/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package TestCase;

import Lib.*;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class TestIndexOf extends BenchmarkCase {
    
    private String queryWord;
    private List<String> dataArr;
    
    public TestIndexOf(String queryWord) {
        this.name = "JAVA Regex All";
        this.title = new String[]{"time(s)", "found"};
        this.dataArr = new ArrayList<>();
        this.queryWord = queryWord;
        
        File dataFile;
        dataFile = new File("../../data/list");
        
        if (!dataFile.isFile() || !dataFile.exists()) {
            System.exit(1);
        }

        try {
            FileReader dataReader;
            dataReader = new FileReader(dataFile);
            
            BufferedReader dataBuffer;
            dataBuffer = new BufferedReader(dataReader);
            
            String content;
            
            while ((content = dataBuffer.readLine()) != null) {
                dataArr.add(content);
            }
            
        } catch (FileNotFoundException ex) {
            Logger.getLogger(TestRegexAll.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IOException ex) {
            Logger.getLogger(TestRegexAll.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    @Override
    public List<Double> execute() {
        
        List<String> rst;
        rst = new ArrayList<>();
        
        int dataLen = this.dataArr.size();
        TimeRecord tR = new TimeRecord();
        tR.tag();
        this.dataArr.forEach(o -> {
            if (-1 != o.indexOf(this.queryWord)) {
                rst.add(o);
            }
        });

        tR.tag();
        return tR.report(rst.size());
    }
    
}
