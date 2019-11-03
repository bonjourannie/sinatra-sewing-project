annie = User.create(username: "annie23", password:"love")
dan = User.create(username: "dan456", password: "dogs")
jeans = Projects.create(name:"jeans", materials: "denim", instructions: "sew it together")
jeans.user = annie
jeans.save


muumuu = Projects.create(name:"muumuu", materials: "cotton", intructions: "make sure it's roomy")
muumuu.user = dan
muumuu.save

gracie = User.create(username:"gracie789",password:"cookie")
bikini = Projects.create(name:"bikini", materials: "lycra", instructions: "the smaller the better")
bikini.user = gracie
bikini.save
