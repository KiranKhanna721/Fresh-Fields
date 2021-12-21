import "commonReactions/all.dsl";

context 
{
    input phone: string;
    name: string = ""; 
}


start node root 
{
    do 
    {
        #connectSafe($phone);
        #waitForSpeech(1000);
        #sayText("Hi, this is Dasha calling to know about farming. Is it a good time to talk?");
        #sayText("Can you say your name?");
        wait *;
    }    
    transitions 
    {
         node_2: goto node_2 on #messageHasData("name");
        will_call_back: goto will_call_back on #messageHasIntent("no");
        farming: goto farming on #messageHasIntent("yes");
    }
}
node node_2
{
   do
   {
       set $name =  #messageGetData("name")[0]?.value??""; //assign variable $name with the value extracted from the user's previous statement
       #log($name);
       #say("pleased_meet", {name: $name} );
       wait*;
   }
   transitions 
    {
        will_call_back: goto will_call_back on #messageHasIntent("no");
        farming: goto farming on #messageHasIntent("yes");
    }
}

node will_call_back
{
    do
    {
        #sayText("No worries. Please make sure to call back before your shift. Looking forward to speaking to you soon! Bye!");
        #disconnect();
        exit;
    }
}

node farming
{
    do
    {
        #sayText("Perfect. Now,are you facing any diffcuities while farming ?");
        wait *;
    }
    transitions
    {
        farm_yes: goto farm_yes on #messageHasIntent("yes") or #messageHasIntent("farming");
        farm_no: goto farm_no on #messageHasIntent("no");
    }
}

node farm_yes
{
    do
    {
        #sayText("Do you need technical help  or financial help?"); 
        wait *;
    }
    transitions
    {``
        technical: goto technical on  #messageHasIntent("technical");
        financial: goto financial on #messageHasIntent("financial") or #messageHasIntent("money");
        bye: goto bye on #messageHasIntent("no");
    }
}

node farm_no
{
    do 
    {
        #sayText("That's good news! Is your farming going well?");
        wait *;
    }
    transitions 
    {
       bye: goto bye on #messageHasIntent("yes");
       farm_yes: goto farm_yes on #messageHasIntent("no") or #messageHasIntent("farming");
    }
}

node technical
{
    do
    {
        #sayText("Got that.It is your first time when you are farming?");
        wait *;
    }
    transitions
    {
        farm_first: goto farm_first on #messageHasIntent("yes");
        farm_first_no: goto farm_first_no on #messageHasIntent("no") ;
    }
}

node financial
{
    do
    {
        #sayText("Uh-huh, got that. Do you need money to bye seeds or etc ,for farming?");
        wait *;
    }
    transitions
    {
        financial_yes: goto finanical_yes on #messageHasIntent("yes") or #messageHasIntent("maybe");
        bye: goto bye on #messageHasIntent("no");
    }
}

node farm_first
{
    do
    {
        #sayText("The main steps for agricultural practices include"); 
        #sayText("preparation of soil");
        #sayText("sowing");
        #sayText("adding manure and");
        #sayText("fertilizers, irrigation, harvesting and storage");
        #sayText("Do you want to know about how to select the crop or fertilizers for a particular soil ?");
        wait *;
    }
    transitions
    {
        farm_first_yes: goto farm_first_yes on #messageHasIntent("yes") or #messageHasIntent("maybe");
        bye: goto bye on #messageHasIntent("no");
    }
}

node farm_first_no
{
    do
    {
        #sayText("Do you want to know about how to select the crop or fertilizers for a particular soil ?");
        wait *;
    }
    transitions
    {
        farm_first_yes: goto farm_first_yes on #messageHasIntent("yes") or #messageHasIntent("maybe");
        bye: goto bye on #messageHasIntent("no");
    }
}

node finanical_yes
{
    do
    {
        #sayText("Mhm, got that.Do you want to borrow money?");
        wait *;
    }
    transitions
    {
        paid: goto paid on #messageHasIntent("yes") or #messageHasIntent("maybe") or #messageHasIntent("payment");
        bye: goto bye on #messageHasIntent("no") ;
    }
}

node farm_first_yes
{
    do
    {
        #sayText("Perfect, I'm glad to hear that!");
        #sayText("what is crop recommendation?");
        #sayText("Precision agriculture is a modern farming technique that uses research data of soil characteristics, soil types, crop yield data collection and suggests the farmers the right crop based on their site-specific parameters.");
        #sayText("The fertilizer recommendation are made to apply enough fertilizers to both meet the nutrient requirements of the crop and to build up the nutrient level in the soil to a critical soil test level over a planned timeframe.");
        #sayText("woud you like to visit our website where we can recommended crops and fertilizers based on some parameters ?");
        wait *;
    }
    transitions
    {
        website_yes: goto website_yes on #messageHasIntent("yes") or #messageHasIntent("maybe");
        bye: goto bye on #messageHasIntent("no") ;
    }
}

node website_yes
{
    do
    {
        #sayText("https://fresh-fields.herokuapp.com/");
    }
transitions
    {
        bye: goto bye;
    }
}




node paid
{
    do 
    {
        #sayText("Yes, absolutely.Do you have any other questions like details and how to borrows and steps to be followed?");
        wait *;
    }
    transitions 
    {
       question: goto question on #messageHasIntent("yes") or #messageHasIntent("question");
       bye: goto bye on #messageHasIntent("no");    
    }
}

node question
{
    do 
    {
        #sayText("I'm sorry but I'm not quite sure I can answer that. I suggest you contact our bank manager about that. Is that okay?");
        wait *;
    }
    transitions 
    {
       bye: goto bye on #messageHasIntent("yes");
       can_help_then_: goto bye on #messageHasIntent("no");    
    }
}

digression paid
{
    conditions {on #messageHasIntent("payment");}
    do 
    {
        #sayText("Yes, absolutely. You can borrow money based on your salary.");
        #repeat(); // let the app know to repeat the phrase in the node from which the digression was called, when go back to the node
        return; // go back to the node from which we got distracted into the digression
    }
}

node bye
{
    do
    {
        #sayText("Great! Thank you for taking time to reply to the questions, we're looking forward to seeing you at work in a bit. Talk to you tomorrow! Bye!");
        #disconnect();
        exit;
    }
}


node can_help_then 
{
    do
    {
        #sayText("How can I help you then?");
        wait *;
    }
    transitions 
    {
       question: goto question on #messageHasIntent("yes") or #messageHasIntent("question");
    }
}

digression bye 
{
    conditions { on #messageHasIntent("bye"); }
    do 
    {
        #sayText("Thanks for your time. Have a great day. Bye!");
        #disconnect();
        exit;
    }
}