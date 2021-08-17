namespace Resume
{
    public class CollaborationRequestService
    {
        private readonly IConfiguration _configuration;

        public async Task SendCollaborationEmail(FormModel model)
        {
            string content = $"{model.Name} ({model.email}) has sent you an idea. \n\n{model.Idea}";

            var subject = "Collaboration";

            var apiKey = _configuration["SendGridAPIKey"];
            var mailer = _configuration["SendGridEmail"];
            var myMail = _configuration["MyEmail"];
            var client = new SendGridClient(apiKey);
            var from = new EmailAddress(mailer,"Collaboration Request Notification");
            var to = new EmailAddress(myMail);
            var msg = MailHelper.CreateSingleEmail(from, to, subject, pin.ToString(), content);

            var response = await client.SendEmailAsync(msg);
        }
    }
}