//Defines the size and proximity of the vertexes
int columns, rows;
int scale = 25;
int Wdth = 3000;
int Hght = 3000;

//Defines color depending on height of vertex
int ColorNum;
//HSLtoRGB Ratio
float RGBratio = .70833;

//Moves Plane towards the Camera
float MovePlane;


float[][] terrain;

void setup(){
  size(1200,600, P3D);

  columns = Wdth / scale;
  rows = Hght / scale;
  terrain = new float [columns][rows];

}
float Red;
float Green;
float Blue;
float Grad;

void DefineFill(){
        
      if (ColorNum > 300){
        Grad = 360 - ColorNum;
        Red = (360 - Grad)*RGBratio;
        Green = Grad*RGBratio;
        Blue = 0;
      }
      else if(ColorNum > 240){
        Grad = (300 - ColorNum)*RGBratio;
        Red = (255 - Grad);
        Green = (255 +  Grad);
        Blue = Grad;
      }
      else if(ColorNum > 180){
        Grad = 240-ColorNum;
        Red = Grad*RGBratio;
        Green = (360 - Grad)*RGBratio;
        Blue = 0;
      }
      else if(ColorNum > 120){
        Grad = 180-ColorNum;
        Red =  0;
        Green = (180 + Grad)*RGBratio;
        Blue = (180 - Grad)*RGBratio;
      }
      else if (ColorNum > 60){
        Grad = (120 - ColorNum);
        Red = 0;
        Green = Grad*RGBratio;
        Blue = (360 - Grad)*RGBratio;
      }
      else{ 
        Red = (360-ColorNum)*RGBratio;
        Green = ColorNum;
        Blue = (360-ColorNum)*RGBratio;
      }     
    fill(Red,Green,Blue);
}

void draw(){

  //Regenerates map by moving it towards the camera
  MovePlane -= .05;
  float yOffset = MovePlane;
  
  //Sets Height value of each vertex
  for (int y = 0; y < rows-1; y++){
    float xOffset = 0;
    for (int x = 0; x < columns; x++) {
      terrain[x][y] = map(noise(xOffset,yOffset), 0, 1, -300, 300);
      xOffset += .05;
    }
    yOffset += .05;
  }
 
  //Plane Position Parameters
  background(0,0,0);
  translate(width/2, height/2);
  rotateX(PI/3);
  translate(-Wdth/2, -Hght/2);

  //Defines the location of the vertex in the height map and gives it's color
  for (int y = 0; y < rows-1; y++){
    beginShape(TRIANGLE_STRIP);
    for (int x = 0; x < columns; x++) {
      
      ColorNum = int(terrain[x][y]+180);
      DefineFill();
      vertex(x*scale,y*scale, terrain[x][y]);
      vertex(x*scale,(y+1)*scale, terrain[x][y+1]);
    
    }   
    endShape();
  }
}