package io.codesquad.group3.signupserver;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.relational.core.conversion.DbActionExecutionException;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Collections;
import java.util.List;
import java.util.Map;

@Controller
public class UserController {

    @Autowired
    private UserRepository userRepository;

    @GetMapping("/")
    public String getHomePage(HttpSession session) {
        if (session.getAttribute("User") != null) {
            return "/index.html";
        }
        return "/login.html";
    }

    @GetMapping("/signup")
    public String getSignupPage() {
        return "/signup.html";
    }

    @PostMapping("/signup")
    public String signup(User user, @RequestParam String interests, HttpSession session) {
        List<Interest> userInterests= user.getInterests();
        String[] splitInterests = interests.split(",");
        for (int i = 0; i < splitInterests.length; i++) {
            Interest interest = new Interest();
            interest.setName(splitInterests[i].trim());
            userInterests.add(interest);
        }
        userRepository.save(user);
        session.setAttribute("User", user);
        return "redirect:/";
    }

    @GetMapping(value = "/check-duplicate-userId", produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody()
    public Map<String, Boolean> checkDuplicateUserId(@RequestParam String userId) {
        return Collections.singletonMap("response", !userRepository.existsByUserId(userId));
    }

    @GetMapping(value = "/check-duplicate-email", produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public Map<String, Boolean> checkDuplicateEmail(@RequestParam String email) {
        return Collections.singletonMap("response", !userRepository.existsByEmail(email));
    }

    @GetMapping(value = "/check-duplicate-phone", produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public Map<String, Boolean> checkDuplicatePhone(@RequestParam String phone) {
        return Collections.singletonMap("response", !userRepository.existsByPhone(phone));
    }

    @GetMapping("/{userId}/profile")
    public String getUserProfile(@PathVariable String userId,
                                 HttpSession session,
                                 Model model,
                                 HttpServletResponse response) throws IOException {
        User user = (User) session.getAttribute("User");
        if (user != null && userId.equals(user.getUserId())) {
            model.addAttribute("userInfo", user.toString());
            return "profile";
        }
        response.sendError(401);
        return null;
    }

    @ExceptionHandler(DbActionExecutionException.class)
    public String handleDuplicateUserId() {
        return "redirect:/signup";
    }
}
