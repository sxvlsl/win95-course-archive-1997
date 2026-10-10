





  PRODUCT  :  Delphi                                 NUMBER  :  2779
  VERSION  :  All
       OS  :  Windows
     DATE  :  July 14, 1995                            PAGE  :  1/21

    TITLE  :  Delphi Client/Server and Power Builder Compared




An Evaluation of
Client/Server Development Tools: 
A Comparison Between 
Delphi Client/Server and PowerBuilder Enterprise
 
Prepared by Michael Lant, Sphere Data Systems
 
 
Table of Contents
 
Introduction: An Overview of Client/Server Tools  
     PCs and the Evolving Client/Server Model
     The Next Generation
 
What is Delphi?     
     Redefining Client/Server Development
     The Delphi Component Model
 
Performance    
     Compiled vs Interpreted Code
     Data Access - A New Approach
 
Rapid Application Development (RAD)     
     Minimum Coding, Maximum Flexibility
     DataWindows vs Reusable Forms
 
Component Reuse     
     The Delphi Inheritance Model
     A DataWindows Alternative
     Exception Handling
 
Database Scalability     
     Borland Database Engine
     Local InterBase Server
 
Conclusion     
 
 













  PRODUCT  :  Delphi                                 NUMBER  :  2779
  VERSION  :  All
       OS  :  Windows
     DATE  :  July 14, 1995                            PAGE  :  2/21

    TITLE  :  Delphi Client/Server and Power Builder Compared




Introduction: An Overview of Client/Server Tools
 
 
Client/server development tools remain one of the fastest-growing
sectors of the software industry. Forrester Research predicts
that the number of client/server developers will climb from
128,400 in 1994 to 698,000 in 1996, while META Group research
suggests that over 90% of all new applications will be based on
the client/server model. This is an overwhelming endorsement of
the popularity of client/server computing. 
 
Client/server computing, however, is not the panacea that many
have been predicting. Complex environments, with mixed data
sources and immature development tools, have made client/server
development a complex undertaking. Researchers such as the
Gartner Group have found that the most pressing issues facing
current developers of client/server applications include
performance of deployed applications, rapid application
development (RAD), component reuse and database scalability.
Although these concerns are not unique to client/server
application development, they are perhaps even more important in
this sector, because of the well-documented limitations of
first-generation client/server tools. 
 
PCs and the Evolving Client/Server Model
 
PCs facilitated the downsizing era, by providing inexpensive
platforms for the production of  reasonably capable solutions
that addressed genuine business needs. These applications brought
with them the promise of freedom from host-based technologies and
shortened development cycles. But as these PC- and network-based
applications grew, user counts expanded and more functionality
was necessary. PC database applications frequently "hit the
wall."   
 
In addition, all database applications have at their very heart
business rules. These rules control processes such as creating
new customers and data validation. Historically, PC application













  PRODUCT  :  Delphi                                 NUMBER  :  2779
  VERSION  :  All
       OS  :  Windows
     DATE  :  July 14, 1995                            PAGE  :  3/21

    TITLE  :  Delphi Client/Server and Power Builder Compared




development has placed the enforcement of business rules into the
user interface, so programmers would create a screen and write
code to respond to user input. This code would perform a specific
action based on the presence, or value of, certain information.
Such actions might include allowing or preventing the posting of
changes to customer data. But the user interface is certainly not
the best place to store business rules. 
 
The advent of client/server brought with it a new model that
allows for business rules to be stored with the data itself. This
is accomplished through the use of triggers and stored procedures
created in the actual database. These procedures would enact
routines to perform much the same processing that might be
performed in a PC application, except that the host handles this
task for all of its clients. This approach ensured that there was
only one source for the business rules, since they were stored
with the data. In many ways, this approach is enticing, but in
reality it is plagued with problems. 
 
When business rules are created to be enforced at the server
level, they tend to be difficult to write and debug. According to
David Sarna and George Febish in the September 1994 issue of
Datamation: "These are not the tools for creating and maintaining
good code. Doing it this way is SQL-abuse; SQL as a query
language was never designed to do this kind of procedural
computation." 
 
With this model, as an application grows, so do the number of
rules that must be created and controlled by the database. Rather
than focusing on the efficient storage and retrieval of data,
server resources become tied down enforcing business rules - such
as ensuring that a last name is supplied for each new customer.
Again, Sarna and Febish point out that "many of your business and
validation rules are needed so often that they must sit on the
client, or performance will go straight to hell." 
 
