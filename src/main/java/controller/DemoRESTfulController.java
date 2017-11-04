package controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import pojo.Demo;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class DemoRESTfulController {


    List<Demo> list = new ArrayList<Demo>();

    @ResponseBody
    @RequestMapping(value = "/demo",method = RequestMethod.POST)
    public void addDemo(Demo demo){
        list.add(demo);
    }

    @ResponseBody
    @RequestMapping(value = "/demo/{id}",method = RequestMethod.GET)
    public Demo getDemo(@PathVariable("id") String demoId){
        Demo demo = list.get(Integer.parseInt(demoId));
        return demo;
    }


    @RequestMapping(value = "/demos",method = RequestMethod.GET)
    @ResponseBody public List getDemos(){
        return list;
    }

    @ResponseBody
    @RequestMapping(value = "/demo/{id:\\w+}",method = RequestMethod.DELETE)
    public void deleteDemo(@PathVariable("id") String demoId){
        list.remove(Integer.parseInt(demoId));
    }


    @ResponseBody
    @RequestMapping(value = "/demo/{id}",method = RequestMethod.PUT)
    public void updateDemo(@PathVariable String id , Demo demo){

        Demo updateDemo= list.get(Integer.parseInt(id));
        updateDemo.setName(demo.getName());
        updateDemo.setStatus(demo.getStatus());
    }

}
