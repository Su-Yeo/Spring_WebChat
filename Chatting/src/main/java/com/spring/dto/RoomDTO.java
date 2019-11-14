package com.spring.dto;

//room ���̺�
public class RoomDTO {
	
	
	 private String id ,master;
	 private String subject;
	 
	 
	    public RoomDTO() {
	    }
	 
	    public String getId() {
	        return id;
	    }
	 
	    public String getSubject() {
	        return subject;
	    }
	    public String getMaster() {
	    	return master;
	    }
	 
	    public void setId(String id) {
	        this.id = id;
	    }
	 
	    public void setSubject(String subject) {
	        this.subject = subject;
	    }
	    
	    public void setMaster(String master) {
	    	this.master = master;
	    }

}
