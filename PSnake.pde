 Snake s;
 Food f;
void setup() {
 s=new Snake(150,150,'s');
 f=new Food();
 //frameRate(3);
 noStroke();
}
void settings(){
 size(810,600);

 	
}

void draw() {
    background(0);
 
    f.show();
    s.draw();
    s.update(f);
}
void keyPressed(){
  
  s.setDirection(key);
  frameRate(3);
}
void keyReleased(){
    frameRate(60);
}
PVector[] ordenar(PVector[] original, PVector end) {
        PVector[] ordenado = original;

        PVector aux;
        int k;
        for (int i = 1; i < ordenado.length; i++) {
            k = i;
            while (k >= 1 && (dist(ordenado[k].x,ordenado[k].y,end.x,end.y) <dist(ordenado[k-1].x,ordenado[k-1].y,end.x,end.y))) {

                aux = ordenado[k - 1];
                ordenado[k - 1] = ordenado[k];
                ordenado[k] = aux;
                k--;
            }
        }
        return ordenado;
    }
    PVector[] toArray(ArrayList<PVector> a ){
      PVector[] arr=new PVector[a.size()];
      for (int i=0;i<a.size();i++) {
        arr[i]=a.get(i);
      }
      return arr;
    }