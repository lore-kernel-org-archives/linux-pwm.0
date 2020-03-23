From: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Subject: Re: [PATCH v1 2/2] pwm: bcm-iproc: remove unnecessary check of 'duty'
Date: Mon, 23 Mar 2020 14:43:45 +0530
Message-ID: <CAHO=5PHUPy=2_HZg26Akogv3Hbic7JPydGpz0j3QfA=3TUgCJw@mail.gmail.com>
References: <20200323065318.16533-1-rayagonda.kokatanur@broadcom.com>
 <20200323065318.16533-3-rayagonda.kokatanur@broadcom.com> <20200323082823.twvpagq7tvrt76ws@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-lf1-f67.google.com ([209.85.167.67]:42324 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727325AbgCWJN7 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 23 Mar 2020 05:13:59 -0400
Received: by mail-lf1-f67.google.com with SMTP id t21so9579964lfe.9
        for <linux-pwm@vger.kernel.org>; Mon, 23 Mar 2020 02:13:58 -0700 (PDT)
In-Reply-To: <20200323082823.twvpagq7tvrt76ws@pengutronix.de>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Thierry Reding <thierry.reding@gmail.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>, Yendapally Reddy Dhananjaya Reddy <yendapally.reddy@broadcom.com>, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Mon, Mar 23, 2020 at 1:58 PM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> On Mon, Mar 23, 2020 at 12:23:18PM +0530, Rayagonda Kokatanur wrote:
> > Variable 'duty' is u32. Hence the less-than zero
> > comparison is never true, remove the check.
>
> How did you find that one? I assume it was a compiler warning you fixed
> here? In this case quoting the warning improves the commit log.
Its reported by internal coverity tool.
>
> Also the commit log suggests that IPROC_PWM_DUTY_CYCLE_MIN is zero.
> Maybe mentioning that explicitly is a nice addition, too.
Okay, will add this to commit message. Thanks.
>
> > Fixes: daa5abc41c80 ("pwm: Add support for Broadcom iProc PWM controlle=
r")
> > Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
> > ---
> >  drivers/pwm/pwm-bcm-iproc.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/drivers/pwm/pwm-bcm-iproc.c b/drivers/pwm/pwm-bcm-iproc.c
> > index 8bbd2a04fead..1bb66721f985 100644
> > --- a/drivers/pwm/pwm-bcm-iproc.c
> > +++ b/drivers/pwm/pwm-bcm-iproc.c
> > @@ -149,8 +149,7 @@ static int iproc_pwmc_apply(struct pwm_chip *chip, =
struct pwm_device *pwm,
> >               value =3D rate * state->duty_cycle;
> >               duty =3D div64_u64(value, div);
> >
> > -             if (period < IPROC_PWM_PERIOD_MIN ||
> > -                 duty < IPROC_PWM_DUTY_CYCLE_MIN)
> > +             if (period < IPROC_PWM_PERIOD_MIN)
> >                       return -EINVAL;
>
> Best regards
> Uwe
>
> --
> Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig       =
     |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ =
|
