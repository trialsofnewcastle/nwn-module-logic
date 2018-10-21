// Some colors and their names from html standard.
// Start tokens of intense colors (html)

const string txtRed =          "<cþ  >";
const string txtLime =         "<c þ >";
const string txtBlue =         "<c  þ>";
const string txtYellow =       "<cþþ >";
const string txtAqua =         "<c þþ>";
const string txtFuchsia =      "<cþ þ>";

// Start tokens of less intense (html)
const string txtMaroon =       "<c€  >";
const string txtGreen =        "<c € >";
const string txtNavy =         "<c  €>";
const string txtOlive =        "<c€€ >";
const string txtTeal =         "<c €€>";
const string txtPurple =       "<c€ €>";

// Start tokens of shades of grey (html)
const string txtBlack =        "<c   >";
const string txtWhite =        "<cþþþ>";
const string txtGrey =         "<c€€€>";
const string txtSilver =       "<c©©©>";

// Start tokens of misc. colors
const string txtOrange =       "<cþÀ >";
const string txtBrown =        "<c¦**>";


// Adds token to change color.
//
// sText - Text to be colored.
// sColor - Color constant to use (all colors start with "txt").
string MakeTextColor( string sText, string sColor );
string MakeTextColor( string sText, string sColor )
{
    if ( sColor != "" ) return ( sColor + sText + "</c>" );
    return sText;
}


string sColors = "         !!!!!!!!!!##########$$$$$$$$$$%%%%%%%%%%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyz{|}~€‚ƒ„…†‡ˆ‰Š‹ŒŽ‘’“”•–—˜™š›œžŸ¡¢£¤¥§©©ª«¬­®¯°±²³´µ¶·¸¸º»¼½¾¿ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖ×ØÙÚÛÜÝÞßàáâãäåæçèéêëìíîïñòóôõö÷øùúûüýþþþ";
// Returns Pseudo-Ascii Character (for color use only, not accurate Ascii)
string ASCII(int iAsciiCode) // 0 - 255
{
    return GetSubString(sColors,iAsciiCode+1,1);
}

// Returns Pseudo-Ascii Integer Value (for color use only, not accurate Ascii)
int ASCIIToInt(string sLookup)
{
    return FindSubString(sColors, sLookup)-1;
}

// Returns a Color Code Based on Pseudo-Ascii
string RGB(int iR, int iG, int iB) // 0-255
{
    return "<c"+ASCII(iR)+ASCII(iG)+ASCII(iB)+">";
}

//Primary text color function for the module. Codes are in the function.
string Color_Text(string ColorCode, string sText);

string Color_Text(string ColorCode, string sText)
{
        if (ColorCode == "saltsprey")       ColorCode ="<cÿ>";
        else if (ColorCode == "crimson")    ColorCode = "<c‘  >";
        else if (ColorCode == "danelaw")    ColorCode = "<c ~ >";
        else if (ColorCode == "red")        ColorCode = txtRed;
        else if (ColorCode == "green")      ColorCode = txtGreen;
        else if (ColorCode == "blue")       ColorCode = txtBlue;
        else if (ColorCode == "olive")      ColorCode = txtOlive;
        else if (ColorCode == "teal")       ColorCode = txtTeal;
        else if (ColorCode == "purple")     ColorCode = txtPurple;
        else if (ColorCode == "black")      ColorCode = txtBlack;
        else if (ColorCode == "white")      ColorCode = txtWhite;
        else if (ColorCode == "grey")       ColorCode = txtGrey;
        else if (ColorCode == "silver")     ColorCode = txtSilver;
        else if (ColorCode == "orange")      ColorCode = txtOrange;
        else if (ColorCode == "brown")       ColorCode = txtBrown;
        else if (ColorCode == "yellow")      ColorCode = txtYellow;
        else if (ColorCode == "lime")        ColorCode = txtLime;
        else if (ColorCode == "navy")        ColorCode = txtNavy;
        else if (ColorCode == "fuchsia")     ColorCode = txtFuchsia;
        else if (ColorCode == "maroon")      ColorCode = txtMaroon;
        else if (ColorCode == "gold")        ColorCode = "<cþ¿6>";
        else if (ColorCode == "ivory")       ColorCode = "<cþÎ¥>";
        else if (ColorCode == "plum")        ColorCode = "<cþww>";
        else if (ColorCode == "tangerine")   ColorCode = "<cÇZ >";
        else if (ColorCode == "peach")       ColorCode = "<cþÇ >";
        else if (ColorCode == "amber")       ColorCode = "<cœœ >";
        else if (ColorCode == "lemon")       ColorCode = "<cþþw>";
        else if (ColorCode == "midnight")    ColorCode = "<c  t>";
        else if (ColorCode == "azure")       ColorCode = "<c~~þ>";
        else if (ColorCode == "skyblue")     ColorCode = "<cÇÇþ>";
        else if (ColorCode == "violet")      ColorCode = "<c¥ ¥>";
        else if (ColorCode == "lavender")    ColorCode = "<cþ~þ>";
        else if (ColorCode == "slate")       ColorCode = "<c666>";
        else if (ColorCode == "darkgrey")    ColorCode = "<cZZZ>";
        else if (ColorCode == "lightgrey")   ColorCode = "<c¯¯¯>";
        else if (ColorCode == "turquoise")   ColorCode = "<c ¥¥>";
        else if (ColorCode == "jade")        ColorCode = "<c tt>";
        else if (ColorCode == "cyan")        ColorCode = "<c þþ>";
        else if (ColorCode == "cerulean")    ColorCode = "<cœþþ>";
        else if (ColorCode == "aqua")        ColorCode = txtAqua;
        else if (ColorCode == "rose")        ColorCode = "<cÎFF>";
        else if (ColorCode == "pink")        ColorCode = "<cþV¿>";
        else if (ColorCode == "wood")        ColorCode = "<c‘Z(>";
        else if (ColorCode == "tan")         ColorCode = "<cß‘F>";
        else if (ColorCode == "flesh")       ColorCode = "<cû¥Z>";
        else if (ColorCode == "dark orange") ColorCode = "<cð>";

    return ColorCode + sText + "</c>";
}


