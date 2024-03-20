<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.vishal.model.DAO"%>

<!DOCTYPE html>
<html>

<head>
  <title>GadgetFix</title>
  <link rel="icon" href="resources/logo.png" />

  <meta name="viewport" content="width=device-width, initial-scale=1">

  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css" />

  <!-- font-awesome  -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css">
  <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/js/all.min.js"></script>

  <!-- Lightbox CSS & Script -->
  <script src="resources/lightbox/ekko-lightbox.js"></script>
  <link rel="stylesheet" href="resources/lightbox/ekko-lightbox.css"/>
  <!-- Lightbox END -->

  <!-- AOS css and JS -->
  <link rel="stylesheet" href="resources/aos/aos.css">
  <script src="resources/aos/aos.js"></script>
  <!-- AOS css and JS END-->

  <!-- custom css -->
  <link rel="stylesheet" href="resources/custom.css">

  <meta name="author" content="Rahul Chauhan" />
  <meta name="description" content="This is a website for Gadget Repaire Service." />
  <meta name="keywords" content="" />
</head>

<body>

<%
    String msg=(String)session.getAttribute("msg");
 if(msg!=null){
 %>  
  <p class="text-center bg-warning p-2"><%=msg%></p>
 
 <%
    session.setAttribute("msg", null);
   }