The Next Generation
 













  PRODUCT  :  Delphi                                 NUMBER  :  2779
  VERSION  :  All
       OS  :  Windows
     DATE  :  July 14, 1995                            PAGE  :  4/21

    TITLE  :  Delphi Client/Server and Power Builder Compared




Borland's Delphi is truly a next generation client/server
development tool. Although it fully supports the placement of
business rules in the user interface or on the server (or even a
combination of both), it also presents the possibility of another
model that separates the business rules from both the user
interface and the server. This approach has the potential to
provide greater performance, better scalability, better code
reuse and an ideal platform for RAD. Delphi makes this possible
because it employs an open architecture, whereby developers can
use or create a wide variety of specialized components when
creating applications. 
 
Comparative reports of software tools typically focus on feature
matrices or checklists to relate the features of one product
versus those of its competitors - and in this context Delphi
would certainly emerge as a winner. Checklists, however, do not
necessarily help developers understand how one product could be
far more effective than another. Thus, the content of this white
paper is focused on the needs of client/server application
developers, and how Delphi addresses those needs. 
 
 
What is Delphi?
 
Delphi represents the next generation of client /server and
general Windows application development tools. It is a product of
Borland's long-standing leadership in programming languages,
database development tools, and object-oriented programming (OOP)
technology. Delphi is unique in providing a completely visual
integrated development environment (IDE) that is built around a
powerful object-oriented compiled language (Object Pascal). The
IDE shields programmers from the complexity of Windows
development, by encapsulating the Windows application programming
interface (API) inside robust, reusable components. 
 
The implementation of a component-based architecture enhances
power and flexibility. Components range from simple items (such
as buttons, text edit regions or sliders) through to powerful













  PRODUCT  :  Delphi                                 NUMBER  :  2779
  VERSION  :  All
       OS  :  Windows
     DATE  :  July 14, 1995                            PAGE  :  5/21

    TITLE  :  Delphi Client/Server and Power Builder Compared




specialized tools (such as high-performance database components
used for table access, queries and batch updates). While most
client/server development tools include a limited selection of
these basic components, Delphi ships with more than 75 reusable
components. 
 
Developers may modify Delphi components, create their own, or
purchase third-party components (which include text processors,
graphics, communications and statistical utilities, among
others). Once installed on Delphi's component palette, these
additional components become part of the IDE, so that Delphi can
be tailored to whatever the developer (or team of developers)
specifically requires. 
 
Because of the unique way in which components are implemented in
Delphi, it offers similar open architecture benefits to those of
the ISA bus, for example. A component is a self-contained block
of code that includes all functionality to work within a Delphi
application. Just like inserting a new PC expansion card, any new
component added to the library becomes part of Delphi and is
indistinguishable from those that ship with the product. This
open, component-based structure means that Delphi developers are
not tied to any particular development methodology, and may use
whatever tools or components are necessary to accomplish a task. 
Redefining Client/Server Development
 
First generation visual client/server development tools (such as
PowerBuilder) feature environments where all components are
tightly integrated and dependent upon one another. Such an
approach does not encourage modification or customization of
existing components, because when a component is significantly
altered, it has the potential of changing the way in which it
interacts with others. This not only impedes the evolution of the
base product, but it also has the potential to introduce
unpredictable behavior. 
 
Delphi, on the other hand, has as its foundation a true
object-oriented language, with the result that its components are













  PRODUCT  :  Delphi                                 NUMBER  :  2779
  VERSION  :  All
       OS  :  Windows
     DATE  :  July 14, 1995                            PAGE  :  6/21

    TITLE  :  Delphi Client/Server and Power Builder Compared




essentially autonomous objects. Component changes are therefore
unlikely to affect overall product stability. Also, problems with
any specific component behavior can often be corrected by the
developer via subclassing, and thereby overriding the errant
behavior. This also holds true for components created by a
developer or purchased from third-party suppliers. 
 
Delphi Component Types
 
Delphi's Visual Component Library (VCL) includes more than 75
pre-built components, which can be used in applications and
deployed freely. These include the following: 
 
Standard - Menus, Edit, Label, Buttons, Scroll Bar;
 
Additional - Bitmap Button, SpeedButton, Notebook, Outline,
DrawGrid, Image, Multimedia; Data Access - Database, Table,
Query, Batch Move, Report;
 
Data Controls - DataGrid, DBNavigator, DBLabel, DBEdit, DBImage,
ComboBoxes; 
 
