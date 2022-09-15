class BoardingModel
{
  final String image;
  final String title;
  final String description;
  BoardingModel(this.image,this.title,this.description);
}

List<BoardingModel> BoardingItems =[
  BoardingModel("images/onboarding1.png", "ORDER ONLINE", "make your order sitting on a Sofa.\n play and choose online"),
  BoardingModel("images/onboarding2.png", "M-COMMERCE", "Download our application and buy using your phone or laptop"),
  BoardingModel("images/onboarding3.png", "DELIVERY SERVICES", "Modern delivering technologies. shipping to the porch of you apartment"),
];
