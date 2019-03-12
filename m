Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:55209 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbfCLJyg (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 12 Mar 2019 05:54:36 -0400
Date: Tue, 12 Mar 2019 10:54:33 +0100
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Message-ID: <20190312095433.fl2nbbj3jsqxhcny@pengutronix.de>
References: <1552360594-21547-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <20190312092302.2x6zf4imlfsevmkr@pengutronix.de>
 <CAMuHMdUYqk6nFAd2TQ_xM9q3bHskpd8vZXJ8DiF3tFwJQLc=tg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAMuHMdUYqk6nFAd2TQ_xM9q3bHskpd8vZXJ8DiF3tFwJQLc=tg@mail.gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
Subject: Re: [PATCH] pwm: Avoid deadlock warning when removing PWM device
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Thierry Reding <thierry.reding@gmail.com>, Linux PWM List <linux-pwm@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Phong Hoang <phong.hoang.wz@renesas.com>

On Tue, Mar 12, 2019 at 10:49:59AM +0100, Geert Uytterhoeven wrote:
> Hi Uwe,
>=20
> On Tue, Mar 12, 2019 at 10:23 AM Uwe Kleine-K=F6nig
> <u.kleine-koenig@pengutronix.de> wrote:
> > On Tue, Mar 12, 2019 at 12:16:34PM +0900, Yoshihiro Shimoda wrote:
> > > diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> > > index 1581f6a..2fdd6611 100644
> > > --- a/drivers/pwm/core.c
> > > +++ b/drivers/pwm/core.c
>=20
> > > @@ -368,10 +370,12 @@ int pwmchip_remove(struct pwm_chip *chip)
> > >
> > >       free_pwms(chip);
> > >
> > > -     pwmchip_sysfs_unexport(chip);
> > > -
> > >  out:
> > >       mutex_unlock(&pwm_lock);
> > > +
> > > +     if (!ret)
> > > +             pwmchip_sysfs_unexport(chip);
> > > +
> >
> > I wonder if this needs to be done before free_pwms is called. Otherwise
> > the pwmchip is already gone and then something is requested via sysfs.
>=20
> The chip itself is not freed, only the pwms array inside, which is not ne=
eded
> for matching in pwmchip_sysfs_unexport(), right?

OK, then make this:

I wonder if pwmchip_sysfs_unexport needs to be done before free_pwms is
called. Otherwise the PWMs's representation is already gone and then
something might be requested via sysfs.
=20
Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
