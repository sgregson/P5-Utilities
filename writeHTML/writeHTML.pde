PrintWriter output = createWriter("Medium.html");

String input[];
String imgLines[];

size(800,600);
input = loadStrings("Medium.txt");    //Parses the project_list line-by-line into an array
imgLines = new String[input.length];    //assigns the length of the projectList variable based on the number of lines in the project_list file

for (int i=0; i < input.length; i++) {
  imgLines[i] = "http://chart.apis.google.com/chart?cht=qr&chs=500x500&chl="+input[i];
}


output.println("<html>");
output.println("<body>");
for (int i=0; i < imgLines.length; i++) {
  output.println("<img src="+imgLines[i]+"/>");
}

output.println("</body>");
output.println("</html>");

output.flush();
output.close();
exit();
