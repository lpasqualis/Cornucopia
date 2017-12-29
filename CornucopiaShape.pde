class CornucopiaShape {

  PVector[][] m_cp;
  PVector[][] m_cp_rot;

  CornucopiaShape() {
    m_cp=null;
    m_cp_rot=null;
  }
  
  void generate(float z1, float z2, 
                float small_r1, float large_r1, 
                float small_r2, float large_r2, 
                float theta1, float theta2, 
                int inc_rows, 
                int points_n) {

    m_cp=cornucopiaPoints(z1,z2, 
                          small_r1, large_r1, small_r2, large_r2, 
                          theta1, theta2, 
                          inc_rows, 
                          points_n);
    m_cp_rot=m_cp;
  }
  
  void rotate() {
    m_cp_rot = new PVector[m_cp.length][];
    for (int r=0;r<m_cp.length;i++) {
      PVector ret[] = m_cp[r];
      m_cp_rot[r] = new PVector[ret.length];
      for (int i=ret.length-1; i>=0; i--) {
        m_cp_rot[r][i] = vectorRotate3D(ret[i], 
          cos(radians((ret[i].z))), 
          sin(radians((ret[i].z))), 
          0);
      }  
    }
  }
  
  void clearRotation() {
    m_cp_rot=m_cp;
  }

  PVector[][] cornucopiaPoints(float z1, float z2, 
                               float small_r1, float large_r1, 
                               float small_r2, float large_r2, 
                               float theta1, float theta2, 
                               int inc_rows, 
                               int points_n) {
    int rows = (int)((z2-z1)/inc_rows)+1;
    PVector[][] ret = new PVector[rows][];
    int idx=0;

    float small_r      = small_r1;
    float large_r      = large_r1;
    float small_incr   = (small_r2-small_r1)/rows;
    float large_incr   = (large_r2-large_r1)/rows;

    for (float z=z1; z<z2; z+=inc_rows) {
      ret[idx]=spiralPoints(z, small_r, large_r, theta1, theta2, points_n);
      //for (int i=ret[idx].length-1; i>=0; i--) {
      //  ret[idx][i]=vectorRotate3D(ret[idx][i], 
      //    cos(radians((z))), 
      //    sin(radians((z))), 
      //    0);
      //}

      small_r += small_incr;
      large_r += large_incr;
      idx+=1;
    }

    return ret;
  }

  PVector vectorRotate3D(PVector v, float x, float y, float z) {
    PMatrix3D matrix3d = new PMatrix3D();
    PVector result = new PVector();
    matrix3d.rotateX(x);
    matrix3d.rotateY(y);
    matrix3d.rotateZ(z);
    matrix3d.mult(v, result);
    return result;
  }

  PVector[] spiralPoints(float z, float r1, float r2, float theta1, float theta2, int points_n) {
    PVector[] points = new PVector[points_n];
    float theta      = theta1;
    int   idx        = 0;
    float theta_inc  = (theta2-theta1)/points_n;
    float radius_inc = (r2-r1)/points_n;

    for (float r=r1; r<r2; r+=radius_inc) {
      if (idx>=points_n) break;
      points[idx] = new PVector();
      points[idx].x = r * cos(theta);
      points[idx].y = r * sin(theta);
      points[idx].z = z;
      theta += theta_inc;
      idx++;
    }
    return points;
  }
}