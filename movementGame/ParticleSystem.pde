
class ParticleSystem {
  ArrayList<Particle> particles;
  PVector origin;
  int radius;
  int save_last_mod = -1;
  
  
  ParticleSystem(PVector position, int r) {
    origin = position.copy();
    particles = new ArrayList<Particle>();
    radius = r;
  }


  void addParticle(int mod) {
    if (particles.size() > 20) {
      return;
    }
    if (save_last_mod > mod) {
      particles = new ArrayList<Particle>();
    }
    save_last_mod = mod;
    switch(mod) {
    case 1:
      particles.add(new Particle(origin, radius, particles.size()));
      particles.add(new Particle(origin, radius, particles.size()));
      break;
    case 2:
      if (particles.size() > 15) {
        particles = new ArrayList<Particle>();
      }
      if (random(0, 1)<0.6)
        particles.add(new Particle(origin, radius, particles.size()));
        particles.add(new Particle(origin, radius, particles.size()));
        break;
    case 3:
      if (particles.size() > 10) {
        particles = new ArrayList<Particle>();
      }
      if (random(0, 1)<0.3)
        particles.add(new Particle(origin, radius, particles.size()));
        break;
    }
  }


  void run(int a, int b) {
    for (int i = particles.size()-1; i >= 0; i--) {
      Particle p = particles.get(i);
      p.run(a, b);
      if (p.isDead()) {
        particles.remove(i);
      }
    }
  }
}
