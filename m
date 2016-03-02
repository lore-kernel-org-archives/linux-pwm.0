From: Joachim Eastwood <manabian@gmail.com>
Subject: Re: [PATCH 4/6] pwm: pwm-lpc18xx-sct: test clock rate to avoid
 division by 0
Date: Wed, 2 Mar 2016 23:44:02 +0100
Message-ID: <CAGhQ9VzQLfhT4erDam_69-Zf4vp3gzKx+jbanXM8Ky+fmG=6EQ@mail.gmail.com>
References: <1456958018-7849-1-git-send-email-wsa@the-dreams.de>
	<1456958018-7849-5-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1456958018-7849-5-git-send-email-wsa@the-dreams.de>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-renesas-soc@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Ariel D'Alessandro <ariel@vanguardiasur.com.ar>
List-Id: linux-pwm@vger.kernel.org

Hi Wolfram,

On 2 March 2016 at 23:33, Wolfram Sang <wsa@the-dreams.de> wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
>
> The clk API may return 0 on clk_get_rate, so we should check the result before
> using it as a divisor.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>
> Should go individually via subsystem tree.
>
>  drivers/pwm/pwm-lpc18xx-sct.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/pwm/pwm-lpc18xx-sct.c b/drivers/pwm/pwm-lpc18xx-sct.c
> index 9163085101bc94..6487962c355c03 100644
> --- a/drivers/pwm/pwm-lpc18xx-sct.c
> +++ b/drivers/pwm/pwm-lpc18xx-sct.c
> @@ -360,6 +360,8 @@ static int lpc18xx_pwm_probe(struct platform_device *pdev)
>         }
>
>         lpc18xx_pwm->clk_rate = clk_get_rate(lpc18xx_pwm->pwm_clk);
> +       if (!lpc18xx_pwm->clk_rate)
> +               return -EINVAL;

This needs to be:
if (!lpc18xx_pwm->clk_rate) {
    ret = -EINVAL;
    goto disable_pwmclk;
}

I would also prefer an explicit check against 0 here. ie.:
'lpc18xx_pwm->clk_rate == 0'
A dev_err() message would also be nice to have.


regards,
Joachim Eastwood
