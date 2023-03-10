Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AEDFC6FA99
	for <linux-pwm@archiver.kernel.org>; Fri, 10 Mar 2023 17:48:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbjCJRsO (ORCPT <rfc822;linux-pwm@archiver.kernel.org>);
        Fri, 10 Mar 2023 12:48:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjCJRsL (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 10 Mar 2023 12:48:11 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A932112A45
        for <linux-pwm@vger.kernel.org>; Fri, 10 Mar 2023 09:47:34 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pagpu-0001C0-Cw; Fri, 10 Mar 2023 18:47:22 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pagpt-003E2D-6v; Fri, 10 Mar 2023 18:47:21 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pagps-003r3v-BX; Fri, 10 Mar 2023 18:47:20 +0100
Date:   Fri, 10 Mar 2023 18:47:19 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Alexander Stein <alexander.stein@ew.tq-group.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/1] dt-bindings: pwm: imx: add i.MX8QXP compatible
Message-ID: <20230310174719.ep2acqi3re2sywaw@pengutronix.de>
References: <20230131143720.3250427-1-alexander.stein@ew.tq-group.com>
 <99de0305-7519-5c21-d1fc-0886f594ce99@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kspkv3oa7ylpibqs"
Content-Disposition: inline
In-Reply-To: <99de0305-7519-5c21-d1fc-0886f594ce99@linaro.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--kspkv3oa7ylpibqs
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 31, 2023 at 07:55:50PM +0100, Krzysztof Kozlowski wrote:
> On 31/01/2023 15:37, Alexander Stein wrote:
> > i.MX8QXP compatible is missing in the list, add it.
> >=20
> > Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> > ---
> >  Documentation/devicetree/bindings/pwm/imx-pwm.yaml | 1 +
>=20
> Where is the user of this compatible?

Because of that feedback I marked the patch as 'changes requested' in
the PWM patchwork instance. Please wail if I missed something (i.e. that
there is a user in the meantime).

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--kspkv3oa7ylpibqs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmQLbSQACgkQwfwUeK3K
7An8iwf/dF5ukF+mooO/g9PnYzaN1GBczGY8t1p0e+3iBtXFFRDkejROGkCE3/mB
096p9I3g5EYDjJzJMmzWR3JJYkOKDdacLi1fTl69WNij52C9L7lb5zC1bm7Net7t
qMBI8chino2qIBBM/fPhVW/OCVvr9wW0q9hElRMl6QpUYSuPXhb2pAFVcivjox5A
SbyMhI/T5mEczE3Z9Wm9ja/HI+g4GiAjSrbifAETAb5g5e49tEN388gZ3J0kGNPw
yCxfcLXKCn7KhR8uhY1yoi9CngrzNjgR+7TYBVt5b5TdUzlkNxWVEJ9y0qCFIyDD
U1x/JFewS3qdxBXNhKSly2auE/eNug==
=37MT
-----END PGP SIGNATURE-----

--kspkv3oa7ylpibqs--
