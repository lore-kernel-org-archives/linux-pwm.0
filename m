From: Lukasz Majewski <l.majewski@majess.pl>
Subject: Re: [PATCH 0/6] pwm: imx: Provide atomic operation for IMX PWM
 driver
Date: Mon, 24 Oct 2016 23:26:15 +0200
Message-ID: <20161024232615.77d4ea28@jawa>
References: <1477259146-19167-1-git-send-email-l.majewski@majess.pl>
        <20161024173607.36bc2cb9@bbrezillon>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/JnB9_yaxmO5n.C3EXaQusID"; protocol="application/pgp-signature"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from 17.mo3.mail-out.ovh.net ([87.98.178.58]:43313 "EHLO
        17.mo3.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756195AbcJXV0g (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 24 Oct 2016 17:26:36 -0400
Received: from player693.ha.ovh.net (b9.ovh.net [213.186.33.59])
        by mo3.mail-out.ovh.net (Postfix) with ESMTP id 034A14B627
        for <linux-pwm@vger.kernel.org>; Mon, 24 Oct 2016 23:26:33 +0200 (CEST)
In-Reply-To: <20161024173607.36bc2cb9@bbrezillon>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Stefan Agner <stefan@agner.ch>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>, Fabio Estevam <festevam@gmail.com>, Lothar Wassmann <LW@karo-electronics.de>, Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>, kernel@pengutronix.de

--Sig_/JnB9_yaxmO5n.C3EXaQusID
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Boris,

> On Sun, 23 Oct 2016 23:45:40 +0200
> Lukasz Majewski <l.majewski@majess.pl> wrote:
>=20
> > This patch set brings atomic operation to i.MX's PWMv2 driver.
> >=20
> > This work has been supported and suggested by Boris Brezillon [1]
> > and Stefan Agner, by showing how simple the transition could be :-).
> >=20
> > It has been divided into several steps:
> > - Separate PWMv1 commits from "generic" and non atomic PWM code.
> >=20
> >   NOTE: Since I do not have board with PWMv1, I would like to ask
> > somebody for testing
> >=20
> > - Move some imx_config_v2 code to separate functions
> >=20
> > - Provide PWM atomic implementation (the ->apply() driver) in a
> > single patch for better readability.
> >=20
> > - Remove redundant PWM code (disable, enable, config callbacks)
> >=20
> > - Clean up the driver infrastructure
> >=20
> > - Provide "polarity_supported" flag to indicate support for
> > polarity inversion
> >=20
> > This work should be applied on top of following commits:
> >=20
> > http://patchwork.ozlabs.org/patch/679706/=20
[2]

> > http://patchwork.ozlabs.org/patch/679707/
[3]

> > http://patchwork.ozlabs.org/patch/679680/
>=20
> I'm not sure I follow the logic here. Has patch [1] already been
> applied? If that's not the case, then you should just drop it and put
> your changes on top of mainline.
>=20
> [1]http://patchwork.ozlabs.org/patch/679680/

Patches [2] and [3] have been developed initially by Lothar and
subsequently picked up by Bhuvanchandra. There is no issue with them.

The patch [1] is a bit more tricky. The work has been done by
Bhuvanchandra, which adds DTS and core support for polarity inversion.

This code works and utilizes the "old" PWM API with enable, disable and
config. However, Stefan had some comments about the placement for the
polarity setting (in the .config_v2()) and proposed switch to atomic
API.

To make things easier and cleaner, I decided to put my atomic API
rework on top of those patches. In this way I can credit the previous
work and avoid rewriting DTS polarity inversion code already developed
and validated by Bhuvanchandra.



Best regards,
=C5=81ukasz Majewski





--Sig_/JnB9_yaxmO5n.C3EXaQusID
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlgOfH0ACgkQf9/hG2YwgjH+NACggL2432WkL7MHZ08A+3Z6Nj4w
fMkAn0Xqr5Z/IxPLWWVJhTv669Qg8x7Z
=2Lbg
-----END PGP SIGNATURE-----

--Sig_/JnB9_yaxmO5n.C3EXaQusID--
