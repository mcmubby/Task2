using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Resume.Models;

namespace Resume.Controllers
{
    public class HomeController : Controller
    {
        private readonly ILogger<HomeController> _logger;

        public HomeController(ILogger<HomeController> logger)
        {
            _logger = logger;
        }

        public IActionResult Index()
        {
            return View();
        }

        [HttpPost]
        public IActionResult Index(FormModel model)
        {
            if(!ModelState.IsValid) return View();

            
            return View("sent");
        }
    }
}
