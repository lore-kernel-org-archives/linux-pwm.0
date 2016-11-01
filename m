From: Lukasz Majewski <l.majewski@majess.pl>
Subject: Re: [PATCH v2 03/10] pwm: imx: Rewrite imx_pwm_*_v1 code to
 facilitate switch to atomic pwm operation
Date: Tue, 1 Nov 2016 09:20:58 +0100
Message-ID: <20161101092058.3a9446e8@jawa>
References: <1477549785-4972-1-git-send-email-l.majewski@majess.pl>
        <1477549785-4972-4-git-send-email-l.majewski@majess.pl>
        <20161027094005.2da3b7d4@bbrezillon>
        <20161031055904.av45k535c26gjonz@pengutronix.de>
        <20161031092937.im5epytgorcd5fbm@pengutronix.de>
        <20161101065723.7751a55e@jawa>
        <20161101071743.ef3nhdhaquhbgtlo@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/cc4c_QfTbQSMbtEYrz9p/_1"; protocol="application/pgp-signature"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from 20.mo3.mail-out.ovh.net ([178.33.47.94]:39343 "EHLO
        20.mo3.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1167971AbcKAIVV (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 1 Nov 2016 04:21:21 -0400
Received: from player772.ha.ovh.net (b7.ovh.net [213.186.33.57])
        by mo3.mail-out.ovh.net (Postfix) with ESMTP id E139F57710
        for <linux-pwm@vger.kernel.org>; Tue,  1 Nov 2016 09:21:19 +0100 (CET)
In-Reply-To: <20161101071743.ef3nhdhaquhbgtlo@pengutronix.de>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>, linux-pwm@vger.kernel.org, Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>, linux-kernel@vger.kernel.org, Stefan Agner <stefan@agner.ch>, Thierry Reding <thierry.reding@gmail.com>, kernel@pengutronix.de, Fabio Estevam <fabio.estevam@nxp.com>, Philipp Zabel <pza@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Lothar Wassmann <LW@karo-electronics.de>

--Sig_/cc4c_QfTbQSMbtEYrz9p/_1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Sascha

> On Tue, Nov 01, 2016 at 06:57:23AM +0100, Lukasz Majewski wrote:
> > Hi Sascha,
> >=20
> > > The current assumption as discussed by Philipp and me is that the
> > > ipg clk is only needed when the pwm output is driven by the ipg
> > > clk (MX3_PWMCR[16:17] =3D MX3_PWMCR_CLKSRC_IPG)
> >=20
> > At least on my setup (i.MX6q) the ipg clock (ipg_clk) don't need to
> > be explicitly enabled in the ->apply() callback (in the pwm-imx.c)
> > when MX3_PWMCR_CLKSRC_IPG (0x01 - ipg_clk) is selected as the PWM
> > source.
>=20
> No. If you look in the device tree you'll see that there is no special
> gateable ipg clock for the PWM. Instead the SoC ipg clock is
> registered for the PWM which is not gateable.

I do understand that the goal is to enable ipg clock only on demand
(when we access registers) and just wanted to say that the approach with
ipg enabled in dts works on my setup (and for now is sufficient).

I suppose that ipg gating support for PWM will be provided in a separate
patch.

>=20
> Sascha
>=20

Best regards,

=C5=81ukasz Majewski

--Sig_/cc4c_QfTbQSMbtEYrz9p/_1
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlgYUG8ACgkQf9/hG2YwgjGrWwCgkaGIMwKCZuhKQJj+G7zIAnTb
EYUAn2/vX6s3q3bB2A3eM/d8CHt5KWE/
=Djn4
-----END PGP SIGNATURE-----

--Sig_/cc4c_QfTbQSMbtEYrz9p/_1--