Dialogs - Open, Save, Font, Color, Print, Print Setup,
Search/Replace, Tabbed Notebook;
 
System - Timer, FileListBox, Drive and Directory Combo OLE, DDE;
 
VBX - Chart, Picture, Gauge;
 
Samples - Gauge, ColorGrid, SpinButton, SpinEdit, Outline,
Calendar. 
 
Delphi developers can also create their own components, by
modifying existing Delphi components or building them from
scratch. The source code for Delphi's VCL is available to help
developers in this task. Newly-developed components (or those
purchased from third-party developers) can be added to Delphi's
component palette. 













  PRODUCT  :  Delphi                                 NUMBER  :  2779
  VERSION  :  All
       OS  :  Windows
     DATE  :  July 14, 1995                            PAGE  :  7/21

    TITLE  :  Delphi Client/Server and Power Builder Compared




 
 
Performance
 
In a client/server environment, overall performance depends upon
a combination of factors, including efficiency of  the database
server, network bandwidth, "middleware" or driver performance,
data access techniques, and speed of the user interface. A
well-designed architecture should leverage all of these
characteristics. In almost all respects, Delphi outperforms
PowerBuilder by a significant margin, due to its optimizing
compiler, efficient VCL components and high-performance native
SQL drivers. Some sample benchmark results are listed below: 
 
Operation (All times in seconds)   Delphi         PowerBuilder 
String parse to measure            2.7            22.8 
non-database performance;reading 
file and splitting record into 
substrings
 
Use a query to load a form from    4.6            70.9
a 20,000 record table.  Form 
supports searching and filtering.
 
Post a record (single order)       1.4            1.3 
 
Apply a filter on 20,000 record    3.0            6.2 
table               
 
Update record                      1.5            1.1 
 
Search for a value, 20,000 records 1.1            1.5 
 
User Interface Performance and Compiled vs Interpreted Code 
The user interface (UI) is the most visible portion of any
application. UI performance covers obvious functionality such as
screen updates, along with the underlying processing of data
(including numerical calculations and string manipulations). It













  PRODUCT  :  Delphi                                 NUMBER  :  2779
  VERSION  :  All
       OS  :  Windows
     DATE  :  July 14, 1995                            PAGE  :  8/21

    TITLE  :  Delphi Client/Server and Power Builder Compared




is the portion that users interact with every day, and it is also
the first place where performance differs noticeably between
PowerBuilder and Delphi. 
 
Delphi uses an optimizing native code compiler to generate
standalone executable files (.EXEs) containing machine code
instructions. These executable files are self-contained and,
other than the database engine and the data itself, require no
external files to run. Although PowerBuilder creates an
executable file, it is not truly compiled. When a PowerBuilder
application is run, source code instructions are converted to
machine code before the instructions may be executed. This extra
level of translation introduces significant run-time overhead and
seriously degrades performance. 
 
To support its runtime interpretation, PowerBuilder requires
external support files in the form of  runtime interpreter
Dynamic Link Libraries (DLLs). In addition to the application
code, these DLLs must be loaded into memory at runtime, creating
a larger memory "footprint" and leaving less memory for
processing and buffering data. As a result, Delphi applications
execute between 10 and 20 times faster than applications created
using p-code ("pseudo-code") interpreters such as PowerBuilder,
even on target systems with minimal memory. 
 
In moving from PowerBuilder 3.0a to 4.0, PowerSoft tuned its
runtime interpreter to achieve slightly better performance on
systems fitted with 16M of memory. This performance boost often
comes at a cost, however, as final applications can increase from
20 to 70 percent in size. Despite minor enhancements, there is no
way for an interpreted p-code language to even approach the
execution speed of a compiled language like that of Delphi. 
 
Data Access - A New Approach
 
The two primary methods of implementing client/server solutions
with PowerBuilder involve placing business rules on either the
client or the server. Unfortunately, neither one adequately













  PRODUCT  :  Delphi                                 NUMBER  :  2779
  VERSION  :  All
       OS  :  Windows
     DATE  :  July 14, 1995                            PAGE  :  9/21

    TITLE  :  Delphi Client/Server and Power Builder Compared




addresses the issue of overall performance. If developers choose
to place the burden of enforcing business rules on the server,
they risk performance bottlenecks due to server and network
overload. Yet shifting this task to the comparatively slow
PowerBuilder UI is not an ideal solution. As it turns out,
PowerBuilder's design makes it difficult not to attach at least
some of the business rules directly to the UI. 
 
