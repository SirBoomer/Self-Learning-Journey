module class_test;

    class Student;
        string name;
        int    score;

        function  new(string name, int score);
            this.name   = name;
            this.score  = score;
        endfunction

        function void print();
            $display("%s scored %0d", name, score);
        endfunction
    endclass

    Student     s1;
    Student     s2;

    initial begin
        s1 = new("Kai", 90);
        s2 = new("Zhi", 70);
        s1.print();
        s2.print();
    end
endmodule
