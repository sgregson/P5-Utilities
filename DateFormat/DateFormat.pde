SimpleDateFormat sdf = new SimpleDateFormat("yy-MM-dd kk:mm:ss.SSS");
Date theDate = sdf.parse( "2012-01-13 13:17:53.000", new ParsePosition(0) );
Date exDate = sdf.parse( "2011-05-17 01:41:20.000", new ParsePosition(0) );

long timeInMillisSinceEpoch = exDate.getTime(); 
long openPathEpoch = timeInMillisSinceEpoch ;

println(timeInMillisSinceEpoch);
println(openPathEpoch);
