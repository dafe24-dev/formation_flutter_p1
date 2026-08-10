import 'package:flutter/material.dart';

class PageCategories extends StatelessWidget {
  const PageCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          Container(
          padding: EdgeInsets.only(right: 15, top: 10),
          child: Icon(Icons.add,color: const Color.fromARGB(255, 72, 67, 181), size: 35, fontWeight: FontWeight.bold,),
          )

        ],

      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //Texte Catégories
            Container(
              margin: EdgeInsets.only(top: 15,left: 20),
              child: Row(
                children: [
                  Text("Catégories",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 35,
                    fontWeight: FontWeight.w700,

                  ),
                  )
                ],
              ),
            ),
            SizedBox(height: 15,),
            //catégories carte
            //1
            
          Padding(  
            padding: EdgeInsets.only(right: 5,left: 5),    
             child: Card(
               margin: EdgeInsets.only(right: 20,left: 20),
               elevation: 1,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 15,
                    ),
                 
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    
                      child: Row(
                    
                        children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            color: Color.fromARGB(83, 244, 91, 142)
                          ),
                          child: const Icon(
                                  Icons.group,
                                  color: Colors.pink,
                                  size: 30,
                                ),
                              ),
                              SizedBox(width: 15,),
                          Container(
                              child: Column(
                                
                                crossAxisAlignment: CrossAxisAlignment.start,
                                 children: [
                                    Text(
                                      "Famille",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700, 
                                      ),
                                            ),
                                    Text(
                                    "28 contacts",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14
                                    ),
                                  )
                                  
                                ],
                              ),  
                             )
                            ],
                          )
                        ),

                   Container(
                  
                    child:  Icon(Icons.arrow_forward_ios,fontWeight: FontWeight.normal,),
                    )
                    
                    ],
                  ),
               ),

            ),            
          ),
      //2

      SizedBox(height: 15,),
  Padding(  
            padding: EdgeInsets.only(right: 5,left: 5),    
             child: Card(
               margin: EdgeInsets.only(right: 20,left: 20),
               elevation: 1,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 15,
                    ),
                 
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    
                      child: Row(
                    
                        children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            color: Color.fromARGB(97, 144, 205, 255)
                          ),
                          child: const Icon(
                                  Icons.business_center_rounded,
                                  color: Colors.blue,
                                  size: 30,
                                ),
                              ),
                              SizedBox(width: 15,),
                          Container(
                              child: Column(
                                
                                crossAxisAlignment: CrossAxisAlignment.start,
                                 children: [
                                    Text(
                                      "Travail",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700, 
                                      ),
                                            ),
                                    Text(
                                    "56 contacts",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14
                                    ),
                                  )
                                  
                                ],
                              ),  
                             )
                            ],
                          )
                        ),

                   Container(
                  
                    child:  Icon(Icons.arrow_forward_ios,fontWeight: FontWeight.normal,),
                    )
                    
                    ],
                  ),
               ),

            ),
            
          ),
            SizedBox(height: 15,),

  //3
  Padding(  
            padding: EdgeInsets.only(right: 5,left: 5),    
             child: Card(
               margin: EdgeInsets.only(right: 20,left: 20),
               elevation: 1,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 15,
                    ),
                 
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    
                      child: Row(
                    
                        children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            color: Color.fromARGB(92, 151, 255, 154)
                          ),
                          child: const Icon(
                                  Icons.person,
                                  color: Colors.green,
                                  size: 30,
                                ),
                              ),
                              SizedBox(width: 15,),
                          Container(
                              child: Column(
                                
                                crossAxisAlignment: CrossAxisAlignment.start,
                                 children: [
                                    Text(
                                      "Amis",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700, 
                                      ),
                                            ),
                                    Text(
                                    "48 contacts",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14
                                    ),
                                  )
                                  
                                ],
                              ),  
                             )
                            ],
                          )
                        ),

                   Container(
                  
                    child:  Icon(Icons.arrow_forward_ios,fontWeight: FontWeight.normal,),
                    )
                    
                    ],
                  ),
               ),

            ),            
          ),
            SizedBox(height: 15,),
          //4

  Padding(  
            padding: EdgeInsets.only(right: 5,left: 5),    
             child: Card(
               margin: EdgeInsets.only(right: 20,left: 20),
               elevation: 1,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 15,
                    ),
                 
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    
                      child: Row(
                    
                        children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            color: Color.fromARGB(82, 246, 172, 103)
                          ),
                          child: const Icon(
                                  Icons.star,
                                  color: Colors.orange,
                                  size: 30,
                                ),
                              ),
                              SizedBox(width: 15,),
                          Container(
                              child: Column(
                                
                                crossAxisAlignment: CrossAxisAlignment.start,
                                 children: [
                                    Text(
                                      "Clients",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700, 
                                      ),
                                            ),
                                    Text(
                                    "34 contacts",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14
                                    ),
                                  )
                                  
                                ],
                              ),  
                             )
                            ],
                          )
                        ),

                   Container(
                  
                    child:  Icon(Icons.arrow_forward_ios,fontWeight: FontWeight.normal,),
                    )
                    
                    ],
                  ),
               ),

            ),
            
          ),


            SizedBox(height: 15,),

            //5
  Padding(  
            padding: EdgeInsets.only(right: 5,left: 5),    
             child: Card(
               margin: EdgeInsets.only(right: 20,left: 20),
               elevation: 1,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 15,
                    ),
                 
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    
                      child: Row(
                    
                        children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            color: Color.fromARGB(82, 157, 162, 254)
                          ),
                          child: const Icon(
                                  Icons.school_rounded,
                                  color: Colors.deepPurple,
                                  size: 30,
                                ),
                              ),
                              SizedBox(width: 15,),
                          Container(
                              child: Column(
                                
                                crossAxisAlignment: CrossAxisAlignment.start,
                                 children: [
                                    Text(
                                      "Fournisseurs",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700, 
                                      ),
                                            ),
                                    Text(
                                    "23 contacts",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14
                                    ),
                                  )
                                  
                                ],
                              ),  
                             )
                            ],
                          )
                        ),

                   Container(
                  
                    child:  Icon(Icons.arrow_forward_ios,fontWeight: FontWeight.normal,),
                    )
                    
                    ],
                  ),
               ),

            ),
          ),
            SizedBox(height: 15,),

            //6
  Padding(  
            padding: EdgeInsets.only(right: 5,left: 5),    
             child: Card(
               margin: EdgeInsets.only(right: 20,left: 20),
               elevation: 1,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 15,
                    ),
                 
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    
                      child: Row(
                        children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            color: Color.fromARGB(82, 217, 216, 216)
                          ),
                          child: const Icon(
                                  Icons.grid_view_rounded,
                                  color: Colors.grey,
                                  size: 30,
                                ),
                              ),
                              SizedBox(width: 15,),
                          Container(
                              child: Column(
                                
                                crossAxisAlignment: CrossAxisAlignment.start,
                                 children: [
                                    Text(
                                      "Autres",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700, 
                                      ),
                                            ),
                                    Text(
                                    "25 contacts",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14
                                    ),
                                  )
                                  
                                ],
                              ),  
                             )
                            ],
                          )
                        ),

                   Container(
                  
                    child:  Icon(Icons.arrow_forward_ios,fontWeight: FontWeight.normal,),
                    )
                    
                    ],
                  ),
               ),

            ),
            
          ),

           ],

        ),  
      ),
    );
  }
}

