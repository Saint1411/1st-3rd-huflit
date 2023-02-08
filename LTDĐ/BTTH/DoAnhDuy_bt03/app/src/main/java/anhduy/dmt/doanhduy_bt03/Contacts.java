package anhduy.dmt.doanhduy_bt03;

public class Contacts {
    int id;
    String fname;
    String lname;
    int img;
    String phone;
    String email;

    public Contacts(int id, String fname,String lname, int img, String phone, String email) {
        this.id = id;
        this.fname = fname;
        this.lname=lname;
        this.img = img;
        this.phone = phone;
        this.email = email;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getFname() {
        return fname;
    }

    public void setFname(String fname) {
        this.fname = fname;
    }

    public String getLname() {
        return lname;
    }

    public void setLname(String lname) {
        this.lname = lname;
    }

    public int getImg() {
        return img;
    }

    public void setImg(int img) {
        this.img = img;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

}
