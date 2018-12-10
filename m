Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-eopbgr1410123.outbound.protection.outlook.com ([40.107.141.123]:8835
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726224AbeLJE6w (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sun, 9 Dec 2018 23:58:52 -0500
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Mon, 10 Dec 2018 04:58:46 +0000
Message-ID: <OSBPR01MB229367B0C11DD720F20CF823D8A50@OSBPR01MB2293.jpnprd01.prod.outlook.com>
References: <1544171373-29618-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1544171373-29618-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <20181207090717.qht2q6r3xzo2mzu4@pengutronix.de>
 <CAMuHMdUfrQ0u3eJ2Dmgmbb2Dt_DRmFNXXDzS=W0MmsoemU61ag@mail.gmail.com>
 <20181207104548.cuwlavf62f2f4hdk@pengutronix.de>
In-Reply-To: <20181207104548.cuwlavf62f2f4hdk@pengutronix.de>
Content-Language: ja-JP
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
Subject: RE: [PATCH 2/5] pwm: rcar: Add support "atomic" API
To: =?iso-8859-2?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Thierry Reding <thierry.reding@gmail.com>, Linux PWM List <linux-pwm@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, =?iso-8859-2?Q?Michal_Vok=E1=E8?= <Michal.Vokac@ysoft.com>

Hi Uwe,

> From: Uwe Kleine-K=F6nig, Sent: Friday, December 7, 2018 7:46 PM
>=20
> Hello,
>=20
> On Fri, Dec 07, 2018 at 10:57:48AM +0100, Geert Uytterhoeven wrote:
> > > Is the documentation for this hardware publically available?
> >
> > Please check Section 59 of the "User's Manual: Hardware" at
> > https://www.renesas.com/eu/en/products/microcontrollers-microprocessors=
/rz/rzg/rzg1m.html
>=20
> Thanks.
>=20
> So the ugly things here are:
>=20
>  a) if the pwm is stopped (PWMCR.ENO =3D 0) the output is set to high aft=
er
>     completion of the currently running period.
>  b) setting a duty_cycle of 0 is forbidden

Thank you for checking the hardware specification.

> both are bad. A workaround for both is implementation of something
> similar to the switch to a gpio suggested by Michal for imx. But this
> cannot be done reliably because the current period's end isn't
> observable.

I agree. This R-Car PWM needs special handling when the driver disable the =
PWM.

> Alternatively a confirmation from the Renesas engineers that PWMCNT.PHO
> can be set to 0 with the intended effect despite being forbidden in the
> reference manual would be great. Did someone with access to such
> hardware test what happens if the PHO field is set to 0? Maybe the
> forbidden value is just a wrong copy&paste from the CYCO field?

I'm asking HW guy about this specification now.
# According to the state machine in the manual, it seems the PWM cannot out=
put
# low level when the PWM is enabled though...

> I think it would be a good idea to add the link to the documentation
> into a comment at the top of the driver.

I think so.

Best regards,
Yoshihiro Shimoda

> @Thierry: Given that nobody seems to have an overview about the features
> and ugly implementation details of all the PWMs, what about documenting
> them in the driver files in a greppable way. For the rcar driver
> something like:
>=20
>  - duty-counter-bits: 10
>  - period-counter-bits: 10
>  - hardware-polarity-support: false
>  - uglyness:
>    - OUTPUT-ACTIVE-ON-DISABLE
>    - NO-ZERO-DUTY-CYCLE
>=20
> Best regards
> Uwe
>=20
> --
> Pengutronix e.K.                           | Uwe Kleine-K=F6nig          =
  |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  =
|
