Return-Path: <SRS0=eTc7=BE=vger.kernel.org=linux-pwm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D11A8C433E1
	for <linux-pwm@archiver.kernel.org>; Sat, 25 Jul 2020 15:24:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1DE12070C
	for <linux-pwm@archiver.kernel.org>; Sat, 25 Jul 2020 15:24:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbgGYPYq (ORCPT <rfc822;linux-pwm@archiver.kernel.org>);
        Sat, 25 Jul 2020 11:24:46 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:47896 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbgGYPYq (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 25 Jul 2020 11:24:46 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 4F5B11C0BD2; Sat, 25 Jul 2020 17:24:43 +0200 (CEST)
Date:   Sat, 25 Jul 2020 17:24:42 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Martin Botka <martin.botka1@gmail.com>
Cc:     Fenglin Wu <fenglinw@codeaurora.org>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Dan Murphy <dmurphy@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH RFC 2/6] pwm: core: Add option to config PWM duty/period
 with u64 data length
Message-ID: <20200725152442.GA11424@duo.ucw.cz>
References: <20200724213659.273599-1-martin.botka1@gmail.com>
 <20200724213659.273599-3-martin.botka1@gmail.com>
 <CADQ2G_G7N_iH523urk3wOieZ0bT7O88Vnnbq6r_h9A4GLXQ5Nw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="k+w/mQv8wyuph6w0"
Content-Disposition: inline
In-Reply-To: <CADQ2G_G7N_iH523urk3wOieZ0bT7O88Vnnbq6r_h9A4GLXQ5Nw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> As can be seen this divides llu by llu in few warnings and error.
> At the time of sending i didn't realize it but this fails on 32 bit
> architectures.
>=20
> So i would like to ask how would you like this fixed ?
> Using macro or some other way ?

+#include <linux/math64.h>
-               gain_q23 =3D (gain_q23 * dmic->boost_gain) / 100;
+               gain_q23 =3D div_u64(gain_q23 * dmic->boost_gain, 100);

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--k+w/mQv8wyuph6w0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXxxOugAKCRAw5/Bqldv6
8i+SAJsEPcpEXMXcXh7cBUWfS4Ko7dvrYQCgr4NcRn/9JcdCCshgcyzI18+MxHg=
=QIaD
-----END PGP SIGNATURE-----

--k+w/mQv8wyuph6w0--
