Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03168C77B79
	for <linux-pwm@archiver.kernel.org>; Sun, 16 Apr 2023 17:02:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbjDPRCm (ORCPT <rfc822;linux-pwm@archiver.kernel.org>);
        Sun, 16 Apr 2023 13:02:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjDPRCk (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 16 Apr 2023 13:02:40 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A7401FFE
        for <linux-pwm@vger.kernel.org>; Sun, 16 Apr 2023 10:02:39 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1po5lq-0008Rd-5w; Sun, 16 Apr 2023 19:02:34 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1po5lo-00BgZu-Qe; Sun, 16 Apr 2023 19:02:32 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1po5lo-00Dgys-0x; Sun, 16 Apr 2023 19:02:32 +0200
Date:   Sun, 16 Apr 2023 19:02:32 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH] pwm: sti: Fix the error handling path of sti_pwm_probe()
Message-ID: <20230416170232.igjwawhnkgya2qee@pengutronix.de>
References: <ef5d6301cb120db5d52175a7bf94b5095beaaeef.1681633924.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qichhjai5fq4p6s3"
Content-Disposition: inline
In-Reply-To: <ef5d6301cb120db5d52175a7bf94b5095beaaeef.1681633924.git.christophe.jaillet@wanadoo.fr>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--qichhjai5fq4p6s3
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Sun, Apr 16, 2023 at 10:32:24AM +0200, Christophe JAILLET wrote:
> Rewrite the error handing path of sti_pwm_probe() to avoid some leaks.

There are also some clk_put()'s missing. See
https://lore.kernel.org/linux-pwm/20201013081531.661528-1-uwe@kleine-koenig=
=2Eorg
for an older fix of the things you noticed.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--qichhjai5fq4p6s3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmQ8KicACgkQj4D7WH0S
/k4rCgf+IgFiqYV/KJORdTuLVDP0Re0M+LXFE9SQ3feYlcXI4yGTxI+UQS3Is5mj
QSjVvfU01PG4PHg1AeT88fR3XHDKHfecKoobE5vLJPkdawirsVBGDRIDSPGlRniG
6ew05MYz2eQgNxN03KIFcIK2KQle8vgJBWVV2bgtFwkmc0gSbZtHfbr0KmtWUmpP
7BUvcK7or4s/Kx7jpLIY0KRYvCpQXgOEyQcemzm7GVH8NL6vnNym0pveGlSEBqSa
0ylrtOQ0mENxMAfRYxb4HMxdbZAb4uZkh/MAvDgcepsJF5/oFucCqiooz82vwkUZ
VMzQlpU/5sisJaUqBt6F5ZZhn9zCIw==
=amNk
-----END PGP SIGNATURE-----

--qichhjai5fq4p6s3--
