var scrollTop = 0;
const sideBar = document.querySelector('.js-sidebar');
const mainContent = document.querySelector('.main-content');
offset     = sideBar.offsetTop,
sidebarHeight = sideBar.offsetHeight,
offsetBottom = offset + sidebarHeight;

window.addEventListener('scroll', function(e) {
    scrollTop = window.scrollY;
    scrollBottom = window.innerHeight + scrollTop;
    if (scrollTop > offset && scrollBottom < offsetBottom) {
        sideBar.classList.add("sidebar-fix");
    }else {
        sideBar.classList.remove("sidebar-fix");
    }

});