ArrayList <ImageCoordinate> points = new ArrayList <ImageCoordinate> ();
String [] Cities = {"newyork","delhi","kabul","ulanbatar","baku","armenia","peru","Iran","kolkata","Singapore","Tanzania","Johannesburg","Chile","Venezuela","Colombia"};
String [] Comments = {"USA","India-Delhi","Afghanistan-Kabul","Mongolia -UlanBatar","Azerbaijan","Armenia","Peru","Iran","Kolkata","Singapore","Tanzania","Johannesburg","Chile","Venezuela","Colombia"};
String [] name= {"Samosa/Bierock", "Samosa", "Sambosa/Ashak/Mantu/Boulaneel", "Booz", "Samsa/Manti", "Sambusak", "Cangrejitos", "Sanbusaks", "Shingara", "Curry Puff", "Pastels", "Samoosa", "Empanadas", "Empanadas", "Empanadas"};

float mapGeoLeft   = -125.22;          // Longitude 125 degrees west
float mapGeoRight  =  153.44;          // Longitude 153 degrees east
float mapGeoTop    =   71.89;          // Latitude 72 degrees north.
float mapGeoBottom =  -56.11;          // Latitude 56 degrees south.
float mapScreenWidth,mapScreenHeight;
PFont font;
int width= 1250;
int height= 700;
PFont smallfont;
void setup() {
  size(width,height);
  noStroke();
  smooth();
 font= createFont("AmericanTypewriter-Light",16);
 smallfont= createFont("AmericanTypewriter-Light",14);
  PVector p1;
  mapScreenWidth  = width;
  mapScreenHeight = height;
  String [] commentary= loadStrings("commentary.csv");

  for(int i=0;i<Cities.length;i++)
  {
      p1= geoToPixel(getLatLon(Cities[i]));  
      points.add(new ImageCoordinate( p1.x, p1.y, Comments[i], name[i], commentary[i]));
  }
  
  
}
 
void draw() {
  PImage b1= loadImage("old-world-map2.jpg");
  b1.resize(width,height);
  background(b1);
  for (ImageCoordinate ic : points) {
    ic.update();
    ic.display();
  }
}
 
class ImageCoordinate {
  float x, y;
  float transparency;
  String img;
  String name;
  String commentary;
 
  ImageCoordinate(float x, float y, String img, String name, String commentary) {
    this.x = x;
    this.y = y;
    this.img = img;
    this.name= name;
    this. commentary= commentary;
  }
 
  void update() {
    if (dist(mouseX, mouseY, x, y) < 15 && transparency < 255) {
      transparency += 20;
    } else if (transparency > 0) {
      transparency -= 1.5;
    }
  }
 
  void display() {
    fill(#FAEF19, 100);
    triangle(x,y,x+10, y-10,x+20, y);
    //ellipse(x, y, 10, 10);
    fill(#FAEF19, transparency);
    textFont(font);
    text(img, x, y);
   text(name,x, y+20);
   textFont(smallfont);
   text(commentary, x-40, y+35,250, 800);
    
  }
}

PVector getLatLon(String query) {
 String url= "https://maps.google.com/maps/geo?output=csv&key=abcdefg&q="+ query;
 String input= loadStrings(url)[0];
 String [] chop= input.split(",");
 //println(query);
 float lat= float (chop[2]);
 float lon= float (chop[3]);
// println(query+"  "+lat + "," +lon);
 return(new PVector(lon,lat));
}

PVector geoToPixel(PVector geoLocation)
{
    return new PVector(mapScreenWidth*(geoLocation.x-mapGeoLeft)/(mapGeoRight-mapGeoLeft),
                       mapScreenHeight - mapScreenHeight*(geoLocation.y-mapGeoBottom)/(mapGeoTop-mapGeoBottom));
}