Delphi, on the other hand, fully supports either of these
techniques, as well as allowing for a more flexible model. Delphi
developers can create a "virtual third-tier" layer containing
business rules independent of  the UI and the server. Instead,
these rules can be encapsulated in non-visual components (NVCs)
in a layer between the UI and database engine. Physically and
conceptually, this separates the data and related rules from its
representation to the user. 
 
This approach brings the distributed computing vision of
client/server another step closer to reality, and also provides a
practical means of enhancing performance. All data moving to and
from the application passes through this central conduit. The
"third-tier" NVCs may be single Delphi components such as a
TTable or TQuery or sophisticated combinations of components. By
having a single access point to lookup tables (such as State,
Province or Product Codes that may be used by several forms), the
application need only fetch this data once - when it is started.
This can greatly reduce the number of server requests,
alleviating network traffic and server load. 
 
More importantly, developers can place connections to the main
database tables here as well. As users move between forms,
cursors to their data would remain in place. Thus, if basic
customer information were displayed in one form, moving to
another form displaying credit history would invoke it already
pointing to the appropriate customer. PowerBuilder has limited
functionality in this area through the dwShareData function,
which allows sharing of data between DataWindows. This process
results in duplication of large, complex components, and unless













  PRODUCT  :  Delphi                                 NUMBER  :  2779
  VERSION  :  All
       OS  :  Windows
     DATE  :  July 14, 1995                            PAGE  :  10/21

    TITLE  :  Delphi Client/Server and Power Builder Compared




sufficient RAM is available, this can further degrade client
performance. In the same situation, Delphi reduces the number of
components used, since data access and display are accomplished
with separate components. 
 
 
Rapid Application Development (RAD)
 
Rapid Application Development (RAD) is an attempt to address the
issues of building applications tailored to customer requirements
and completing projects with minimal re-working. Historically,
serious application development involved tremendous effort from a
team of analysts who quizzed potential users to determine every
possible requirement of the application. From this collection of
information, volumes of carefully documented specifications were
produced, then the users would sign off and programming
commenced. Some time later, the development team would finally
emerge with an application, and users were then expected to adopt
the product. 
 
This model had several shortcomings. Often, the people who built
the application were not the same as those who did the analysis,
resulting in reinterpretation of the specifications. Furthermore,
users are often not well equipped to diagnose and describe their
technology needs. During the development process, little
communication existed between the developers and eventual users
of the application. In days gone by, when terminals and batch
operations were the only UI, this may have been an adequate
model. However, with the advent of PCs, user expectations are
significantly higher in regard to the UI characteristics of
modern client/server applications. These applications must now
provide access to data, and present it in ways that are most
meaningful to users, with tools to assist in the analysis and
interpretation of the data. As a result, most large organizations
are confronted with a backlog of applications, which must be
tackled with limited staff, budgets and time. 
 
RAD is a development methodology based around an iterative













  PRODUCT  :  Delphi                                 NUMBER  :  2779
  VERSION  :  All
       OS  :  Windows
     DATE  :  July 14, 1995                            PAGE  :  11/21

    TITLE  :  Delphi Client/Server and Power Builder Compared




process of specifying, creating and enhancing an application
until the final product is completed. RAD is based on the notion
that it is difficult to fully predefine a problem domain as
complex as today's typical business applications. As the
developers step through each iteration from prototype to finished
product, the requirements become more clearly defined. Although
not ideal for batch-style applications, RAD is very effective for
the development of applications where the UI design is a key
consideration. 
 
Minimum Coding, Maximum Flexibility
 
RAD development tools should allow developers to quickly build
prototypes with as little code as possible, and Delphi is very
powerful in this respect. Building a database application with a
classic Customer -> Orders -> Details form (including database
connections) can be done with no lines of code in Delphi. By
comparison, PowerBuilder developers must write a dozen lines of
code to simply link to a database, then they must also write code
to open the form, query the tables and synchronize the tables
appropriately. 
 
Delphi's comprehensive array of data-aware components minimizes
the level of customization that must be done to deliver a
necessary feature or function. Where appropriate functionality
does not exist in a VCL component, developers have the option of
modifying the component or using a third-party component (such as
a VBX control or Delphi native component). Any component may be
subclassed (exploiting inheritance) and reused in other areas. 
 
DataWindows vs Reusable Forms
 
