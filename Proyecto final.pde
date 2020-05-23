import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.* ;
import org.jbox2d.dynamics.* ;

int x = 0;
int y = 0;
int v = 0;

Box2DProcessing mundo;
pelota una;
tecla primera;
Limite suelo;
ArrayList <pelota> pelota;

fondo uno;
void setup (){
size (600,700);
uno = new fondo ();
mundo = new Box2DProcessing(this);
  mundo.createWorld();
  una = new pelota(200,30,20,10);
  pelota = new ArrayList<pelota>();
  primera = new tecla ();
 suelo= new Limite(525, 300, 25, 250);
}

void draw (){
  uno.visual();
  mundo.step();
  uno.balon();
  uno.nubes ();
  for(pelota c:pelota){
    c.display();
  }
  suelo.display();
}

class fondo {
void visual (){
  rectMode(CORNER);
  
  //Pasto 
  background (#72B3EA);
fill (#4EB467);
rect (0,400, 600, 300);

//Base de cancha 
fill (#AAAAAA);
rect (50, 300, 25, 250);
fill (#AAAAAA);
rect (525, 300, 25, 250);

//canastas 
fill (#F7E6E6,90);
square (75,330,70);
fill (#FC1717);
rect (75,330,70,10);
fill (#F7E6E6,90);
square (455,330,70);
fill (#FC1717);
rect (455,330,70,10);

//cielo 
fill (#EDED60);
ellipse (70, 90,100,100);
}
void nubes (){
  fill (#F5EBE8,110);
  noStroke ();
  ellipse (280, 50,70,15);
  ellipse (450, 150,70,15);
  ellipse (200, 180,70,15);
  ellipse (300, 270,70,15);
  ellipse (550, 70, 70,10);
  ellipse (560, 280, 70,20);
  ellipse (50, 250, 80,15);
   

}
  
void balon(){
  fill (#FF5024);
ellipse (300,520,50,50);
} 
}

//MOVIMIENTO
class pelota {
  float w;
  float h;
  Body b;
  
  pelota (float x_, float y_, float w_, float h_){

    w = w_;
    h = h_;
    // Crear la definición del cuerpo
    BodyDef bd = new BodyDef();
    Vec2 posicionInicial = new Vec2(x,y);
    Vec2 posicionEnMundo = mundo.coordPixelsToWorld(posicionInicial);
    bd.position.set(posicionEnMundo);
    bd.type = BodyType.DYNAMIC;
    
    //crear el body : posición y velocidad
    b = mundo.createBody(bd);
    // una velocidad incial: linear, angular, hacer que el objeto no rote 
    b.setLinearVelocity(new Vec2(random(-5,5),random(10)));
    b.setAngularVelocity(random(-5,5));
    
    //definir su forma 
    PolygonShape ps = new PolygonShape();
    float ancho = mundo.scalarPixelsToWorld(w_);
    float alto = mundo.scalarPixelsToWorld(h_);
    ps.setAsBox(ancho/2,alto/2);
    
    //definir sus caracteristicas 
    FixtureDef fd = new FixtureDef();
    fd.shape = ps;
    fd.friction = 0.3;
    fd.restitution = 0.4;
    fd.density = 3;
    
    b.createFixture(fd);
  }
  
  void display(){
    Vec2 posicion = mundo.getBodyPixelCoord(b);
    float angulo = b.getAngle();
    pushMatrix();
      translate(posicion.x,posicion.y);
      rotate(-angulo);
    ellipseMode(CENTER);
      noStroke();
      fill(255,0,0);
      ellipse (w,h,50,50);
    popMatrix();
  }
  
}
void keyPressed(){
  primera.tiro();
}
class tecla {
  void tiro (){
    switch (key){
      case 'c':
      x = 300;
      y = 520;
      //=45;
     pelota.add(new pelota(0,0,25,20));
     break;
     case 'm':
     x = 300;
      y = 520;
     // =-15;
     pelota.add(new pelota(300,520,random(5,10),random(5,10)));
     break;
    }
  }

}
class Limite{
  float x,y;
  float w;
  float h;
  Body b;
  
  Limite( float x_, float y_, float w_, float h_){
    w = w_;
    h = h_;
    x = x_;
    y = y_;
    // Crear la definición del cuerpo
    BodyDef bd = new BodyDef();
    Vec2 posicionInicial = new Vec2(x_,y_);
    Vec2 posicionEnMundo = mundo.coordPixelsToWorld(posicionInicial);
    bd.position.set(posicionEnMundo);
    bd.type = BodyType.STATIC;
    
    //crear el body : posición y velocidad
    b = mundo.createBody(bd);
    // una velocidad incial: linear, angular, hacer que el objeto no rote 
    b.setLinearVelocity(new Vec2(5,5));
    b.setAngularVelocity(5);
    
    //definir su forma 
    PolygonShape ps = new PolygonShape();
    float ancho = mundo.scalarPixelsToWorld(w_);
    float alto = mundo.scalarPixelsToWorld(h_);
    ps.setAsBox(ancho/2,alto/2);
    
    //definir sus caracteristicas 
    FixtureDef fd = new FixtureDef();
    fd.shape = ps;
    fd.friction = 0.3;
    fd.restitution = 0.4;
    fd.density = 1;
    
    b.createFixture(fd);
  }
  
  void display(){    
    pushMatrix();
      translate(x,y);
    //rectMode(CENTER);
      noStroke();
      fill(0);
    //rectMode(CORNER);
    popMatrix();
  }

}
