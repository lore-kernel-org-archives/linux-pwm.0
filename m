Return-Path: <linux-pwm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A714CC6FA89
	for <linux-pwm@archiver.kernel.org>; Wed, 14 Sep 2022 16:11:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbiINQLq (ORCPT <rfc822;linux-pwm@archiver.kernel.org>);
        Wed, 14 Sep 2022 12:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiINQLp (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 14 Sep 2022 12:11:45 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D335C642EA
        for <linux-pwm@vger.kernel.org>; Wed, 14 Sep 2022 09:11:44 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oYUzH-0003h3-9y; Wed, 14 Sep 2022 18:11:43 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oYUzG-000jGN-NL; Wed, 14 Sep 2022 18:11:41 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oYUzE-000tox-Jz; Wed, 14 Sep 2022 18:11:40 +0200
Date:   Wed, 14 Sep 2022 18:11:40 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Ben Dooks <ben.dooks@sifive.com>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        jarkko.nikula@linux.intel.com,
        William Salmon <william.salmon@sifive.com>,
        Jude Onyenegecha <jude.onyenegecha@sifive.com>
Subject: Re: [RFC v4 02/10] pwm: dwc: allow driver to be built with
 COMPILE_TEST
Message-ID: <20220914161140.5okqkrryr5jtpscu@pengutronix.de>
References: <20220816211454.237751-1-ben.dooks@sifive.com>
 <20220816211454.237751-3-ben.dooks@sifive.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="upq2s374iwbikcao"
Content-Disposition: inline
In-Reply-To: <20220816211454.237751-3-ben.dooks@sifive.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--upq2s374iwbikcao
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Tue, Aug 16, 2022 at 10:14:46PM +0100, Ben Dooks wrote:
> Allow dwc driver to be built with COMPILE_TEST should allow
> better coverage when build testing.
>=20
> Signed-off-by: Ben Dooks <ben.dooks@sifive.com>

Very welcome, so:

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--upq2s374iwbikcao
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmMh/TkACgkQwfwUeK3K
7Am9Igf9F9GghqtNyhf1DUfNUmMp4RJeQzMkwOVa5CYCOUEV+1Hvm8OlvUQ7uq6k
2e2poJB2QwkPjAVZJ6AqYG2QcNysmwM5mBDbfl/W1OfT+MO1nrQJPXn4cuAgFar2
u/exnbBalFmzf4pBZGymXUVFhiZDmwZJQOc8srAO4CgYYMQpHAJhiNar8XyjJRnZ
Vgs+ltQeFqulHkGD7iZYpBHxz//k3SJbZ66N6uXtOPqgIET3I5eiZW/pTxonbsaP
11czxpHabI/dSmHBYot47XOkyEnfaGH5L41XU9fK/x7xW213RGqAU6DgAgqSHdDM
GpVUePcNknT4xvLL+yOfZOfaL1YSZQ==
=zEgm
-----END PGP SIGNATURE-----

--upq2s374iwbikcao--