RAD methodology assumes that application design evolves through
several phases, so a true RAD tool should allow developers to
easily adapt to changes (which can be significant). Because
PowerBuilder combines data access and display in a single
component, some design changes can prove extremely difficult.
When a customer requirement suddenly dictates a new approach to













  PRODUCT  :  Delphi                                 NUMBER  :  2779
  VERSION  :  All
       OS  :  Windows
     DATE  :  July 14, 1995                            PAGE  :  12/21

    TITLE  :  Delphi Client/Server and Power Builder Compared




either data access or display, this often requires a rewrite of
the DataWindow and/or the entire form. Since Delphi separates
these two concepts, the adaptation process is much simpler. 
 
As with most first-generation visual development tools,
PowerBuilder embeds application code inside objects - with the
exception of the DataWindow, which represents both the conduit
and the display format of the data. A DataWindow is created in a
separate section (or "painter"), and cannot have event-handling
code written until it is pasted into a form, whereupon the
relevant application code is then permanently attached to that
DataWindow. Since code is hidden inside objects scattered about
the form, it becomes difficult for developers to locate, and it
also may be affected by modifications to objects on the form.
Furthermore, by "hard-wiring" the DataWindow to the code, it
becomes difficult to reuse that DataWindow in other forms. 
Delphi developers address this issue by writing event handlers,
which are pointers to specific procedures, or references within
components that indicate what procedure will be called when a
particular event occurs (mouse click, timer interrupt, etc). Form
procedures are stored in a "unit" file, with all the code visible
to the developer, so there is no need to search through various
objects track down specific code fragments. Once procedures are
created, they may be called by any event of any component. Event
handlers can also call procedures written for any other event
handler, or even directly access components or procedures
residing in other forms. Deleting an object (such as a button)
does not delete procedures created for that object, so that code
changes are easier, faster and safer. 
 
Since Delphi uses the same property/event model for all
components, whether they are visual or non-visual, it is more
consistent and easier to learn than products such as
PowerBuilder. The end result is that Delphi clearly provides an
ideal environment for RAD. 
 
 
 













  PRODUCT  :  Delphi                                 NUMBER  :  2779
  VERSION  :  All
       OS  :  Windows
     DATE  :  July 14, 1995                            PAGE  :  13/21

    TITLE  :  Delphi Client/Server and Power Builder Compared




Component Reuse
 
Inheritance is the ability to create new objects (descendants)
from a base object (ancestor). A descendant inherits all
characteristics of the ancestor, although these can be
overridden. Inheritance is an object-oriented programming (OOP)
fundamental that provides a means by which programmers can reuse
code, and it encourages development of base objects with
characteristics that are likely to be used again. Since
descendants inherit any changes made to the parent object,
changes that are made will propagate throughout any objects that
descend from  a base object. The resulting collection of objects
is often called a class hierarchy or class library.  
 
PowerBuilder allows developers to use inheritance to create a
class library based on forms or groups of controls. The problem
with the PowerBuilder approach is that it emphasizes inheritance
of the user interface. Because DataWindows perform the task of
both data access and data display, and because of the close
binding between a DataWindow and various objects (and code) on a
form, UI inheritance is the only type of inheritance that makes
sense in PowerBuilder. However, what developers mostly need to
preserve and reuse is not the visual representation of the data,
but instead the complex logic that drives the business rules. In
fact, the visual representation usually changes the most. Hence,
reuse through inheritance in PowerBuilder often requires the
developer to spend significant time overriding the UI in order to
preserve the underlying code. As a result, PowerBuilder forms
often carry around much unwanted baggage. 
 
Delphi takes an entirely different approach. In its first
release, Delphi, supports inheritance of forms in code only,
compared to PowerBuilder's support of UI inheritance. With the
ability to separate business rules from the UI, a Delphi
developer need only write these once. Different forms can access
the same data components and inherit their business rules, but
are not bound to them. Hence the developer is free to create any
number of forms displaying data in whatever format is













  PRODUCT  :  Delphi                                 NUMBER  :  2779
  VERSION  :  All
       OS  :  Windows
     DATE  :  July 14, 1995                            PAGE  :  14/21

    TITLE  :  Delphi Client/Server and Power Builder Compared




appropriate, knowing that the non-visual components supplying
data to the user interface have fully encapsulated these business
rules. 
 
