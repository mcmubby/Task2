using System.ComponentModel.DataAnnotations;

namespace Resume.Models
{
    public class FormModel
    {
        [Required]
        public string Email { get; set; }

        [Required]
        public string Name { get; set; }

        [Required]
        public string Idea { get; set; }
    }
}