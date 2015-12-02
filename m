From: Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: Re: [PATCH 2/3] pwm: bcm2835: prevent division by zero
Date: Wed, 2 Dec 2015 08:23:16 -0700
Message-ID: <CANLsYkzsFzhVVPo6iykExgbCd-4spJPusMCXxKstOw=CXfwQbw@mail.gmail.com>
References: <1449010541-3767-1-git-send-email-stefan.wahren@i2se.com>
	<1449010541-3767-3-git-send-email-stefan.wahren@i2se.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-ob0-f172.google.com ([209.85.214.172]:36815 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752494AbbLBPXR (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 2 Dec 2015 10:23:17 -0500
Received: by obcse5 with SMTP id se5so31357349obc.3
        for <linux-pwm@vger.kernel.org>; Wed, 02 Dec 2015 07:23:16 -0800 (PST)
In-Reply-To: <1449010541-3767-3-git-send-email-stefan.wahren@i2se.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Stefan Wahren <stefan.wahren@i2se.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>, Eric Anholt <eric@anholt.net>, linux-pwm@vger.kernel.org, Remi Pommarel <repk@triplefau.lt>, linux-rpi-kernel@lists.infradead.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 1 December 2015 at 15:55, Stefan Wahren <stefan.wahren@i2se.com> wrote:
> It's possible that the pwm clock become an orphan. So better
> check the result of clk_get_rate in order to prevent a division
> by zero.
>
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> ---
>  drivers/pwm/pwm-bcm2835.c |   10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pwm/pwm-bcm2835.c b/drivers/pwm/pwm-bcm2835.c
> index 174cca9..31a6992 100644
> --- a/drivers/pwm/pwm-bcm2835.c
> +++ b/drivers/pwm/pwm-bcm2835.c
> @@ -65,7 +65,15 @@ static int bcm2835_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
>                               int duty_ns, int period_ns)
>  {
>         struct bcm2835_pwm *pc = to_bcm2835_pwm(chip);
> -       unsigned long scaler = NSEC_PER_SEC / clk_get_rate(pc->clk);
> +       unsigned long rate = clk_get_rate(pc->clk);
> +       unsigned long scaler;
> +
> +       if (!rate) {
> +               dev_err(pc->dev, "failed to get clock rate\n");
> +               return -EINVAL;
> +       }
> +
> +       scaler = NSEC_PER_SEC / rate;

Stefan,

Please merge this code into patch 1/3.  That way it is done the right
way the first time around.

Thanks,
Mathieu

>
>         if (period_ns <= MIN_PERIOD) {
>                 dev_err(pc->dev, "period %d not supported, minimum %d\n",
> --
> 1.7.9.5
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
