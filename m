Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:49409 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727295AbfAHJT3 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 8 Jan 2019 04:19:29 -0500
Date: Tue, 8 Jan 2019 10:19:25 +0100
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Message-ID: <20190108091925.gcv6tqkvxr2ilj3w@pengutronix.de>
References: <1546918094-13960-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1546918094-13960-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <20190108074749.d23mpcr3wscr6s5j@pengutronix.de>
 <CAMuHMdUdrfjUHzOZr25a4JsRNK34KL8kA1s1G+BrpRzZgtB-7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAMuHMdUdrfjUHzOZr25a4JsRNK34KL8kA1s1G+BrpRzZgtB-7w@mail.gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
Subject: Re: [PATCH v2 2/4] pwm: rcar: Use "atomic" API on rcar_pwm_resume()
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Thierry Reding <thierry.reding@gmail.com>, Linux PWM List <linux-pwm@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>

Hello Geert,

On Tue, Jan 08, 2019 at 09:56:28AM +0100, Geert Uytterhoeven wrote:
> On Tue, Jan 8, 2019 at 8:48 AM Uwe Kleine-K=F6nig
> <u.kleine-koenig@pengutronix.de> wrote:
> > Orthogonal to this patch I wonder what the intended behaviour for a pwm
> > is on suspend. Should it stop oscilating unconditionally? Or should it
> > only stop if the consumer stops it as part of its own suspend callback?
>=20
> I guess you mean system suspend, not runtime suspend, as the device is
> runtime-resumed when a PWM is requested?

I admit that suspend (both system and runtime) is a bit of a black box
for me. So please take that into account when judging my statements.
=20
> Permitted behavior depends on the system: on R-Car Gen3 (arm64), PSCI sys=
tem
> suspend will power down the SoC, so PWM output will stop for sure.
>=20
> On R-Car Gen2 (or R-Car Gen3 with s2idle instead of s2ram), the PM Domain
> code will turn of the PWM module's clock. Hence it will stop oscillating,=
 unless
> you take special countermeasures, like for modules that need to stay powe=
red
> for wake-up handling.

Whatever "suspend" here means, I want to prevent that a stopping pwm is
a surprise for the consumer. So I think suspend should be inhibited if
the consumer might expect the pwm to continue running but the pwm is
about to stop. So if the suspend affects the consumer, too, it's the
consumer that should be responsible to stop the pwm in a controlled
manner.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
