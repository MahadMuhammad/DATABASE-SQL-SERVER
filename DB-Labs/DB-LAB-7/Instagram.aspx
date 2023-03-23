<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Instagram.aspx.cs" Inherits="WebApplication2.WebForm1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <!-- Added insta image https://en.wikipedia.org/wiki/Instagram#/media/File:Instagram_logo_2022.svg in centre of page with asp:Image control -->
    <form id="form1" runat="server">
    <div style="text-align: center;">
        <asp:Image ID="InstaLogo" runat="server" ImageUrl="https://scontent.flhe13-1.fna.fbcdn.net/v/t39.8562-6/281121690_1405565156561528_5410302815916975490_n.png?_nc_cat=100&ccb=1-7&_nc_sid=6825c5&_nc_ohc=xC-892Qt3ywAX_D-uYO&_nc_ht=scontent.flhe13-1.fna&oh=00_AfAVJsT4F8vtQm6sjLIpTkd95-uDTpPYldqm3RSOhHCO_g&oe=6421597E" Height = "200px" Width = "200px"/> 

        <!-- Adding Line Break -->
        <br />  
        <br />  

        <!-- Adding text "Create an Account" in centre of page with asp:Label control -->
        <asp:Label ID="Label1" runat="server" Text="Create an Account" Font-Size="Large" ForeColor="Black" Font-Bold="True"    />

    </div>
    <div>

        
        <!-- Adding Line Break -->
        <br />
        <br />

        <!-- Adding text "First Name" to page left -->
        <text style="text-align: left;">First Name : </text>

        <!-- Adding text box to page -->
        <asp:TextBox ID="TextBox1" runat="server" Width="200px" Height="20px" TextMode="SingleLine" />

        <!-- Adding text "Last Name" to page left -->
        <text style="text-align: left;">Last Name : </text>

        <!-- Adding text box to page -->
        <asp:TextBox ID="TextBox" runat="server" Width="200px" Height="20px" TextMode="SingleLine" />

        <br/>
        <br/>

        <!-- Adding text "Username" to page left -->
        <text style="text-align: left;">User Name : </text>

        <!-- Adding text box to page -->
        <asp:TextBox ID="TextBox2" runat="server" Width="200px" Height="20px" TextMode="SingleLine" />

        <br/>
        <br/>

        <text style="text-align: left;">Password : </text>
        <!-- Adding Password to page -->
        <asp:TextBox ID="TextBox3" runat="server" Width="200px" Height="20px" TextMode="Password" />
    </div>

    <div>
        <br/>
        <br/>
        <!-- Text:date of birth -->
        <text style="text-align: left;">Date of Birth : </text>
    </div>

    <div>
        <!-- Adding calender to page https://www.tutorialspoint.com/asp.net/asp.net_calenders.htm-->
        <asp:Calendar ID="Calendar1" runat="server" />
    </div>

    <div>
        <br/>
        <!-- text:Country -->
        <text style="text-align: left;">Country : </text>

        <!-- Adding drop down list to page https://www.tutorialspoint.com/asp.net/asp.net_dropdownlist.htm-->
        <asp:DropDownList ID="DropDownList1" runat="server" Width="200px" Height="20px">
            <asp:ListItem>India</asp:ListItem>
            <asp:ListItem>USA</asp:ListItem>
            <asp:ListItem>UK</asp:ListItem>
            <asp:ListItem>Canada</asp:ListItem>
            <asp:ListItem>Japan</asp:ListItem>
            <asp:ListItem>China</asp:ListItem>
            <asp:ListItem>France</asp:ListItem>
            <asp:ListItem>Germany</asp:ListItem>
            <asp:ListItem>Italy</asp:ListItem>
            <asp:ListItem>Spain</asp:ListItem>
            <asp:ListItem>Sweden</asp:ListItem>
            <asp:ListItem>Switzerland</asp:ListItem>
            <asp:ListItem>Denmark</asp:ListItem>
            <asp:ListItem>Finland</asp:ListItem>
            <asp:ListItem>Norway</asp:ListItem>
            <asp:ListItem>Belgium</asp:ListItem>
            <asp:ListItem>Australia</asp:ListItem>
            <asp:ListItem>New Zealand</asp:ListItem>
            <asp:ListItem>South Africa</asp:ListItem>
            <asp:ListItem>Argentina</asp:ListItem>
            <asp:ListItem>Brazil</asp:ListItem>
            <asp:ListItem>Chile</asp:ListItem>
            <asp:ListItem>Colombia</asp:ListItem>
            <asp:ListItem>Ecuador</asp:ListItem>
            <asp:ListItem>Peru</asp:ListItem>
            <asp:ListItem>Venezuela</asp:ListItem>
            <asp:ListItem>Uruguay</asp:ListItem>
            <asp:ListItem>Paraguay</asp:ListItem>
            <asp:ListItem>Costa Rica</asp:ListItem>
            <asp:ListItem>Guatemala</asp:ListItem>
            <asp:ListItem>Honduras</asp:ListItem>
            <asp:ListItem>El Salvador</asp:ListItem>
            <asp:ListItem>Nicaragua</asp:ListItem>
            <asp:ListItem>Panama</asp:ListItem>
            <asp:ListItem>Philippines</asp:ListItem>
            <asp:ListItem>Thailand</asp:ListItem>
            <asp:ListItem>Indonesia</asp:ListItem>
            <asp:ListItem>Malaysia</asp:ListItem>
            <asp:ListItem>Singapore</asp:ListItem>
        </asp:DropDownList>
    </div>


    <div>
        <br/>
        <!-- text:Gender: -->
        <text style="text-align: left;">Gender :   Male : </text>

        <!-- Adding radio button to page https://www.tutorialspoint.com/asp.net/asp.net_radiobutton.htm-->
        <asp:RadioButton ID="rdMale" GroupName="Gender" runat="server" />

        <text style="text-align: left;">  Female : </text>

        <asp:RadioButton ID="rdMale2" GroupName="Gender" runat="server" />
    </div>

    <div>
        <br/>
        <asp:CheckBox ID="chkIsStudent" runat="server" />
        <text style="text-align: left;">Enable Privacy</text>


        <br/>
        <br/>
        <br/>
        <asp:Button ID="btnSave" Text="Save Form" runat="server" />

    </div>
    

    

        
    </form>
</body>
</html>
