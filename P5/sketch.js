
let countries;
const mappa = new Mappa('Leaflet');
let map;
let canvas;

let data = [];

const options = {
  lat: 0,
  lng: 0,
  zoom: 1.5,
  style: 'http://{s}.tile.osm.org/{z}/{x}/{y}.png'
};

// function preload() {;
//   countries = loadJSON('countries.json');
// }

// function setup() {
//   canvas = createCanvas(600, 600).parent('sketch-holder');
//   map = mappa.tileMap(options);
//   map.overlay(canvas);
// }

// function draw() {
//   clear();
//   for (let countryid in countries) {
//     country = countries[countryid]
//     if (country[0] != NaN){
//       const pix = map.latLngToPixel(country[0], country[1]);
//       fill(0, 100, 200, 100);
//       const zoom = map.zoom();
//       ellipse(pix.x, pix.y, zoom*3);
//     }
//   }
// }
const sketch05 = (p) => {
  let canvas;
  let myMap;

  p.setup = () => {
    canvas = p.createCanvas(340,340);
    // p.background(100);
    myMap = mappa.tileMap(options); 
    myMap.overlay(canvas);
    myMap.onChange(drawPoint);
    p.fill(200, 100, 100);
  };

  function drawPoint(){  
    p.clear();
    const nigeria = myMap.latLngToPixel(11.396396, 5.076543); 
    p.ellipse(nigeria.x, nigeria.y, 20, 20);
  }
};
let s05 = new p5(sketch05);
