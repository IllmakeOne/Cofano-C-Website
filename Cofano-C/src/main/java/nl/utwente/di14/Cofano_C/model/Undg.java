package nl.utwente.di14.Cofano_C.model;

public class Undg {
	
	private int ID;
	
	private String ENdescription;
	private String DEdescription;
	private String FRdescription;
	private String NLdescription;
	
	private boolean transportForbidden;
	private boolean collective;
	private boolean notApplicable;
	

	private String classificationCode;
	private String unNo;
	private String classification;
	private String packingGroup;
	
	public Undg() {}	
	
	public Undg(int iD, String eNdescription, String dEdescription, String fRdescription, String nLdescription,
			String classificationCode, String unNo, String classification, String packingGroup) {
		super();
		ID = iD;
		ENdescription = eNdescription;
		DEdescription = dEdescription;
		FRdescription = fRdescription;
		NLdescription = nLdescription;
		this.classificationCode = classificationCode;
		this.unNo = unNo;
		this.classification = classification;
		this.packingGroup = packingGroup;
		
		transportForbidden = false;
		collective = false;
		notApplicable = false; 
	}
	
	public int getID() {
		return ID;
	}
	public void setID(int iD) {
		ID = iD;
	}
	public String getENdescription() {
		return ENdescription;
	}
	public void setENdescription(String eNdescription) {
		ENdescription = eNdescription;
	}
	public String getDEdescription() {
		return DEdescription;
	}
	public void setDEdescription(String dEdescription) {
		DEdescription = dEdescription;
	}
	public String getFRdescription() {
		return FRdescription;
	}
	public void setFRdescription(String fRdescription) {
		FRdescription = fRdescription;
	}
	public String getNLdescription() {
		return NLdescription;
	}
	public void setNLdescription(String nLdescription) {
		NLdescription = nLdescription;
	}
	public boolean isTransportForbidden() {
		return transportForbidden;
	}
	public void setTransportForbidden(boolean transportForbidden) {
		this.transportForbidden = transportForbidden;
	}
	public boolean isCollective() {
		return collective;
	}
	public void setCollective(boolean collective) {
		this.collective = collective;
	}
	public boolean isNotApplicable() {
		return notApplicable;
	}
	public void setNotApplicable(boolean notApplicable) {
		this.notApplicable = notApplicable;
	}
	public String getClassificationCode() {
		return classificationCode;
	}
	public void setClassificationCode(String classificationCode) {
		this.classificationCode = classificationCode;
	}
	public String getUnNo() {
		return unNo;
	}
	public void setUnNo(String unNo) {
		this.unNo = unNo;
	}
	public String getClassification() {
		return classification;
	}
	public void setClassification(String classification) {
		this.classification = classification;
	}
	public String getPackingGroup() {
		return packingGroup;
	}
	public void setPackingGroup(String packingGroup) {
		this.packingGroup = packingGroup;
	}
	
	

}
