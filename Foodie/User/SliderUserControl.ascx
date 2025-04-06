<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="SliderUserControl.ascx.cs" Inherits="Foodie.User.SliderUserControl" %>
<style>
    .btn1 {
    background-color: #FFC107; 
    color: #333 !important; 
    font-weight: bold !important; /
    font-size: 18px !important; 
    padding: 12px 24px !important; 
    border-radius: 50px !important; 
    text-align: center !important;
    display: inline-block !important;
    text-decoration: none !important;
}
</style>

<section class="slider_section ">
  <div id="customCarousel1" class="carousel slide" data-ride="carousel">
    <div class="carousel-inner">
      <div class="carousel-item active">
        <div class="container ">
          <div class="row">
            <div class="col-md-7 col-lg-6 ">
              <div class="detail-box">
                <h1>
                  Foodie Fast Food 
                </h1>
                <p>
                  Foodie isn’t just a fast-food restaurant—it’s your go-to spot for quick, delicious bites that hit the spot every time. Whether you're craving a juicy burger, crispy fries, or something fresh, we serve it hot and fast, no fuss. Hungry? Get it fast, get it tasty—get it at Foodie!
                </p>
                <div class="btn-box">
                  <a href="Menu.aspx" class="btn1">
                    Order Now
                  </a>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
      <div class="carousel-item ">
        <div class="container ">
          <div class="row">
            <div class="col-md-7 col-lg-6 ">
              <div class="detail-box">
                <h1>
                  Foodie Fast Food
                </h1>
                <p>
                    At Foodie, we don’t do complicated—just bold flavors, fresh ingredients, and fast service. From crispy fries to mouthwatering burgers, every bite is made to satisfy. Hungry? Foodie’s got you covered!
                </p>
                <div class="btn-box">
                  <a href="Menu.aspx" class="btn1">
                    Order Now
                  </a>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
      <div class="carousel-item">
        <div class="container ">
          <div class="row">
            <div class="col-md-7 col-lg-6 ">
              <div class="detail-box">
                <h1>
                  Foodie Fast Food
                </h1>
                <p>
                    At Foodie, we keep it simple—great food, fast service, no nonsense. Whether you're grabbing a quick bite or fueling up for the day, we serve fresh, flavorful meals that never disappoint. Good food, no wait—welcome to Foodie!
                </p>
                <div class="btn-box">
                  <a href="Menu.aspx" class="btn1">
                    Order Now
                  </a>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    <div class="container">
      <ol class="carousel-indicators">
        <li data-target="#customCarousel1" data-slide-to="0" class="active"></li>
        <li data-target="#customCarousel1" data-slide-to="1"></li>
        <li data-target="#customCarousel1" data-slide-to="2"></li>
      </ol>
    </div>
  </div>

</section>