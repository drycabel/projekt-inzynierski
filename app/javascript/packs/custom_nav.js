const navSlide = () => {
    const burger = document.querySelector('.burger');
    const nav = document.querySelector('.custom-nav-links');
    const navLinks = document.querySelectorAll('.custom-nav-links li');
    
    burger.addEventListener('click', () => {
        //Toggle Nav
        nav.classList.toggle('nav-active');
        //Animate Links
        navLinks.forEach((link, index) => {
            if(link.style.animation){
                link.style.animation = ''; 
            } else {
                link.style.animation = "navLinkFade 0.5s ease forwards " + (index / 7 + 0.5) + "s"; 
            }      
        });

        //Burger Animation
        burger.classList.toggle('toggle');

    });
    
}

const stickyNav = () => {
    var navbar = document.querySelector('.custom-navbar');
    var sticky = navbar.offsetTop;
    
    window.addEventListener('scroll', () => {
        if(window.pageYOffset >= sticky){
            navbar.classList.add("sticky");
        }else {
            navbar.classList.remove("sticky");
        }
    })
}


export {navSlide, stickyNav};