Such an approach would be difficult with a product such as
PowerBuilder, because the underlying interpreter-based
architecture is not truly object-oriented. According to Steve
Benfield, quoted in the June/July 1994 issue of PowerBuilder
Developers Journal: "PowerBuilder's DataWindows is not truly
object-oriented. I could try to not use DataWindows and code
PowerBuilder in a purely object-oriented way. However, the system
would be so slow that it would be useless." 
 
The Delphi Inheritance Model
 
Inheritance is fundamental to Delphi, and all VCL components
ultimately descend from an object known as TObject  (the "T"
prefix is an accepted standard to denote an object  type).
TObject has a great deal of capability built into it, and knows
how to handle certain types of errors, along with how to display
itself in the form designer. Many other components descend from
TObject, each acquiring more capability and becoming more
specialized along the way.  
 
The familiar case of copying to the Windows clipboard is an
example of where Delphi's inheritance can be most powerful. This
turns out to be a complex procedure requiring more than 100 lines
of code in PowerBuilder, whereas the following code sample shows
how the same CopyToClipBoard is handled in Delphi: 
 
  if (( ActiveControl ) is TCustomEdit ) then
TCustomEdit(ActiveControl).CutToClipBoard
 
 
This examples surfaces three important issues. The first is that
it highlights how some very basic functionality is missing from
PowerBuilder. The second is that Delphi developers deal with
functions such as this on a much higher level than with













  PRODUCT  :  Delphi                                 NUMBER  :  2779
  VERSION  :  All
       OS  :  Windows
     DATE  :  July 14, 1995                            PAGE  :  15/21

    TITLE  :  Delphi Client/Server and Power Builder Compared




traditional programming languages. Thirdly, the inheritance
benefits are obvious. TCustomEdit is an ancestor of most of the
editable components in Delphi (such as TEdit, TDBEdit and so on)
In this example, the is operator checks to see if the active
component  is a descendant of TCustomEdit, and if so, the next
line casts the active control as its ancestor - TCustomEdit.
Because CutToClipBoard is a method of TCustomEdit, all controls
inherited from it will also inherit this method.  
 
A DataWindows Alternative
 
DataWindows are an important feature of PowerBuilder. By
attempting to incorporate all database capability into a single
structure, the result is a component that is extremely powerful,
but highly complex. The PowerBuilder 3.0a reference manual
allocates almost 150 pages to explaining the properties and
syntax of the dwDescribe and dwModify functions, which are just
two of the more than 130 functions used within DataWindows.
According to Breck Carter, quoted in the June/July issue of
PowerBuilder Developers Journal: "dwModify( ) and dwDescribe is a
topic that I know has been a sticking point for many developers.
These functions can be daunting with their screwy syntax and
difficult-to-debug commands . . . If DataWindows' bazillion
functions and events don't get you, you probably won't avoid
being shocked and overwhelmed by dwModify." 
 
PowerBuilder developers place all of their code and forms in a
single .PBL application file, while Delphi applications reside in
three main file types. The application itself comprises .DPR and
.PAS files, while .DFM files contains the binary representation
of forms (buttons, grids etc). Delphi's project manager provides
a high-level view of all these files, and units from other
directories or projects can be easily included. By storing units
in separate files, team development is simplified and the
allocation of  tasks is made easier. Developers need not even  be
in the same physical location. 
 
During compilation, Delphi keeps track of which files have













  PRODUCT  :  Delphi                                 NUMBER  :  2779
  VERSION  :  All
       OS  :  Windows
     DATE  :  July 14, 1995                            PAGE  :  16/21

    TITLE  :  Delphi Client/Server and Power Builder Compared




changed since the last compile and only generates those changes.
Delphi's compilation speed is the fastest in the industry, at
more than 350,000 lines of code per minute on a 66MHz Pentium
fitted with 8M of RAM. A reasonably complex client/server
application containing over a dozen forms will compile all files
in less than a minute. 
 
 
 
PowerBuilder's interpreter-based design makes direct comparisons
with Delphi's compiled performance unrealistic. PowerBuilder
developers cannot exit the code painter until their code is
syntactically correct, so that moving between different code
areas is greatly restricted. PowerBuilder then generates p-code
from its scripting language, along with a runtime executable
file. This p-code generation stage takes about the same amount of
time as the complete syntax checking and compilation to machine
code of a Delphi application. The PowerBuilder application,
however, still requires translation and decoding overhead each
time it is executed. 
 
As the complexity of applications and size of development teams
grows, so does the need to maintain control of the process.
Keeping track of the latest versions of source files is an
important part of this process, and Delphi accomplishes this by
providing a direct interface to PVCS, a leading version control
utility. Delphi will directly link to the PVCS DLL and integrate
it into the development environment. 
 
