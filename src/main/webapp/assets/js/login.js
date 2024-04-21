var personicon = document.querySelector('.bi-person-circle');

const signUpLink = document.querySelector('.signUp-link');
const signInLink = document.querySelector('.signIn-link');
const checkCommand = document.querySelector('#hidden-input');
const formSignUp = document.querySelectorAll('form')[1];
const formLogin = document.querySelectorAll('form')[2];
const wrapper = document.querySelector('.wrapper');

personicon.addEventListener('click',() =>{
   let content = $('.nav_person');
  if (content.css('display') ==='none') {
   content.css('display','grid')
  } else {
    content.css('display','none')  }
});



formLogin.addEventListener('submit', (e) => {
	const captchaResponse = grecaptcha.getResponse();
	console.log(captchaResponse)
	
	if (!captchaResponse.length > 0) {
		document.querySelector('.login-recaptcha-mess').innerHTML = "Please verify that you are not a robot.";
		e.preventDefault();
	}
});

if (checkCommand.name.length == 0) {
	wrapper.classList.add('animate-signUp');
	wrapper.classList.remove('animate-signIn');
} else {
	wrapper.classList.add('animate-signIn');
	wrapper.classList.remove('animate-signUp');
}

signUpLink.addEventListener('click', () => {
	wrapper.classList.add('animate-signIn');
	wrapper.classList.remove('animate-signUp');
});

signInLink.addEventListener('click', () => {
	wrapper.classList.add('animate-signUp');
	wrapper.classList.remove('animate-signIn');
});

function checkUsername(input) {
	const firstChar = input.value.charAt(0);
	const regex = /^[0-9!@#$%^&*()_+={}\[\]|\\:;"'<>,.?/`~]/;

	if (regex.test(firstChar)) {
		input.setCustomValidity("Không được bắt đầu bằng số hoặc ký tự đặc biệt");
	} else {
		input.setCustomValidity('');
	}
}

document.querySelector('form').addEventListener('submit', (e) => {
   var recaptcha = document.querySelector("#g-recaptcha-response").value;
   if (recaptcha === "") {
      e.preventDefault();
      alert("Please check the recaptcha");
   }
});


// Add click event listener
