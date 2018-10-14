# feup-lbaw

Projects for the Database and Web Applications Laboratory (LBAW) class of the Master in Informatics and Computer Engineering (MIEIC) at the Faculty of Engineering of the University of Porto (FEUP).

- [Project](#project)
- [Installation](#installation)
- [Usage](#usage)

Made in colaboration with [Carlos Freitas](https://github.com/CarlosFr97), [Julieta Frade](https://github.com/julietafrade97) and [Luís Martins](https://github.com/luisnmartins).<br>
**Completed in 30/05/2018.**

## Project
The purpose of this project was to develop a web application for an online tech store, called **Sweven**, which means a vision seen in sleep, a dream. From the Old English to the modern days, this word inspired us. In order to have a great product diversity, the store sells multiple tech brands and product types, such as smartphones, laptops, and tablets. Sweven is based on **HTML5**, **JavaScript**, **CSS**, **PostgreSQL** and **PHP**. The **Bootstrap framework** was used to implement the user interface and when it comes to backend, it was used the **Laravel framework**.

The platform has an adaptive design and a detailed navigation system by arranging the products through categories. In order to provide a reliable service, each product has a review section, which allows users to not only review the items they purchased but also to view other people's opinions. Each review includes a score and a short description, which results in the product to have an average score. Besides, users have the ability to save favorite products in a wishlist and view the history of all previous purchases. Finally, users are distributed in three groups with different permissions: administrators, unauthenticated and authenticated users.

The Sketch App was used to develop Sweven's design, you can check it out on [my behance](https://www.behance.net/gallery/71374245/Sweven-Website).
The website is live [here](http://lbaw1761.lbaw-prod.fe.up.pt), but access is restricted to the **FEUP network** (or FEUP VPN). Oh, and there's a [youtube video](https://youtu.be/la9v98MQ1qc).

### Repository Flow

 * The **source code** is in the [master branch](https://github.com/literallysofia/feup-lbaw/tree/master).
 * The **documentation** is in [the current branch](https://github.com/literallysofia/feup-lbaw/tree/documentation), which is the default.
 * The **vertical prototype** is in the [proto branch](https://github.com/literallysofia/feup-lbaw/tree/proto).

### Screenshots

<table>
  <tr>
    <td><img src="https://github.com/literallysofia/feup-lbaw/blob/documentation/design/screenshots/image1.jpg"></td>
    <td><img src="https://github.com/literallysofia/feup-lbaw/blob/documentation/design/screenshots/image2.jpg"></td>
    <td><img src="https://github.com/literallysofia/feup-lbaw/blob/documentation/design/screenshots/image3.jpg"></td>
  </tr>
  <tr>
    <td><img src="https://github.com/literallysofia/feup-lbaw/blob/documentation/design/screenshots/image4.jpg"></td>
    <td><img src="https://github.com/literallysofia/feup-lbaw/blob/documentation/design/screenshots/image5.jpg"></td>
    <td><img src="https://github.com/literallysofia/feup-lbaw/blob/documentation/design/screenshots/image6.jpg"></td>
  </tr>
  <tr>
    <td><img src="https://github.com/literallysofia/feup-lbaw/blob/documentation/design/screenshots/image10.jpg"></td>
    <td><img src="https://github.com/literallysofia/feup-lbaw/blob/documentation/design/screenshots/image8.jpg"></td>
    <td><img src="https://github.com/literallysofia/feup-lbaw/blob/documentation/design/screenshots/image9.jpg"></td>
  </tr>
  <tr>
    <td><img src="https://github.com/literallysofia/feup-lbaw/blob/documentation/design/screenshots/image7.jpg"></td>
    <td><img src="https://github.com/literallysofia/feup-lbaw/blob/documentation/design/screenshots/image11.jpg"></td>
    <td><img src="https://github.com/literallysofia/feup-lbaw/blob/documentation/design/screenshots/image12.jpg"></td>
  </tr>
</table>

## Installation

Link to the Github release: [Final Version](https://github.com/literallysofia/lbaw1761/releases/tag/A10)


### Docker Command
```
docker-compose up

docker exec lbaw_php php artisan db:seed 

docker run -it -p 8000:80 -e DB_DATABASE=lbaw1761 -e DB_USERNAME=lbaw1761 -e DB_PASSWORD=bd34vg87 luisnmartins/lbaw1761
```

## Usage
 
URL to the product: http://lbaw1761.lbaw-prod.fe.up.pt
 
### Administration Credentials
 
Administration URL: http://lbaw1761.lbaw-prod.fe.up.pt/admin

<table>
 <tr>
  <th>Username</th>
  <th>Email</th>
  <th>Password</th>
 </tr>
 <tr>
  <td>swevenAdmin</td>
  <td>sweventechshop@gmail.com</td>
  <td>Sweven61</td>
 </tr>
</table>
 
### User Credentials

<table>
 <tr>
  <th>Type</th>
  <th>Username</th>
  <th>Email</th>
  <th>Password</th>
 </tr>
 <tr>
  <td>user 1</td>
  <td>stiles</td>
  <td>stiles@gmail.com</td>
  <td>Sweven61</td>
 </tr>
 <tr>
  <td>user 2</td>
  <td>scottmc</td>
  <td>scottmccall@gmail.com</td>
  <td>Sweven61</td>
 </tr>
</table>
