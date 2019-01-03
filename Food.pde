public class Food  {
    PVector position;
    int wScale;
    int hScale;

    public Food () {
        position=new PVector();
        
        wScale=(width/15)-1;
        hScale=(height/15)-1;
        generate();
        //this.position.x=195;
        //this.position.y=135;

    }
    void generate(){
        this.position.x=int(random(0,wScale))*15;
        this.position.y=int(random(0,hScale))*15;
    }
    void show(){
        fill(255,0,0);
        rect(position.x, position.y, 15,15);
    }
}
