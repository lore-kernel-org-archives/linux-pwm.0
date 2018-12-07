Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:52415 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725986AbeLGKpz (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 7 Dec 2018 05:45:55 -0500
Date: Fri, 7 Dec 2018 11:45:48 +0100
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Message-ID: <20181207104548.cuwlavf62f2f4hdk@pengutronix.de>
References: <1544171373-29618-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1544171373-29618-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <20181207090717.qht2q6r3xzo2mzu4@pengutronix.de>
 <CAMuHMdUfrQ0u3eJ2Dmgmbb2Dt_DRmFNXXDzS=W0MmsoemU61ag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAMuHMdUfrQ0u3eJ2Dmgmbb2Dt_DRmFNXXDzS=W0MmsoemU61ag@mail.gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
Subject: Re: [PATCH 2/5] pwm: rcar: Add support "atomic" API
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Thierry Reding <thierry.reding@gmail.com>, Linux PWM List <linux-pwm@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Michal =?utf-8?B?Vm9rw6HEjQ==?= <Michal.Vokac@ysoft.com>

Hello,

On Fri, Dec 07, 2018 at 10:57:48AM +0100, Geert Uytterhoeven wrote:
> > Is the documentation for this hardware publically available?
>=20
> Please check Section 59 of the "User's Manual: Hardware" at
> https://www.renesas.com/eu/en/products/microcontrollers-microprocessors/r=
z/rzg/rzg1m.html

Thanks.

So the ugly things here are:

 a) if the pwm is stopped (PWMCR.ENO =3D 0) the output is set to high after
    completion of the currently running period.
 b) setting a duty_cycle of 0 is forbidden

both are bad. A workaround for both is implementation of something
similar to the switch to a gpio suggested by Michal for imx. But this
cannot be done reliably because the current period's end isn't
observable.

Alternatively a confirmation from the Renesas engineers that PWMCNT.PHO
can be set to 0 with the intended effect despite being forbidden in the
reference manual would be great. Did someone with access to such
hardware test what happens if the PHO field is set to 0? Maybe the
forbidden value is just a wrong copy&paste from the CYCO field?

I think it would be a good idea to add the link to the documentation
into a comment at the top of the driver.

@Thierry: Given that nobody seems to have an overview about the features
and ugly implementation details of all the PWMs, what about documenting
them in the driver files in a greppable way. For the rcar driver
something like:

 - duty-counter-bits: 10
 - period-counter-bits: 10
 - hardware-polarity-support: false
 - uglyness:
   - OUTPUT-ACTIVE-ON-DISABLE
   - NO-ZERO-DUTY-CYCLE

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
