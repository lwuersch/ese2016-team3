package ch.unibe.ese.team3.controller;

import java.security.Principal;
import java.time.Year;
import java.util.ArrayList;
import java.util.List;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import ch.unibe.ese.team3.controller.pojos.forms.EditProfileForm;
import ch.unibe.ese.team3.controller.pojos.forms.MessageForm;
import ch.unibe.ese.team3.controller.pojos.forms.SignupForm;
import ch.unibe.ese.team3.controller.pojos.forms.UpgradeForm;
import ch.unibe.ese.team3.controller.service.AdService;
import ch.unibe.ese.team3.controller.service.SignupService;
import ch.unibe.ese.team3.controller.service.UpgradeService;
import ch.unibe.ese.team3.controller.service.UserService;
import ch.unibe.ese.team3.controller.service.UserUpdateService;
import ch.unibe.ese.team3.controller.service.VisitService;
import ch.unibe.ese.team3.model.AccountType;
import ch.unibe.ese.team3.model.Ad;
import ch.unibe.ese.team3.model.CreditcardType;
import ch.unibe.ese.team3.model.Gender;
import ch.unibe.ese.team3.model.User;
import ch.unibe.ese.team3.model.Visit;

/**
 * Handles all requests concerning user accounts and profiles.
 */
@Controller
public class ProfileController {

	@Autowired
	private SignupService signupService;

	@Autowired
	private UserService userService;

	@Autowired
	private UserUpdateService userUpdateService;

	@Autowired
	private VisitService visitService;

	@Autowired
	private AdService adService;
	
	@Autowired
	private UpgradeService upgradeService;

	/** Returns the login page. */
	@RequestMapping(value = "/login")
	public ModelAndView loginPage() {
		ModelAndView model = new ModelAndView("login");
		return model;
	}

	/** Returns the signup page. */
	@RequestMapping(value = "/signup", method = RequestMethod.GET)
	public ModelAndView signupPage() {
		ModelAndView model = new ModelAndView("signup");
		model.addObject("signupForm", new SignupForm());
		model.addObject("genders", Gender.valuesForDisplay());
		model.addObject("accountTypes", AccountType.values());
		model.addObject("creditcardTypes", CreditcardType.valuesForDisplay());
		model.addObject("years", GetYears());
		model.addObject("months", GetMonths());
		return model;
	}

	private List<Integer> GetMonths() {
		ArrayList<Integer> months = new ArrayList<Integer>();
		for (int i = 1; i <= 12; i++){
			months.add(i);
		}
		return months;
	}

	private List<Integer> GetYears() {
		ArrayList<Integer> years = new ArrayList<Integer>();
		int year = Year.now().getValue();
		for (int i = 0; i < 10; i++){
			years.add(new Integer(year + i));
		}
		return years;
	}

	/** Validates the signup form and on success persists the new user. */
	@RequestMapping(value = "/signup", method = RequestMethod.POST)
	public ModelAndView signupResultPage(@Valid SignupForm signupForm,
			BindingResult bindingResult) {
		ModelAndView model;
		if (!bindingResult.hasErrors()) {
			signupService.saveFrom(signupForm);
			model = new ModelAndView("login");
			model.addObject("confirmationMessage", "Signup complete!");
		} else {
			model = new ModelAndView("signup");
			model.addObject("signupForm", signupForm);
			model.addObject("genders", Gender.valuesForDisplay());
			model.addObject("accountTypes", AccountType.values());
			model.addObject("creditcardTypes", CreditcardType.valuesForDisplay());
			model.addObject("years", GetYears());
			model.addObject("months", GetMonths());
		}
		return model;
	}

	/** Checks and returns whether a user with the given email already exists. */
	@RequestMapping(value = "/signup/doesEmailExist", method = RequestMethod.POST)
	public @ResponseBody boolean doesEmailExist(@RequestParam String email) {
		return signupService.doesUserWithUsernameExist(email);
	}

	/** Shows the edit profile page. */
	@RequestMapping(value = "/profile/editProfile", method = RequestMethod.GET)
	public ModelAndView editProfilePage(Principal principal) {
		ModelAndView model = new ModelAndView("editProfile");
		String username = principal.getName();
		User user = userService.findUserByUsername(username);
		model.addObject("editProfileForm", new EditProfileForm());
		model.addObject("currentUser", user);
		return model;
	}

