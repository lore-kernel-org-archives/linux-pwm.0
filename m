From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] pwm: spear: fix check on pwmchip_add() return value
Date: Wed, 7 May 2014 11:37:25 +0530
Message-ID: <CAOh2x=mWqa=p2d1kRjf0_37DiioJZOJm3Ewv2xpMrNjPy69rvA@mail.gmail.com>
References: <1399325340-20416-1-git-send-email-b.galvani@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1399325340-20416-1-git-send-email-b.galvani@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Beniamino Galvani <b.galvani@gmail.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pwm@vger.kernel.org

On Tue, May 6, 2014 at 2:59 AM, Beniamino Galvani <b.galvani@gmail.com> wrote:
> pwmchip_add() returns zero on success and a negative value on error,
> so the condition of the check must be inverted.
>
> Signed-off-by: Beniamino Galvani <b.galvani@gmail.com>
> ---
>  drivers/pwm/pwm-spear.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pwm/pwm-spear.c b/drivers/pwm/pwm-spear.c
> index cb2d4f0..945556d 100644
> --- a/drivers/pwm/pwm-spear.c
> +++ b/drivers/pwm/pwm-spear.c
> @@ -222,7 +222,7 @@ static int spear_pwm_probe(struct platform_device *pdev)
>         }
>
>         ret = pwmchip_add(&pc->chip);
> -       if (!ret) {
> +       if (ret < 0) {
>                 clk_unprepare(pc->clk);
>                 dev_err(&pdev->dev, "pwmchip_add() failed: %d\n", ret);
>         }

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
