<%@ Page Title="Signup Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SignupPage.aspx.cs" Inherits="EventManagerWebApp.SignupPage" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="jumbotron">
        <h1>Signup</h1>
        <div>
            <asp:CreateUserWizard ID="CreateUserWizard1" runat="server" BackColor="#EFF3FB" BorderColor="#B5C7DE" BorderStyle="Solid" BorderWidth="1px" Font-Names="Verdana" Font-Size="0.8em" Width="489px">
                <ContinueButtonStyle BackColor="White" BorderColor="#507CD1" BorderStyle="Solid" BorderWidth="1px" Font-Names="Verdana" ForeColor="#284E98" />
                <CreateUserButtonStyle BackColor="White" BorderColor="#507CD1" BorderStyle="Solid" BorderWidth="1px" Font-Names="Verdana" ForeColor="#284E98" />
                <TitleTextStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                <WizardSteps>
                    <asp:CreateUserWizardStep runat="server" />
                    <asp:CompleteWizardStep runat="server" />
                </WizardSteps>
                <HeaderStyle BackColor="#284E98" BorderColor="#EFF3FB" BorderStyle="Solid" BorderWidth="2px" Font-Bold="True" Font-Size="0.9em" ForeColor="White" HorizontalAlign="Center" />
                <NavigationButtonStyle BackColor="White" BorderColor="#507CD1" BorderStyle="Solid" BorderWidth="1px" Font-Names="Verdana" ForeColor="#284E98" />
                <SideBarButtonStyle BackColor="#507CD1" Font-Names="Verdana" ForeColor="White" />
                <SideBarStyle BackColor="#507CD1" Font-Size="0.9em" VerticalAlign="Top" />
                <StepStyle Font-Size="0.8em" />
            </asp:CreateUserWizard>
        </div>
        <div>

        </div>
    </div>
</asp:Content>
