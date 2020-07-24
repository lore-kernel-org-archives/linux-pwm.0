Return-Path: <SRS0=X22+=BD=vger.kernel.org=linux-pwm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 950BAC433E3
	for <linux-pwm@archiver.kernel.org>; Fri, 24 Jul 2020 22:32:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 700952067D
	for <linux-pwm@archiver.kernel.org>; Fri, 24 Jul 2020 22:32:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbgGXWcz (ORCPT <rfc822;linux-pwm@archiver.kernel.org>);
        Fri, 24 Jul 2020 18:32:55 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:49260 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbgGXWcz (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 24 Jul 2020 18:32:55 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id A35DF1C0BD2; Sat, 25 Jul 2020 00:32:52 +0200 (CEST)
Date:   Sat, 25 Jul 2020 00:32:52 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Martin Botka <martin.botka1@gmail.com>
Cc:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Dan Murphy <dmurphy@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH RFC 0/6] Add QCOM pwm-lpg and tri-led drivers
Message-ID: <20200724223252.GC21965@amd>
References: <20200724213659.273599-1-martin.botka1@gmail.com>
 <20200724220516.GA21965@amd>
 <CADQ2G_Fvyyh6-foswczkQgX54rH6oH-m8xyS6Qp2yS6D5L4Q9A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="96YOpH+ONegL0A3E"
Content-Disposition: inline
In-Reply-To: <CADQ2G_Fvyyh6-foswczkQgX54rH6oH-m8xyS6Qp2yS6D5L4Q9A@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--96YOpH+ONegL0A3E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!


> Is this for phone, btw? If so, which one?
>=20
> Yes it is. And it's for many many phones actually. I have done this
> mainly for SONY phones (Xperia 10, 10 Plus, XA2, XA2 Plus, XA2 Ultra).
> All of them use these drivers for generating the PWM and controlling the =
LEDs.
>=20
> P.S resending because i sent it as HTML apparently.

First copy was ok. Second had broken formatting. Both were plaintext
AFAICT.

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--96YOpH+ONegL0A3E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl8bYZQACgkQMOfwapXb+vLsigCZAegyUZmUYLlkOXpIXSjgvZv3
MUEAn0zcsdT3dAjeirzxMJDFXUj8KdV9
=e8sU
-----END PGP SIGNATURE-----

--96YOpH+ONegL0A3E--