	/** Handles the request for editing the user profile. */
	@RequestMapping(value = "/profile/editProfile", method = RequestMethod.POST)
	public ModelAndView editProfileResultPage(
			@Valid EditProfileForm editProfileForm,
			BindingResult bindingResult, Principal principal) {
		ModelAndView model;
		String username = principal.getName();
		User user = userService.findUserByUsername(username);
		if (!bindingResult.hasErrors()) {
			userUpdateService.updateFrom(editProfileForm);
			return user(user.getId(), principal);
		} else {
			model = new ModelAndView("editProfile");
			model.addObject("editProfileForm", editProfileForm);
			model.addObject("currentUser", user);
			return model;
		}
	}

	/** Displays the public profile of the user with the given id. */
	@RequestMapping(value = "/user", method = RequestMethod.GET)
	public ModelAndView user(@RequestParam("id") long id, Principal principal) {
		ModelAndView model = new ModelAndView("user");
		User user = userService.findUserById(id);
		if (principal != null) {
			String username = principal.getName();
			User user2 = userService.findUserByUsername(username);
			long principalID = user2.getId();
			model.addObject("principalID", principalID);
		}
		model.addObject("user", user);
		model.addObject("messageForm", new MessageForm());
		return model;
	}

	/** Displays the schedule page of the currently logged in user. */
	@RequestMapping(value = "/profile/schedule", method = RequestMethod.GET)
	public ModelAndView schedule(Principal principal) {
		ModelAndView model = new ModelAndView("schedule");
		User user = userService.findUserByUsername(principal.getName());

		// visits, i.e. when the user sees someone else's property
		Iterable<Visit> visits = visitService.getVisitsForUser(user);
		model.addObject("visits", visits);

		// presentations, i.e. when the user presents a property
		Iterable<Ad> usersAds = adService.getAdsByUser(user);
		ArrayList<Visit> usersPresentations = new ArrayList<Visit>();

		for (Ad ad : usersAds) {
			try {
				usersPresentations.addAll((ArrayList<Visit>) visitService
						.getVisitsByAd(ad));
			} catch (Exception e) {
			}
		}

		model.addObject("presentations", usersPresentations);
		return model;
	}

	/** Returns the visitors page for the visit with the given id. */
	@RequestMapping(value = "/profile/visitors", method = RequestMethod.GET)
	public ModelAndView visitors(@RequestParam("visit") long id) {
		ModelAndView model = new ModelAndView("visitors");
		Visit visit = visitService.getVisitById(id);
		Iterable<User> visitors = visit.getSearchers();

		model.addObject("visitors", visitors);

		Ad ad = visit.getAd();
		model.addObject("ad", ad);
		return model;
	}
	
	/** Returns the upgrade page. */
	@RequestMapping(value = "/upgrade", method = RequestMethod.GET)
	public ModelAndView upgradePage(Principal principal) {
		ModelAndView model = new ModelAndView("upgrade");
		String username = principal.getName();
		User user = userService.findUserByUsername(username);
		model.addObject("upgradeForm", new UpgradeForm());
		model.addObject("creditcardTypes", CreditcardType.valuesForDisplay());
		model.addObject("accountTypes", AccountType.values());
		model.addObject("currentUser", user);
		return model;
	}

	/** Validates the upgrade form and on success persists the new user. */
	@RequestMapping(value = "/upgrade", method = RequestMethod.POST)
	public ModelAndView upgradeResultPage(@Valid UpgradeForm upgradeForm,
			BindingResult bindingResult, Principal principal) {
		ModelAndView model;
		String username = principal.getName();
		User user = userService.findUserByUsername(username);
		if (!bindingResult.hasErrors()) {
			upgradeService.upgradeFrom(upgradeForm, user);
			user = userService.findUserByUsername(username);
			return user(user.getId(), principal);
		} else {
			model = new ModelAndView("upgrade");
			model.addObject("upgradeForm", upgradeForm);
			model.addObject("creditcardTypes", CreditcardType.valuesForDisplay());
			model.addObject("accountTypes", AccountType.values());
			model.addObject("currentUser", user);
		}
		return model;
	}


}