string Random_Color_Text(string ColorCode, string sText)
{
    if (ColorCode == "random")
        {
        switch (d3())
            {
            case 1: ColorCode = RGB(Random(128)+128,Random(192)+64,Random(192)+64); break;
            case 2: ColorCode = RGB(Random(192)+64,Random(128)+128,Random(192)+64); break;
            case 3: ColorCode = RGB(Random(192)+64,Random(192)+64,Random(128)+128); break;
            }

         return ColorCode + sText + "</c>";
         }

    else return sText;
}


string RainbowText(string SpectrumString)
{
    int i=1;
    string ReturnString;

    while (i<(GetStringLength(SpectrumString)+1))
    {
        ReturnString = ReturnString + Random_Color_Text("random",GetSubString(SpectrumString,i-1,1));
        i++;
    }
    return ReturnString;
}

int LoInt(int iInt1, int iInt2) {return (iInt1>iInt2)?iInt2:iInt1;}

int HiInt(int iInt1, int iInt2) {return (iInt1>iInt2)?iInt1:iInt2;}

string JumbleCode(string JColor1, string JColor2)
{
    string sR1=(GetSubString(JColor1,0,1));
    string sG1=(GetSubString(JColor1,1,1));
    string sB1=(GetSubString(JColor1,2,1));

    string sR2=(GetSubString(JColor2,0,1));
    string sG2=(GetSubString(JColor2,1,1));
    string sB2=(GetSubString(JColor2,2,1));

    int RHi=HiInt(ASCIIToInt(sR1),ASCIIToInt(sR2));
    int RLo=LoInt(ASCIIToInt(sR1),ASCIIToInt(sR2));
    int GHi=HiInt(ASCIIToInt(sG1),ASCIIToInt(sG2));
    int GLo=LoInt(ASCIIToInt(sG1),ASCIIToInt(sG2));
    int BHi=HiInt(ASCIIToInt(sB1),ASCIIToInt(sB2));
    int BLo=LoInt(ASCIIToInt(sB1),ASCIIToInt(sB2));

    return ASCII(Random(RHi-RLo)+RLo+1)+ASCII(Random(GHi-GLo)+GLo+1)+ASCII(Random(BHi-BLo)+BLo+1);
}

//Jumble Text randomly selects a color between Color1 and Color2
string JumbledText(string Color1, string Color2, string JumbleString)
{
    int j;
    string ReturnString;
    while (j<(GetStringLength(JumbleString)))
    {
        ReturnString = ReturnString+"<c"+JumbleCode(Color1,Color2)+">"+GetSubString(JumbleString,j,1)+"</c>";
        j++;
    }
    return ReturnString;
}


