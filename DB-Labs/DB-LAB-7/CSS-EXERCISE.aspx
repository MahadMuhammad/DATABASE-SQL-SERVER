<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CSS-EXERCISE.aspx.cs" Inherits="WebApplication2.CSS_EXERCISE" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<!-- CSS code goes here -->
<style>  
    /* This is class selector */
    body{
        font-family: Arial, Helvetica, sans-serif;
        background-color: #f1f1f1;
        border-color: #04AA6D;
        font-size: 50px;
        color: white;
    }

    #submit{
        /* This is id selector */
        background-color: #4CAF50;
        /* make border blue bold; */
        border: 5000px solid blue;
        color: white;
        padding: 16px 20px;
        border-color: yellow;
        margin: 10px 0;
        border: red;
        /* Make border dark blue; */
        cursor: pointer;
        width: 30%;
    }

    .buttonCSS{
        height: 50px;
        background-color: #4CAF50;
        /* make border blue bold; */
        border: 5000px solid blue;
        border-color: blue;
        color: white;
        border-color: #04AA6D;
        padding: 16px 20px;
        margin: 8px 0;
        border: none;
        cursor: pointer;
        width: 25%;
    }
    .border-3px {
        border-color: black;
        font-size: 20px;
        color: #4CAF50;
    border-width: 3px;
    }

    h1{
        font-size: 55px;
        font-style: Times New Roman;
        color: blue;
    }

    h2{
        font-size: 18px;
        color: purple;
    }
    text{
        font-size: 15px;
        color: purple;
    }
</style>

<body>
    <form id="form1" runat="server">
        <div>

            <h1>Currency Converting Web Site</h1>
            <br/>
        </div>
        <div>

            <text>Select Currency Medium</text>
            <!-- drop down -->
            <asp:DropDownList ID="DropDownList1" runat="server" CssClass="buttonCSS">
                <asp:ListItem>Select</asp:ListItem>
                <asp:ListItem>EURO</asp:ListItem>
                <asp:ListItem>YEN</asp:ListItem>
                <asp:ListItem>POUND</asp:ListItem>
                </asp:DropDownList>

            <br/>

            <text>
                Please Enter amount in Rupees to convert to your Selected Medium:
            </text>

            <asp:Button ID="Button1" runat="server" Text="Button 1" CssClass="buttonCSS" />

            <br/> 
            <br/>

            <asp:Button ID="Button2" runat="server" Text="Convert rupees to selected medium" CssClass="buttonCSS" />

            <br/>
            <br/>

            <text>Amount from Rupees to your chosen medium</text>
            <asp:Button ID="Button9" runat="server" Text="Button 1" CssClass="buttonCSS" />

            <br/>
            
            <text>Please enter amount in your chosen medium to convert to Rupees.</text>
            <asp:Button ID="submit" runat="server" Text="Button 3" CssClass="buttonCSS" />

            <br/>

            <text>Amount from your chosen medium to Rupees: </text>
            <asp:Button ID="submit2" runat="server" Text="Rupees" CssClass="buttonCSS" />

            <br/>

            <text>Your Previous Chosen medium was : </text>
            <asp:Button ID="submit5" runat="server" Text="Rupees" CssClass="buttonCSS" />
            
            <br/>

            <text>Programmed by : </text>
            <asp:Button ID="submit10" runat="server" Text="Muhammad Mahad, 21L-6195" CssClass="buttonCSS" />
            
            <br/>
            <br/>
            <!-- Reset button with red border -->
            <asp:Button ID="submit3" runat="server" Text="Reset" CssClass="buttonCSS" />
        </div>

        
    </form>
</body>



</html>
