Return-Path: <linux-pwm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 845CEC433FE
	for <linux-pwm@archiver.kernel.org>; Wed, 26 Oct 2022 19:46:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234108AbiJZTqa (ORCPT <rfc822;linux-pwm@archiver.kernel.org>);
        Wed, 26 Oct 2022 15:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235175AbiJZTqM (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 26 Oct 2022 15:46:12 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 244E97B5BE
        for <linux-pwm@vger.kernel.org>; Wed, 26 Oct 2022 12:45:04 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1onmKi-0005tV-Ka; Wed, 26 Oct 2022 21:45:00 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1onmKi-000Z3v-D6; Wed, 26 Oct 2022 21:44:59 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1onmKg-00Atad-LF; Wed, 26 Oct 2022 21:44:58 +0200
Date:   Wed, 26 Oct 2022 21:44:54 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH] pwm: Move pwm_capture() dummy to restore order
Message-ID: <20221026194454.xztun3lzkfzphukm@pengutronix.de>
References: <08a02c91eec1874ffd3ad7b8388ec7219686204c.1666706633.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kaxtpz5lhlsri7oz"
Content-Disposition: inline
In-Reply-To: <08a02c91eec1874ffd3ad7b8388ec7219686204c.1666706633.git.geert+renesas@glider.be>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--kaxtpz5lhlsri7oz
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Geert,

On Tue, Oct 25, 2022 at 04:04:23PM +0200, Geert Uytterhoeven wrote:
> Move the dummy pwm_capture(), to make the declaration order of all
> dummies to match the declaration order of the real functions.
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--kaxtpz5lhlsri7oz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmNZjjMACgkQwfwUeK3K
7AkU1wgAlet86m681OmUDKidFXD8+7i+0F5Y4eZzR/WUOLU2FAStTfSkTcrdAr70
4zfQYzgKKOCEgYyYRXw9GcWl3xVuvgm4pnHVqJxhxkfQEdrZXMMg5+2WzBtnoOq4
5Hg933aAFP6ZNFv91gjLfoDa6XFSsEeA0ax0dQDrrvfQY7d/AvsblkISN9apKR0W
A973PIa6HM5PKUbD6Nko0SfkMobpC5j9t9bDrcGdVqS1y4VI5pCPZwH2naFqFNhr
n6sCVqI/zWGYWZaRCbOf0mZ5qVLD+hbXq4nED/Jbnpz6AmgAcEfC1BxOLpF2w7oG
F5euEoBGQUsJjjHpt9CUCYPexyJ8tA==
=5Pqf
-----END PGP SIGNATURE-----

--kaxtpz5lhlsri7oz--
