From: Guillermo Rodriguez Garcia <guille.rodriguez@gmail.com>
Subject: Re: pwm: atmel: Fix disabling of PWM channels
Date: Mon, 13 Jun 2016 12:31:58 +0200
Message-ID: <CABDcavaPf5yN+8ethEyrNc9_PumtNk6BhY8S0KLtTQJnnUxQ2A@mail.gmail.com>
References: <1463137777-27103-1-git-send-email-guille.rodriguez@gmail.com> <20160610082934.GQ2466@piout.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-vk0-f65.google.com ([209.85.213.65]:32867 "EHLO
	mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964910AbcFMKb7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 13 Jun 2016 06:31:59 -0400
In-Reply-To: <20160610082934.GQ2466@piout.net>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org

(resending to MLs for the record -- previous message bounced)

El viernes, 10 de junio de 2016, Alexandre Belloni
<alexandre.belloni@free-electrons.com> escribi=C3=B3:
>
> Hi,
>
> On 13/05/2016 at 13:09:37 +0200, Guillermo Rodriguez wrote :
> > When disabling a PWM channel, the PWM clock was being stopped
> > immediately after writing to PWM_DIS. As a result, the disabling
> > of the PWM channel did not complete properly, and the PWM output
> > might be left at the wrong level.
> >
> > Fix this by waiting for the channel to be effectively disabled
> > (by checking the PWM_SR register) before disabling the clock.
> >
> > Signed-off-by: Guillermo Rodriguez <guille.rodriguez@gmail.com>
> > ---
> >  drivers/pwm/pwm-atmel.c |   10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
> > index 0e4bd4e..a714434 100644
> > --- a/drivers/pwm/pwm-atmel.c
> > +++ b/drivers/pwm/pwm-atmel.c
> > @@ -271,6 +271,16 @@ static void atmel_pwm_disable(struct pwm_chip =
*chip, struct pwm_device *pwm)
> >       mutex_unlock(&atmel_pwm->isr_lock);
> >       atmel_pwm_writel(atmel_pwm, PWM_DIS, 1 << pwm->hwpwm);
> >
> > +     /*
> > +      * Wait for the PWM channel disable operation to be effective=
 before
> > +      * stopping the clock.
> > +      */
> > +     timeout =3D jiffies + 2 * HZ;
> > +     while ((atmel_pwm_readl(atmel_pwm, PWM_SR)& (1 << pwm->hwpwm)=
) &&
> > +            time_before(jiffies, timeout)) {
> > +             usleep_range(10, 100);
> > +     }
> > +
>
> While this seems good, can you tell on which SoC you observed that? I=
'd
> like to understand whether this is only on v1 or v2 or both.

I observed it on a sama5d3, however this article from atmel's KB would
seem to suggest that it is not specific to this SoC:

http://atmel.force.com/support/pkb_mobile#/articles/en_US/FAQ/Why-PWM-C=
hannel-Polarity-Inversion

Guillermo