%>
  <section class="bg-dark" id="contact">
      <a id="contact-mail" href="mailto:info@gadgetfix.com"><i class="fa-solid fa-envelope"></i> info@gadgetfix.com</a>
      <a id="contact-phone" href="tel:9811981198"><i class="fa-solid fa-mobile-screen-button"></i> <strong>9811981198</strong></a>
  </section>
  <nav class="navbar navbar-expand-sm bg-light">
      <a href="index.jsp" id="logo" class="navbar-brand">
        <img src="resources/logo.png" alt="">Gadget<span>Fix</span>
      </a>
      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#my-navbar"><i class="fa-solid fa-bars"></i></button>
      <div class="collapse navbar-collapse" id="my-navbar">
          <ul class="navbar-nav ml-auto">
          <!-- <ul class="navbar-nav mr-auto"> -->
          <!-- <ul class="navbar-nav mx-auto"> -->
              <li>
                 <a href="index.jsp">Home</a>
              </li>
              <li>
                 <a href="User.jsp">User</a>
              </li>
              <li>
                 <a href="" data-toggle="modal" data-target="#admin-Modal">Admin</a>
              </li>
              <li>
                 <a href="" data-toggle="modal" data-target="#repair-expert-Modal">RepairExpert</a>
              </li>
              <li>
                <a href="" data-toggle="modal" data-target="#my-Modal">Contact</a>
             </li>
          </ul>
      </div>
  </nav>
  <section class="container-fluid text-center p-2 bg-dark  ">
  <form method="post" action="index.jsp" class="row p-3 align-items-center">
                <label class="text-white col-sm">Search Repair Expert: </label>
                <input class="col-sm m-2" name="state"  type="text"  placeholder=" Your State" required />
                <input class="col-sm m-2" name="city"  type="text"  placeholder=" Your City" required />
                <input class="col-sm m-2" name="sector"  type="text"  placeholder=" Your Area" >
                <button class="btn btn-success btn-sm m-2">Search</button>
            </form>
  </section>
  
  <%
  
  String state=request.getParameter("state");
  String city=request.getParameter("city");
  String sector=request.getParameter("sector");
  if(state!=null){
  
  %>       
          <div >
          <h4 class="bg-primary text-white p-3 text-center mt-2">All Repair Experts [<%= state%>, <%= city%>, <%= sector%>]</h4>
  <%
  
  DAO db=new DAO();
  ArrayList<HashMap> repairExperts=db.searchRepairExperts(state,city,sector);
  db.closeConnection();
  for(HashMap repairExpert:repairExperts){
%>
 
 
 <p class="bg-warning p-2 my-2"> 
  Name:<b><%=repairExpert.get("name") %> </b>
  State:<b><%=repairExpert.get("state") %> </b>
  City:<b><%=repairExpert.get("city") %> </b>
  Area:<b><%=repairExpert.get("sector") %> </b>
 
  <a class="btn btn-success btn-sm" href="RepairExpertDetails.jsp?email=<%=repairExpert.get("email")%>&status=Done">Details</a>
  </p>
 

<%
}

  }
  
  %>
  
  <header>
    <div id="carouselExampleCaptions" class="carousel slide" data-ride="carousel">
      <ol class="carousel-indicators">
        <li data-target="#carouselExampleCaptions" data-slide-to="0" class="active"></li>
        <li data-target="#carouselExampleCaptions" data-slide-to="1"></li>
        <li data-target="#carouselExampleCaptions" data-slide-to="2"></li>
      </ol>
      <div class="carousel-inner">
        <div class="carousel-item active">
          <img src="resources/banner1.jpg" class="d-block w-100" alt="...">
          <div class="carousel-caption d-none d-md-block">
            <h5>First slide label</h5>
            <p>Some representative placeholder content for the first slide.</p>
          </div>
        </div>
        <div class="carousel-item">
          <img src="resources/banner2.jpg" class="d-block w-100" alt="...">
          <div class="carousel-caption d-none d-md-block">
            <h5>Second slide label</h5>
            <p>Some representative placeholder content for the second slide.</p>
          </div>
        </div>
        <div class="carousel-item">
          <img src="resources/banner3.jpg" class="d-block w-100" alt="...">
          <div class="carousel-caption d-none d-md-block">
            <h5>Third slide label</h5>
            <p>Some representative placeholder content for the third slide.</p>
          </div>
        </div>
      </div>
      <button class="carousel-control-prev" type="button" data-target="#carouselExampleCaptions" data-slide="prev">
        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
        <span class="sr-only">Previous</span>
      </button>
      <button class="carousel-control-next" type="button" data-target="#carouselExampleCaptions" data-slide="next">
        <span class="carousel-control-next-icon" aria-hidden="true"></span>
        <span class="sr-only">Next</span>
      </button>
    </div>
  </header>
  <section class="container" id="features">
    <div class="row text-center" data-aos="fade-up" data-aos-duration="1000">
        <div class="col-md">
          <div class="c-features-box text-white">
            <p><i class="fa-solid fa-toolbox fa-2x"></i></p>
            <h5>Lorem, ipsum dolor.</h5>
            <p>Lorem ipsum dolor sit amet consectetur adipisicing elit.</p>
          </div>
        </div>
        <div class="col-md">
          <div class="c-features-box text-white">
            <p><i class="fa-solid fa-hammer fa-2x"></i></p>
            <h5>Lorem, ipsum dolor.</h5>
            <p>Lorem ipsum dolor sit amet consectetur adipisicing elit.</p>
          </div>
        </div>
        <div class="col-md">
          <div class="c-features-box text-white">
            <p><i class="fa-solid fa-screwdriver-wrench  fa-2x"></i></p>
            <h5>Lorem, ipsum dolor.</h5>
            <p>Lorem ipsum dolor sit amet consectetur adipisicing elit.</p>
          </div>
        </div>
    </div>
  </section>
  <section class="container my-5">
      <div class="row text-center align-items-center">
          <div class="col-sm" data-aos="fade-right" data-aos-duration="1000">
              <img src="resources/img1.jpg" class="img-fluid rounded-lg" alt="">
          </div>
          <div class="col-sm p-4" data-aos="zoom-in" data-aos-duration="1000">
              <h3><span class="text-danger">Welcome</span> to our company</h3>
              <p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Aspernatur aliquid recusandae perspiciatis. Doloremque commodi distinctio autem dolores, voluptates debitis ad?</p>
          </div>
      </div>
  </section>
  <section class="bg-dark text-white p-5 text-center" id="service">
      <h4>GadgetFix can handle all of your gadget repair solutions <br/> SERVICES INCLUDING</h4>
      <div class="row mt-5 mb-3">
          <div class="col-sm">
              <div>
                  <p><i class="fa-solid fa-angle-right"></i> Lorem ipsum dolor sit amet.</p>
                  <p><i class="fa-solid fa-angle-right"></i> Lorem ipsum dolor sit amet.</p>
                  <p><i class="fa-solid fa-angle-right"></i> Lorem ipsum dolor sit amet.</p>
                  <p><i class="fa-solid fa-angle-right"></i> Lorem ipsum dolor sit amet.</p>
              </div>
          </div>
          <div class="col-sm">
              <div>
                  <p><i class="fa-solid fa-angle-right"></i> Lorem ipsum dolor sit amet.</p>
                  <p><i class="fa-solid fa-angle-right"></i> Lorem ipsum dolor sit amet.</p>
                  <p><i class="fa-solid fa-angle-right"></i> Lorem ipsum dolor sit amet.</p>
                  <p><i class="fa-solid fa-angle-right"></i> Lorem ipsum dolor sit amet.</p>
              </div>
          </div>
          <div class="col-sm">
            <div>
                <p><i class="fa-solid fa-angle-right"></i> Lorem ipsum dolor sit amet.</p>
                <p><i class="fa-solid fa-angle-right"></i> Lorem ipsum dolor sit amet.</p>
                <p><i class="fa-solid fa-angle-right"></i> Lorem ipsum dolor sit amet.</p>
                <p><i class="fa-solid fa-angle-right"></i> Lorem ipsum dolor sit amet.</p>
            </div>
        </div>
      </div>
      <button class="btn btn-warning btn-sm" data-toggle="modal" data-target="#my-Modal">Get In Touch</button>
  </section>
  <section class="container my-5">
      <div class="row text-center align-items-center">
          <div class="col-sm p-4" data-aos="zoom-in" data-aos-duration="1000">
              <h3><span class="text-danger">About</span> our company</h3>
              <p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Aspernatur aliquid recusandae perspiciatis. Doloremque commodi distinctio autem dolores, voluptates debitis ad?</p>
          </div>
          <div class="col-sm" data-aos="fade-left" data-aos-duration="1000">
            <img src="resources/img5.jpg" class="img-fluid rounded-lg" alt="">
        </div>
      </div>
  </section>
  <section class="container-fluid my-4" id="gallery">
      <div class="row">
          <div class="col p-0">
            <a href="resources/img1.jpg" data-toggle="lightbox" data-gallery="my-gallery"><img class="img-fluid" src="resources/img1.jpg" alt=""></a>
          </div>
          <div class="col p-0">
            <a href="resources/img2.jpg" data-toggle="lightbox" data-gallery="my-gallery"><img class="img-fluid" src="resources/img2.jpg" alt=""></a>
          </div>
          <div class="col p-0">
            <a href="resources/img3.jpg" data-toggle="lightbox" data-gallery="my-gallery"><img class="img-fluid" src="resources/img3.jpg" alt=""></a>
          </div>
          <div class="col p-0">
            <a href="resources/img4.jpg" data-toggle="lightbox" data-gallery="my-gallery"><img class="img-fluid" src="resources/img4.jpg" alt=""></a>
          </div>
      </div>
  </section>
  <section class="container my-5 text-center" id="testimonials" >
    <h4>TESTIMONIALS</h4>
    <div class="row my-5">
      <div class="col-sm">
         <div>
            <img src="resources/person1.jpg" alt="">
            <p>
              <span><i class="fa-solid fa-quote-left fa-3x"></i></span>
              Lorem ipsum dolor sit amet consectetur adipisicing elit. Minima voluptate earum quos, possimu accusantium alias a ab eveniet, dicta veniam quas dolores iste nihil voluptatem amet facere? Qui temporibus voluptatibus.
            </p>
            <strong>Lorem, ipsum.</strong>
         </div> 
      </div>
      <div class="col-sm">
        <div>
           <img src="resources/person2.jpg" alt="">
           <p>
             <span><i class="fa-solid fa-quote-left fa-3x"></i></span>
             Lorem ipsum dolor sit amet consectetur adipisicing elit. Minima voluptate earum quo.
           </p>
           <strong>Lorem, ipsum.</strong>
        </div> 
      </div>
      <div class="col-sm">
        <div>
          <img src="resources/person1.jpg" alt="">
          <p>
            <span><i class="fa-solid fa-quote-left fa-3x"></i></span>
            Lorem ipsum dolor sit amet consectetur adipisicing elit. blanditiis expedita vitae earum ipsum, perferendis culpa quas ad.
          </p>
          <strong>Lorem, ipsum.</strong>
        </div> 
      </div>
    </div>
  </section>
  <section class="container-fluid bg-light text-center p-3">
    <img class="mx-3" src="resources/apple.png" alt="" height="50px">
    <img class="mx-3" src="resources/dell.png" alt="" height="50px">
    <img class="mx-3" src="resources/hp.png" alt="" height="50px">
    <img class="mx-3" src="resources/lenovo.png" alt="" height="50px">
    <img class="mx-3" src="resources/lg.png" alt="" height="50px">
    <img class="mx-3" src="resources/mi.png" alt="" height="50px">
    <img class="mx-3" src="resources/nokia.png" alt="" height="50px">
    <img class="mx-3" src="resources/samsung.png" alt="" height="50px">
  </section>
  <section class="container-fluid p-0">
      <iframe style="border: none;" src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3945.368104069876!2d76.87738631380658!3d8.560557298509!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x390cea7e051fd949%3A0xefccd5003c9032b6!2sINCAPP!5e0!3m2!1sen!2sin!4v1669980568912!5m2!1sen!2sin" width="100%" height="250" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>
  </section>
  <footer class="bg-dark p-2 text-white text-center">
      <p>&copy; Rights Reserved.</p>
  </footer>
  <a id="top-button"><i class="fa-solid fa-circle-up"></i></a>

  <!-- Modal -->
  <div class="modal fade" id="my-Modal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="exampleModalLabel">Get In Touch!</h5>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
          </button>
        </div>
        <div class="modal-body">
            <form method="post" action="AddEnquiry">
                <input name="name" class="form-control p-4 my-2" type="text" maxlength="20" pattern="[a-zA-Z ]+" placeholder="Your Name" required />
                <input name="phone" class="form-control p-4 my-2" type="tel" maxlength="10" minlength="10" pattern="[0-9]+" placeholder="Your Phone" required />
                <button class="btn btn-success my-2">Submit</button>
            </form>
        </div>
      </div>
    </div>
  </div>
  
  <div class="modal fade" id="admin-Modal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header bg-primary text-white">
          <h5 class="modal-title" id="exampleModalLabel">Admin Login!</h5>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
          </button>
        </div>
        <div class="modal-body">
            <form method="post" action="AdminLogin">
                <input name="id" class="form-control p-4 my-2" type="text" maxlength="20"  placeholder="Enter ID" required />
                <input name="password" class="form-control p-4 my-2" type="password" maxlength="20"  placeholder="Enter Password" required />
                <button class="btn btn-primary my-2">Submit</button>
            </form>
        </div>
      </div>
    </div>
  </div>
  
  <div class="modal fade" id="repair-expert-Modal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header bg-info text-white">
          <h5 class="modal-title" id="exampleModalLabel">Repair Expert Login!</h5>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
          </button>
        </div>
        <div class="modal-body">
            <form method="post" action="RepairExpertLogin">
                <input name="email" class="form-control p-4 my-2" type="email" maxlength="50"  placeholder="Enter Email" required />
                <input name="password" class="form-control p-4 my-2" type="password" maxlength="20"  placeholder="Enter Password" required />
                <button class="btn btn-info my-2">Submit</button>
            </form>
        </div>
      </div>
    </div>
  </div>
</body>
<script>
    AOS.init();
    //script for scroll to top
    $("#top-button").click(function () {
        $("html, body").animate({scrollTop: 0}, 1000);
    });
    //script for light box
    $(document).on('click', '[data-toggle="lightbox"]', function(event) {
        event.preventDefault();
        $(this).ekkoLightbox();
    });
    //script for Google Sheet
   
</script>
</html>