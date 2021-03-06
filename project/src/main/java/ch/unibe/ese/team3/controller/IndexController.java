package ch.unibe.ese.team3.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import ch.unibe.ese.team3.controller.pojos.forms.SearchForm;
import ch.unibe.ese.team3.controller.service.AdService;
import ch.unibe.ese.team3.enums.PageMode;
import ch.unibe.ese.team3.model.Type;

/**
 * This controller handles request concerning the home page and several other
 * simple pages.
 */


@Controller
public class IndexController {

	private SearchForm searchForm;
	
	@Autowired
	private AdService adService;

	/** Displays the home page. */
	@RequestMapping(value = "/")
	public ModelAndView index(@RequestAttribute("pageMode") PageMode pageMode) {		
		ModelAndView model = new ModelAndView("index");
		model.addObject("newest", adService.getNewestAds(4));
		model.addObject("types", Type.values());
		return model;
	}

	/** Displays the about us page. */
	@RequestMapping(value = "/about")
	public ModelAndView about() {
		return new ModelAndView("about");
	}

	/** Displays the disclaimer page. */
	@RequestMapping(value = "/disclaimer")
	public ModelAndView disclaimer() {
		return new ModelAndView("disclaimer");
	}
	
	@ModelAttribute
	public SearchForm getSearchForm() {
		if (searchForm == null) {
			searchForm = new SearchForm();
		}
		return searchForm;
	}
}