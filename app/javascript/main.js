document.addEventListener("turbolinks:load", () => {
  const btn = document.getElementById("mobile-navbar-toggle");
  btn.addEventListener("click", handleClick);
})

function handleClick() {
  const mobileNav = document.getElementById("mobile-navbar");
  mobileNav.classList.contains('visible') ? mobileNav.classList.remove('visible') : mobileNav.classList.add('visible');
}