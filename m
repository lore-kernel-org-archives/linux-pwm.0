From: Alexandre BOURDIOL <alexandre.bourdiol@st.com>
Subject: RE: [PATCH] pwm: ab8500: Fix wrong value shift for disable/enable
 pwm
Date: Mon, 6 Jan 2014 09:55:13 +0100
Message-ID: <0B9F1C5B86169C4EA9D042C251022E4938C76BA80F@SAFEX1MAIL3.st.com>
References: <1387078339.22351.2.camel@phoenix>
 <CACRpkdYBn+niqVD8j_3rkTSfh5x8HtKevw41FuW8oRqsaFeLGQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from eu1sys200aog120.obsmtp.com ([207.126.144.149]:43684 "EHLO
	eu1sys200aog120.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751799AbaAFIzj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pwm@vger.kernel.org>);
	Mon, 6 Jan 2014 03:55:39 -0500
In-Reply-To: <CACRpkdYBn+niqVD8j_3rkTSfh5x8HtKevw41FuW8oRqsaFeLGQ@mail.gmail.com>
Content-Language: en-US
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Axel Lin <axel.lin@ingics.com>, Philippe BEGNIC ST <philippe.begnic@st.com>
Cc: Thierry Reding <thierry.reding@avionic-design.de>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>

Hi,
That is fine for me.

Best regards and happy new year
Alexandre BOURDIOL=20

-----Original Message-----
=46rom: Linus Walleij [mailto:linus.walleij@linaro.org]=20
Sent: vendredi 20 d=E9cembre 2013 18:10
To: Axel Lin; Philippe BEGNIC ST; Alexandre BOURDIOL
Cc: Thierry Reding; linux-pwm@vger.kernel.org
Subject: Re: [PATCH] pwm: ab8500: Fix wrong value shift for disable/ena=
ble pwm

On Sun, Dec 15, 2013 at 4:32 AM, Axel Lin <axel.lin@ingics.com> wrote:

> Current code only works when pdev->id is 1. Fix it by passing correct=
=20
> bitvalues argument to abx500_mask_and_set_register_interruptible.
>
> Having defines for DISABLE_PWM/ENABLE_PWM does not make the code=20
> better in readability because the bitvalues depends on pdev->id.
> Thus drop defines for DISABLE_PWM/ENABLE_PWM.
>
> This patch also removes a unnecessary return in ab8500_pwm_disable.
>
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
>  drivers/pwm/pwm-ab8500.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/pwm/pwm-ab8500.c b/drivers/pwm/pwm-ab8500.c inde=
x=20
> 1d07a6f..d51dc15 100644
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
> @@ -64,7 +60,7 @@ static int ab8500_pwm_enable(struct pwm_chip *chip,=
=20
> struct pwm_device *pwm)
>
>         ret =3D abx500_mask_and_set_register_interruptible(chip->dev,
>                                 AB8500_MISC, AB8500_PWM_OUT_CTRL7_REG=
,
> -                               1 << (chip->base - 1), ENABLE_PWM);
> +                               1 << (chip->base - 1), 1 <<=20
> + (chip->base - 1));
>         if (ret < 0)
>                 dev_err(chip->dev, "%s: Failed to enable PWM, Error %=
d\n",
>                                                         pwm->label,=20
> ret); @@ -77,11 +73,10 @@ static void ab8500_pwm_disable(struct=20
> pwm_chip *chip, struct pwm_device *pwm)
>
>         ret =3D abx500_mask_and_set_register_interruptible(chip->dev,
>                                 AB8500_MISC, AB8500_PWM_OUT_CTRL7_REG=
,
> -                               1 << (chip->base - 1), DISABLE_PWM);
> +                               1 << (chip->base - 1), 0);
>         if (ret < 0)
>                 dev_err(chip->dev, "%s: Failed to disable PWM, Error =
%d\n",
>                                                         pwm->label, r=
et);
> -       return;
>  }
>
>  static const struct pwm_ops ab8500_pwm_ops =3D {

Quoting verbatim som my colleagues can see it.

This patch makes a lot of sense after inspection, so
Acked-by: Linus Walleij <linus.walleij@linaro.org>

But allow Philippe & Alexandre (now added to To:) to have a look at it =
too.

Yours,
Linus Walleij
