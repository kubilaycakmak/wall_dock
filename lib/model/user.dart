class User{
  String largeUrl;
  String user; 
  String webUrl;
  String type;
  String tags; 
  String previewURL;
  int likes;
  int id; 
  int download;
  int view;
  int size;
  int iwidth;
  int iheight;
  int comments;
  int fav;

  User(this.largeUrl, this.user, this.webUrl, this.type, this.tags, 
    this.previewURL, this.likes, this.id, this.download, this.view, 
    this.size, this.iwidth, this.iheight, this.comments, this.fav);

 String get getLargeUrl => largeUrl;

 set setLargeUrl(String largeUrl) => this.largeUrl = largeUrl;

 String get getUser => user;

 set setUser(String user) => this.user =  user;

 String get getWebUrl => webUrl;

 set setWebUrl(String webUrl) => this.webUrl = webUrl;

 String get getType => type;

 set setType(String type) => this.type = type;

 String get getPreviewURL => previewURL;

 set setPreviewURL(String previewURL) => this.previewURL = previewURL;

 int get getLikes => likes;

 set setLikes(int likes) => this.likes = likes;

 int get getId => id;

 set setId(int id) => this.id = id;

 int get getDownload => download;

 set setDownload(int download) => this.download = download;

 int get getView => view;

 set setView(int view) => this.view = view;

 int get getSize => size;

 set setSize(int size) => this.size = size;

 int get getIwidth => iwidth;

 set setIwidth(int iwidth) => this.iwidth = iwidth;

 int get getIheight => iheight;

 set setIheight(int iheight) => this.iheight = iheight;

 int get getComments => comments;

 set setComments(int comments) => this.comments = comments;

 int get getFav => fav;

 set setFav(int fav) => this.fav = fav;

}