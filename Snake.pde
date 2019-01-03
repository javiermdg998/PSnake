public class Snake {
    ArrayList<PVector> body = new ArrayList<PVector>();
    boolean eating;
    int size=15;
    char direction;
    PVector lastFood;
    public Snake (int x, int y,char direction) {
        PVector head=new PVector(x,y);
        lastFood=new PVector(-1,-1);
        this.body.add(head);
        this.body.add(new PVector(head.x+size,head.y));
        this.body.add(new PVector(head.x+size*2,head.y));
        
      /*  this.body.add(new PVector(head.x+size*3,head.y));
        
        this.body.add(new PVector(head.x+size*4,head.y));
        
        this.body.add(new PVector(head.x+size*5,head.y));
        this.body.add(new PVector(head.x+size*6,head.y));
        this.body.add(new PVector(head.x+size*7,head.y));
        this.body.add(new PVector(head.x+size*8,head.y));
        this.body.add(new PVector(head.x+size*9,head.y));
        this.body.add(new PVector(head.x+size*10,head.y));
        this.body.add(new PVector(head.x+size*11,head.y));
        this.body.add(new PVector(head.x+size*12,head.y));
        this.body.add(new PVector(head.x+size*13,head.y));
        */
        this.direction=direction;
        this.eating =false;
    
    }

    void draw(){
        //fill(255);
        for (int i = 0; i < body.size(); i++) {           
             fill(255);
             if(i==0){
                 fill(0,255,0);
             }
            rect(body.get(i).x, body.get(i).y, size, size);
        }
    }
    void update(Food f){
        //println("this.body.size(): "+this.body.size());
        char dir =predict(f);
    // println("size "+this.body.size());
       this.setDirection(dir);
       this.move(f);
        for (int i = 2; i < body.size(); i++) {
            if(isSame2(body.get(0),body.get(i))){
                for (int j = i; j < body.size(); j++) {
                    // println("corte por comida "+ j);
                  //   println("body.get(i).x: "+body.get(i).x);
                    body.remove(j);
                   
                }
            }
        }
    }
    void setDirection(char dir){
        if((dir=='w' || dir=='s' || dir=='a' || dir=='d')){
            this.direction=dir;
        }
         
     //   move();
    }

    boolean move(Food f){
        
        PVector  head=new PVector(this.body.get(0).x,this.body.get(0).y);
        //println("head.x: "+head.x);
        PVector tail=this.body.get(body.size()-1);
        //println("me muevo "+this.direction);
        switch (this.direction){
            case 'w':
                head.y-=size;
                break;
            case 's':
                head.y+=size;
                break;
            case 'a':
                head.x-=size;
                break;
            case 'd':
                head.x+=size;
                break;
                /*default:
                    return false;*/
        }
        //borders
        if(head.x>width-size){
            head.x=0;
        }else if(head.x<0){
            head.x=width;
        }
        if(head.y>height-size){
            head.y=0;
        }else if(head.y<0){
            head.y=height;
        }


        this.body.add(0,head);

        if(distance(head,f.position)==0 ){
            lastFood.x=f.position.x;
            lastFood.y=f.position.y;
            f.generate();
            eating=true;
          //  println("this.body.size(): "+this.body.size());
        //}
        //if((dist(head.x,head.y,f.position.x,f.position.y)>0 && dist(tail.x,tail.y,lastFood.x,lastFood.y)>0)){
           
          //  println("corte tipo 2");
           this.body.remove(this.body.size()-1);
            
        }else if(eating){
        
          //  println(dist(head.x,head.y,f.position.x,f.position.y)>0);
           // println(dist(tail.x,tail.y,lastFood.x,lastFood.y));
            eating=false;
        }else{
            this.body.remove(this.body.size()-1);
        }
            //f.generate();
            
        return true;
        //this.body.remove(this.body.size()-1);
    }

    char predict(Food f){
        
        PVector  head=new PVector(this.body.get(0).x,this.body.get(0).y);
        PVector tail=this.body.get(this.body.size()-1);
        ArrayList<PVector> posibles= new ArrayList<PVector>();
        boolean discarded=false;

        fill(255,190,0);

        PVector[] directions={
            new PVector(head.x,head.y-size),
            new PVector(head.x,head.y+size),
            new PVector(head.x-size,head.y),
            new PVector(head.x+size,head.y)
        };
        for (PVector dir : directions) {
            checkDirection(dir,posibles);
        }
        /*
        for (int i = 1; i < body.size(); i++) {
           
            if(!(distance1(head.x-size,head.y,this.body.get(i))==0)){
                posibles.add(new PVector(head.x-size,head.y));
            }else{
                rect(head.x+size,head.y,15,15);
                discarded=true;
            }            
              if(!(distance1(head.x+size,head.y,this.body.get(i))==0)){  
                posibles.add(new PVector(head.x+size,head.y));
            }else{
                rect(head.x+size,head.y,15,15);
                discarded=true;
            } //<>//
             if(!(distance1(head.x,head.y-size,this.body.get(i))==size)){
                 
                posibles.add(new PVector(head.x,head.y-size));
                
            }else{ //<>//
              rect(head.x,head.y-size,15,15);
                discarded=true;
            }
            if(!(distance1(head.x,head.y+size,this.body.get(i))==0)){
                posibles.add(new PVector(head.x,head.y+size));
                // println("dist1 :"+distance1(head.x,head.y+size,this.body.get(i)));
                //stroke(0, 255,0);
                //line(head.x,head.y,this.body.get(i).x,this.body.get(i).y);
                //noStroke();
                println("dist1 :"+distance1(head.x,head.y+size,this.body.get(i)));
                stroke(255,0,0);
                line(head.x,head.y+size,this.body.get(i).x,this.body.get(i).y);
                noStroke();
            }else{
               
                rect(head.x,head.y+size,15,15);
                discarded=true;
            }
            /*if(discarded){
                println("funaciona");
                break;
            }*/
        //}
        if(posibles.size()>0){
        PVector[]nodos=ordenar(toArray(posibles),f.position);
         for (int k=0; k<nodos.length;k++){
             fill(160);
             rect(nodos[k].x,nodos[k].y,15,15);
         }
                int n=0;
                if(isSame2(nodos[0],this.body.get(1))){
                    n=1;
                }
    
               if(isSame1(nodos[n],head.x-size,head.y)){
                   
                   return 'a';
               }else if(isSame1(nodos[n],head.x+size,head.y)){
                   
                   return 'd';
               }else  if(isSame1(nodos[n],head.x,head.y-size)){
                   return 'w';
               }else{
                   return 's';
                
               }
        }else{
            return this.direction;
        }
              
        
    }
    
    float distance1(float x,float y, PVector b){
        return dist(x,y,b.x,b.y);
    }
    float distance(PVector a, PVector b){
        return dist(a.x,a.y,b.x,b.y);
    }
    boolean isSame1(PVector a,float x,float y){
        
        return isSame(a.x,a.y,x,y);
    }
    boolean isSame2(PVector a,PVector b){
        return isSame(a.x,a.y,b.x,b.y);
    }
    boolean isSame(float x,float y,float x1,float y1){
        
        return(x==x1 && y ==y1);
    }

    void checkDirection(PVector dir,ArrayList<PVector> posibles){
        boolean valid=true;
        for(int i =1;i< this.body.size();i++){
                if(distance(dir,this.body.get(i))==size){
                    valid=false;    
                }//esta estrictamente en linea recta 
        }
        if(valid){
            posibles.add(dir);
        }
    }

     


}