PowerBuilder developers frustrated with limitations of its
programming language are forced to leave the environment and must
turn to languages such as C++ or Pascal. Once they leave
PowerBuilder, they must abandon any of their custom class
libraries, which are not supported by other products. Delphi does
not present such obstacles, as it is built around a comprehensive
structured, object-oriented language featuring pass-through SQL
commands and inline assembler. Since Delphi can encapsulate
applications into DLL format, any Windows program (including













  PRODUCT  :  Delphi                                 NUMBER  :  2779
  VERSION  :  All
       OS  :  Windows
     DATE  :  July 14, 1995                            PAGE  :  17/21

    TITLE  :  Delphi Client/Server and Power Builder Compared




PowerBuilder) can call a Delphi-generated DLL. In the same
manner, Delphi applications can also access DLLs created using
other development tools. 
 
Exception Handling
 
When developing serious client/server applications, it becomes
essential to write code that is able to deal with the possibility
of any process failing. Again, according to Breck Carter in the
1994 Special Issue of  PowerBuilder Developers Journal: "The
PowerScript language is less than ideal when it comes to error
handling, Most functions can diagnose errors, but with very few
exceptions the default action is to ignore the error and proceed.
There are no debugging switches or compiler directives to change
this behavior to trap all errors and halt. With the exception of
the global SystemError event, there is little language support
for automatic error detection or handling." 
 
This lack of support from the PowerScript language makes it
difficult, if not impossible to create robust error-handling
routines without writing enormous amounts of code. In contrast,
Delphi introduces a new and more powerful error-handling
methodology. To understand how important this new approach is, we
must first look at how it is done. 
 
Fundamental to Delphi is the concept of objects. Every control in
Delphi descends ultimately from a base object control called
TObject. As shown in the diagram above, TObject and hence, all of
its descendants already knows about errors. This knowledge is
passed to the programmer by means of objects. When an error
occurs, Delphi instantiates an Exception object of that exception
type. For example, if a divide by zero error occurs, an
EDivideByZero object is created. All forms have built into them,
the means of dealing with most errors. Rather than having to
write code to test for every possible failure, the following
construct is used: 
  
try













  PRODUCT  :  Delphi                                 NUMBER  :  2779
  VERSION  :  All
       OS  :  Windows
     DATE  :  July 14, 1995                            PAGE  :  18/21

    TITLE  :  Delphi Client/Server and Power Builder Compared




     { statements }
  except
     on ESomething do { specific exception handling code } ;  
          else {default exception-handling code } ;
  end;
 
 
Delphi also allows developers to create their own exception types
as follows: 
 
type
EpasswordInvalid = class(Exception) ;
 
 
This new user type exception is used simply as follows:
 
 
  if Password <> CorrectPassword then
