From: Alexander <alex.mobigo@gmail.com>
Subject: Re: [PATCH] [RFC] pwm: sun4i: Move pwm_calculate out of spin_lock
Date: Sun, 12 Jan 2020 21:39:55 -0300
Message-ID: <CAGfOxi2vUVLv1_PGynu_53=DvuMBKFE6UTFUoTPTqjW1VvotLg@mail.gmail.com>
References: <20200109233106.17060-1-peron.clem@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-yw1-f66.google.com ([209.85.161.66]:34766 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387514AbgAMAkH (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 12 Jan 2020 19:40:07 -0500
Received: by mail-yw1-f66.google.com with SMTP id b186so4875947ywc.1
        for <linux-pwm@vger.kernel.org>; Sun, 12 Jan 2020 16:40:07 -0800 (PST)
In-Reply-To: <20200109233106.17060-1-peron.clem@gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Vasily Khoruzhick <anarsoul@gmail.com>

On Thu, Jan 9, 2020 at 8:31 PM Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.co=
m> wrote:
>
> pwm_calculate calls clk_get_rate while holding a spin_lock.
>
> This create an issue as clk_get_rate() may sleep.
>
> Move pwm_calculate out of this spin_lock.
>
> Fixes: c32c5c50d4fe ("pwm: sun4i: Switch to atomic PWM")
> Reported-by: Alex Mobigo <alex.mobigo@gmail.com>
> Suggested-by: Vasily Khoruzhick <anarsoul@gmail.com>
> Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
> ---
>
> Hi,
>
> this issue has been reported on linux-sunxi Google groups.
>
> I don't have a board with PWM to confirm it.
>
> Please wait a tested-by.
>
> Thanks,
> Cl=C3=A9ment
>
>  drivers/pwm/pwm-sun4i.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
> index 1afd41ebd3fd..6b230029dc49 100644
> --- a/drivers/pwm/pwm-sun4i.c
> +++ b/drivers/pwm/pwm-sun4i.c
> @@ -248,19 +248,18 @@ static int sun4i_pwm_apply(struct pwm_chip *chip, s=
truct pwm_device *pwm,
>                 }
>         }
>
> -       spin_lock(&sun4i_pwm->ctrl_lock);
> -       ctrl =3D sun4i_pwm_readl(sun4i_pwm, PWM_CTRL_REG);
> -
>         ret =3D sun4i_pwm_calculate(sun4i_pwm, state, &duty, &period, &pr=
escaler,
>                                   &bypass);
>         if (ret) {
>                 dev_err(chip->dev, "period exceeds the maximum value\n");
> -               spin_unlock(&sun4i_pwm->ctrl_lock);
>                 if (!cstate.enabled)
>                         clk_disable_unprepare(sun4i_pwm->clk);
>                 return ret;
>         }
>
> +       spin_lock(&sun4i_pwm->ctrl_lock);
> +       ctrl =3D sun4i_pwm_readl(sun4i_pwm, PWM_CTRL_REG);
> +
>         if (sun4i_pwm->data->has_direct_mod_clk_output) {
>                 if (bypass) {
>                         ctrl |=3D BIT_CH(PWM_BYPASS, pwm->hwpwm);
> --
> 2.20.1
>
"""""""""""""""""
Tested on my board Pine64+, problems occurs before the patch but not after.=
..

Tested-By: Alexander Finger <alex.mobigo@gmail.com>
"""""""""""""""
