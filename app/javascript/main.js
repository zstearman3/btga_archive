document.addEventListener("turbolinks:load", () => {
  const btn = document.getElementById("mobile-navbar-toggle");
  const eventTournamentSelector = document.getElementById("event_tournament_id");
  btn.addEventListener("click", handleClick);
  if (eventTournamentSelector) {
    eventTournamentSelector.addEventListener("change", selectCourse, false);
  }
})

function handleClick() {
  const mobileNav = document.getElementById("mobile-navbar");
  mobileNav.classList.contains('visible') ? mobileNav.classList.remove('visible') : mobileNav.classList.add('visible');
}

function selectCourse() {
  console.log("This function isn't quite... functional yet.")
}