raise EpasswordInvalid.Create(  Incorrect password entered' ) ; 
 
These examples are trivial and meant only to display concepts.
Delphi exception handling actually has capabilities far beyond
this. For instance, Windows General Protection Failure (GPF)
errors that are impossible to deal with in PowerBuilder
applications may be handled via Delphi's EGPFault exception type.
This simple construct provides enormous power and flexibility,
and minimizes the amount of code that needs to be written,
further shrinking the development cycle. 
 
Scalability
 
As more attention is focused on client/server development, the
scope of such applications is expanding. Where once it was
sufficient to provide basic data entry and inquiry capabilities,
users now demand that their applications have functionality far
beyond what can be provided from mainframe solutions. Delphi is
the ideal tool for this type of transition, being built around
Object Pascal, an enhancement of a language that is already known













  PRODUCT  :  Delphi                                 NUMBER  :  2779
  VERSION  :  All
       OS  :  Windows
     DATE  :  July 14, 1995                            PAGE  :  19/21

    TITLE  :  Delphi Client/Server and Power Builder Compared




by more than two million developers.  
 
Delphi does not hide code within UI objects, and is thus more
familiar to mainframe developers and easier to work with than
PowerBuilder. It maximizes code reuse, minimizes development
turnaround time and has the performance and stability necessary
for large applications. It is also infinitely extensible, due to
its OOP architecture, comprehensive array of components and
full-featured programming language. 
 
Many applications are also being scaled up from PC databases
written in dBASE, Clipper, FoxPro and Paradox. As these
applications make the transition from PC environments into the
full client/server model, they must be able to address both PC
and server data. PowerBuilder has extremely poor performance when
accessing PC databases, and does not provide support for Paradox
tables beyond the Paradox 3.5 format, nor does it fully support
the Paradox file locking mechanism. 
 
Some organizations decide that a portion of their data should
reside on a server platform such as Oracle, while other portions
should remain in a PC format such as dBASE. Because of Delphi's
broad database support and extremely good performance against
both PC and server data, it is the ideal tool for when mixed data
access is required. Developers need only one development tool
regardless of whether the data source is PC-based, server-based
or both. Delphi is the only development tool that can adequately
address all of these models. On the other hand, PowerBuilder has
opted to largely ignore the PC database side. 
 
Borland Database Engine
 
Although not component-based itself, the component-like
architecture of the Borland Database Engine (BDE) fits neatly
into the architecture of Delphi. As the core technology for most
of Borland's database tools including dBASE and Paradox, and used
by millions of database users, the BDE has evolved into an
extremely stable, high-performance technology that can deal with













  PRODUCT  :  Delphi                                 NUMBER  :  2779
  VERSION  :  All
       OS  :  Windows
     DATE  :  July 14, 1995                            PAGE  :  20/21

    TITLE  :  Delphi Client/Server and Power Builder Compared




almost any database format  It may be easily configured to access
popular server formats (including Oracle, Sybase, Informix and
InterBase) using high-performance SQL Links. PC database formats
such as dBASE and Paradox are accessed directly via drivers built
into BDE, which also includes support for the wealth of ODBC
drivers. 
 
The BDE is also sold as a separate product, as all of its
functionality is accessible to developers via an API. However,
Delphi developers are most likely to use the native data-aware
components to interact with the BDE, although it is possible to
write directly to the API or even bypass it altogether if
required. This open architecture provides a level of power and
flexibility not possible within PowerBuilder. 
 
Local InterBase Server
 
The Local InterBase Server is a locally-installed Windows version
of Borland's powerful InterBase workgroup server. Unlike the
Watcom SQL engine that ships with PowerBuilder, this product is a
full-featured SQL database, including:  
 
Stored Procedures and triggers
Automatic two-phase commit
Explicit transaction management
Declarative referential integrity
Event alerters
Simultaneous access to multiple databases and transactions
Multi-generational architecture
Updatable views
Outer joins
User defined functions (UDFs)
 
Because the Local InterBase Server supports most of the
functionality of the high-end InterBase server, developers can
create SQL-based applications using locally-stored data. Thorough
testing of these applications can be performed locally, without
concern for either the server load or the possibility of damaging













  PRODUCT  :  Delphi                                 NUMBER  :  2779
  VERSION  :  All
       OS  :  Windows
     DATE  :  July 14, 1995                            PAGE  :  21/21

    TITLE  :  Delphi Client/Server and Power Builder Compared




live data. Once an application has been tested and debugged
locally, it may then be scaled to work with an external database
server. If the developer has elected to use specific features of
InterBase, these will perform identically when the application is
deployed against an external InterBase server. 
 
With PowerBuilder, because the Windows version of WATCH SQL lacks
many of  the features on the server versions of Watcom SQL,
developers cannot experience the benefits of direct scaling that
Delphi provides. When PowerBuilder accesses the Windows version
of Watcom SQL, it must open a separate application window. Since
this is a standard window, users can task-switch to the window or
close it - either from the window itself or externally. This
makes the Windows version of Watcom SQL unsuitable in a
production environment. 
 
The Local InterBase Server, however, loads as a DLL in Delphi and
cannot be accessed by users. This, combined with its
comprehensive feature set, make the Local InterBase Server ideal
for applications running on notebook PCs. When a user returns to
the office, the application can be linked to the server version
of  the database. Applications may therefore scale from notebooks
up to Windows NT or Novell NetWare NLM servers, and all the way
up to the largest Unix-based systems, without developers needing
to change a single line of code. By offering this capability,
Delphi represents the ultimate in database scalability.  
 
Conclusion
 
This paper has examined just a few of the many differences
between Delphi and PowerBuilder. Both are clearly high end
client/server development tools with excellent features. When
examined from the perspectives of  performance, scalability,
reuse and RAD, Delphi clearly leads the way into the next
generation of client/server development. 
 
 
 


DISCLAIMER: You have the right to use this technical information
subject to the terms of the No-Nonsense License Statement that
you received with the Borland product to which this information
pertains.
