From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] pwm: ab8500: Fix wrong value shift for disable/enable pwm
Date: Fri, 20 Dec 2013 18:10:27 +0100
Message-ID: <CACRpkdYBn+niqVD8j_3rkTSfh5x8HtKevw41FuW8oRqsaFeLGQ@mail.gmail.com>
References: <1387078339.22351.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-ob0-f173.google.com ([209.85.214.173]:57974 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753342Ab3LTRK2 (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 20 Dec 2013 12:10:28 -0500
Received: by mail-ob0-f173.google.com with SMTP id gq1so2978436obb.18
        for <linux-pwm@vger.kernel.org>; Fri, 20 Dec 2013 09:10:27 -0800 (PST)
In-Reply-To: <1387078339.22351.2.camel@phoenix>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Axel Lin <axel.lin@ingics.com>, Philippe Begnic <philippe.begnic@st.com>, alexandre.bourdiol@st.com
Cc: Thierry Reding <thierry.reding@avionic-design.de>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>

On Sun, Dec 15, 2013 at 4:32 AM, Axel Lin <axel.lin@ingics.com> wrote:

> Current code only works when pdev->id is 1. Fix it by passing correct bitvalues
> argument to abx500_mask_and_set_register_interruptible.
>
> Having defines for DISABLE_PWM/ENABLE_PWM does not make the code better
> in readability because the bitvalues depends on pdev->id.
> Thus drop defines for DISABLE_PWM/ENABLE_PWM.
>
> This patch also removes a unnecessary return in ab8500_pwm_disable.
>
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
>  drivers/pwm/pwm-ab8500.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/pwm/pwm-ab8500.c b/drivers/pwm/pwm-ab8500.c
> index 1d07a6f..d51dc15 100644
> --- a/drivers/pwm/pwm-ab8500.c
> +++ b/drivers/pwm/pwm-ab8500.c
> @@ -20,10 +20,6 @@
>  #define AB8500_PWM_OUT_CTRL2_REG       0x61
>  #define AB8500_PWM_OUT_CTRL7_REG       0x66
>
> -/* backlight driver constants */
> -#define ENABLE_PWM                     1
> -#define DISABLE_PWM                    0
> -
>  struct ab8500_pwm_chip {
>         struct pwm_chip chip;
>  };
> @@ -64,7 +60,7 @@ static int ab8500_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
>
>         ret = abx500_mask_and_set_register_interruptible(chip->dev,
>                                 AB8500_MISC, AB8500_PWM_OUT_CTRL7_REG,
> -                               1 << (chip->base - 1), ENABLE_PWM);
> +                               1 << (chip->base - 1), 1 << (chip->base - 1));
>         if (ret < 0)
>                 dev_err(chip->dev, "%s: Failed to enable PWM, Error %d\n",
>                                                         pwm->label, ret);
> @@ -77,11 +73,10 @@ static void ab8500_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
>
>         ret = abx500_mask_and_set_register_interruptible(chip->dev,
>                                 AB8500_MISC, AB8500_PWM_OUT_CTRL7_REG,
> -                               1 << (chip->base - 1), DISABLE_PWM);
> +                               1 << (chip->base - 1), 0);
>         if (ret < 0)
>                 dev_err(chip->dev, "%s: Failed to disable PWM, Error %d\n",
>                                                         pwm->label, ret);
> -       return;
>  }
>
>  static const struct pwm_ops ab8500_pwm_ops = {

Quoting verbatim som my colleagues can see it.

This patch makes a lot of sense after inspection, so
Acked-by: Linus Walleij <linus.walleij@linaro.org>

But allow Philippe & Alexandre (now added to To:)
to have a look at it too.

Yours,
Linus Walleij
