From: Lukasz Majewski <l.majewski@majess.pl>
Subject: Re: [PATCH v2 03/10] pwm: imx: Rewrite imx_pwm_*_v1 code to
 facilitate switch to atomic pwm operation
Date: Tue, 1 Nov 2016 06:57:23 +0100
Message-ID: <20161101065723.7751a55e@jawa>
References: <1477549785-4972-1-git-send-email-l.majewski@majess.pl>
        <1477549785-4972-4-git-send-email-l.majewski@majess.pl>
        <20161027094005.2da3b7d4@bbrezillon>
        <20161031055904.av45k535c26gjonz@pengutronix.de>
        <20161031092937.im5epytgorcd5fbm@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/Z9jgMB00z=K.2nuQ9beEMQi"; protocol="application/pgp-signature"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from 7.mo3.mail-out.ovh.net ([46.105.57.200]:33650 "EHLO
        7.mo3.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161736AbcKAF5s (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 1 Nov 2016 01:57:48 -0400
Received: from player772.ha.ovh.net (b7.ovh.net [213.186.33.57])
        by mo3.mail-out.ovh.net (Postfix) with ESMTP id 95A5F56F01
        for <linux-pwm@vger.kernel.org>; Tue,  1 Nov 2016 06:57:45 +0100 (CET)
In-Reply-To: <20161031092937.im5epytgorcd5fbm@pengutronix.de>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>, linux-pwm@vger.kernel.org, Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>, linux-kernel@vger.kernel.org, Stefan Agner <stefan@agner.ch>, Thierry Reding <thierry.reding@gmail.com>, kernel@pengutronix.de, Fabio Estevam <fabio.estevam@nxp.com>, Philipp Zabel <pza@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Lothar Wassmann <LW@karo-electronics.de>

--Sig_/Z9jgMB00z=K.2nuQ9beEMQi
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Sascha,

> The current assumption as discussed by Philipp and me is that the ipg
> clk is only needed when the pwm output is driven by the ipg clk
> (MX3_PWMCR[16:17] =3D MX3_PWMCR_CLKSRC_IPG)

At least on my setup (i.MX6q) the ipg clock (ipg_clk) don't need to be
explicitly enabled in the ->apply() callback (in the pwm-imx.c) when
MX3_PWMCR_CLKSRC_IPG (0x01 - ipg_clk) is selected as the PWM source.


Best regards,
=C5=81ukasz Majewski

--Sig_/Z9jgMB00z=K.2nuQ9beEMQi
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlgYLsoACgkQf9/hG2YwgjFU9ACgzLDJYKwYcJcgeK1kZwS9f4mX
KVcAoKZ8OEKkyXiy7iAUzeEwfXEMDaux
=w3Eb
-----END PGP SIGNATURE-----

--Sig_/Z9jgMB00z=K.2nuQ9beEMQi--
