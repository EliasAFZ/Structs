//Elias Afzalzada
//HW04
//https://www.radford.edu/~itec380//2019spring-ibarland/Homeworks/structs/structs.html


public class Ball {
//Part 3:
// [Design Recipe 1]
// Data definition: A ball is:
// - an int x (representing the x coordinate of the ball)
// - an int y (representing the y coordinate of the ball)
// - an int xDir (representing the x heading direction of the ball -1 means left +1 means right)
// - an int yDir (representing the y heading direction of the ball -1 means down +1 means up)
    int x;
    int y;
    int xDir;
    int yDir;

// [Design Recipe 2]
// Examples of data
// Ball b1 = new Ball(5,5,-1,1);
// Ball b2 = new Ball(10,5,1,1 );
// Ball b3 = new Ball(50,50,-1,-1);

    //Constructor
    public Ball(int _x, int _y, int _xDir, int _yDir){
        this.x=_x;
        this.y=_y;
        this.xDir=_xDir;
        this.yDir=_yDir;
    }

// [Design Recipe 3]
/* Template for Ball functions
       ... ballFunction( /* Ball this * / ) {
          ... this.x
          ... this.y
          ... this.xDir
          ... this.yDir
          }
*/

//Reference: https://www.radford.edu/~itec380//2019spring-ibarland/Lectures/struct-intro/JavaExamples/Book.java
//Equals method(function)
    public boolean equals(Object that){
        if(that==null){
            return false;
        }
        else if (this==that) {
            return true;
        }
        else if (this.getClass() != that.getClass()) {
            // Many say to use `instanceof` ^^here^^; I disagree. --ibarland
            return false;
        }
        else {
            Ball b2 = (Ball)that;
            return this.x == b2.x
                    && this.y == b2.y
                    && this.xDir == b2.xDir
                    && this.yDir == b2.yDir;
        }
    }

//Reference: https://www.radford.edu/~itec380//2019spring-ibarland/Lectures/struct-intro/JavaExamples/Book.java
//Hashcode method(function)
    private static Integer theHash = null;
    private static int SHUFFLE_BITS = 0b11111; //31;

    @Override
    public int hashCode() {
        if (theHash == null) {
            // We only reach this once per object.
            // (relies on immutability).
            int h = 0;
            h += Integer.hashCode(x);
            h *= SHUFFLE_BITS;
            h += Integer.hashCode(y);
            h *= SHUFFLE_BITS;
            h += Integer.hashCode(yDir);
            h *= SHUFFLE_BITS;
            h += Integer.hashCode(xDir);
            theHash = Integer.valueOf(h);
        }
        return theHash.intValue();
    }


//Part 4:
// Ball_move : "this Ball" -> "new Ball"
// Returns a new ball that has moved one tick based on xDir(+1 is left, -1 is right) and yDir(+1 is up, -1 is down)
    public Ball Ball_move(){
        int newXPos = 0;
        int newYPos = 0;

        switch(this.xDir){
            case 1 :
                newXPos = this.x++;
                break;
            case -1 :
                newXPos = this.x--;
                break;
        }

        switch(this.yDir){
            case 1 :
                newYPos = this.y++;
                break;
            case -1 :
                newYPos = this.y--;
                break;
        }
        return new Ball(newXPos, newYPos, this.xDir, this.yDir);
    }

//Unit tests for Ball class
    static void test(){
        Ball b1 = new Ball(50,50, 1, 1);
        Ball b2 = new Ball(50,50, 1, 1);
        Ball b3 = new Ball(79, 53, -1, -1);

        assert b1.equals(b1);
        assert b1.equals(b2);
        assert !b1.equals(b3);
        b1.Ball_move();
        assert b2.equals( new Ball(50,50,1,1));
        assert !b1.equals( new Ball(-51,-51, 1, 1));
        assert b1.hashCode() == b1.hashCode();
        assert b2.hashCode() == new Ball(50,50,1,1).hashCode();

        //System.out.println(b1.equals(b2));
        //b1.Ball_move(b1);
        //System.out.println("did it work?");
    }

    //@Override
    //public String toString(){
    //    return this.x + " " + this.y;
    //}
}


