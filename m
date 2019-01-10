Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:59569 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727916AbfAJJvH (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 10 Jan 2019 04:51:07 -0500
Date: Thu, 10 Jan 2019 10:51:02 +0100
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Message-ID: <20190110095102.t63cep3mgezdrysh@pengutronix.de>
References: <1546918094-13960-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1546918094-13960-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <20190108074749.d23mpcr3wscr6s5j@pengutronix.de>
 <CAMuHMdUdrfjUHzOZr25a4JsRNK34KL8kA1s1G+BrpRzZgtB-7w@mail.gmail.com>
 <20190108091925.gcv6tqkvxr2ilj3w@pengutronix.de>
 <CAMuHMdVxdG6DsXxa6T+u7F9HniywjwQneQ5GZ6xoEai89nu-9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAMuHMdVxdG6DsXxa6T+u7F9HniywjwQneQ5GZ6xoEai89nu-9w@mail.gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
Subject: Re: [PATCH v2 2/4] pwm: rcar: Use "atomic" API on rcar_pwm_resume()
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Thierry Reding <thierry.reding@gmail.com>, Linux PWM List <linux-pwm@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>

On Tue, Jan 08, 2019 at 10:35:29AM +0100, Geert Uytterhoeven wrote:
> Hi Uwe,
>=20
> On Tue, Jan 8, 2019 at 10:19 AM Uwe Kleine-K=F6nig
> <u.kleine-koenig@pengutronix.de> wrote:
> > On Tue, Jan 08, 2019 at 09:56:28AM +0100, Geert Uytterhoeven wrote:
> > > On Tue, Jan 8, 2019 at 8:48 AM Uwe Kleine-K=F6nig
> > > <u.kleine-koenig@pengutronix.de> wrote:
> > > > Orthogonal to this patch I wonder what the intended behaviour for a=
 pwm
> > > > is on suspend. Should it stop oscilating unconditionally? Or should=
 it
> > > > only stop if the consumer stops it as part of its own suspend callb=
ack?
> > >
> > > I guess you mean system suspend, not runtime suspend, as the device is
> > > runtime-resumed when a PWM is requested?
> >
> > I admit that suspend (both system and runtime) is a bit of a black box
> > for me. So please take that into account when judging my statements.
> >
> > > Permitted behavior depends on the system: on R-Car Gen3 (arm64), PSCI=
 system
> > > suspend will power down the SoC, so PWM output will stop for sure.
> > >
> > > On R-Car Gen2 (or R-Car Gen3 with s2idle instead of s2ram), the PM Do=
main
> > > code will turn of the PWM module's clock. Hence it will stop oscillat=
ing, unless
> > > you take special countermeasures, like for modules that need to stay =
powered
> > > for wake-up handling.
> >
> > Whatever "suspend" here means, I want to prevent that a stopping pwm is
> > a surprise for the consumer. So I think suspend should be inhibited if
> > the consumer might expect the pwm to continue running but the pwm is
> > about to stop. So if the suspend affects the consumer, too, it's the
> > consumer that should be responsible to stop the pwm in a controlled
> > manner.
>=20
> I think you can inhibit suspend by letting the .suspend() callback return=
 an
> error. However, I think the PWM driver cannot make that decision on its o=
wn.
> Shutting down the PWM for a status LED is harmless, and the status LED be=
ing
> enabled should not prevent a system suspend.
> Shutting down e.g. a motor may be different.

Also this is something that should be implemented in the core (or at
least consistently in all drivers). So I think it's not sensible to
continue discussion that in the context of this rcar change. I added it
to my list of stuff to discuss.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
