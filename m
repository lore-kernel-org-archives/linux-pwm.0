From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v4 2/2] Add PWM fan controller driver for LGM SoC
Date: Tue, 14 Jul 2020 09:18:10 +0200
Message-ID: <20200714071810.2gfrot2zupal2cn6@pengutronix.de>
References: <cover.1593503228.git.rahul.tanwar@linux.intel.com>
 <a74b18b68f26bf902c30a017050cc4ea070da887.1593503228.git.rahul.tanwar@linux.intel.com>
 <20200713191059.zsokzvv3k2hyaxcl@pengutronix.de>
 <3e0623c7-45cd-ea60-bae3-a03d991e98bf@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jnvegtj3xe6kqzyc"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbgGNHSS (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 14 Jul 2020 03:18:18 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B65A8C061755
        for <linux-pwm@vger.kernel.org>; Tue, 14 Jul 2020 00:18:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <3e0623c7-45cd-ea60-bae3-a03d991e98bf@linux.intel.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: "Tanwar, Rahul" <rahul.tanwar@linux.intel.com>
Cc: linux-pwm@vger.kernel.org, thierry.reding@gmail.com, p.zabel@pengutronix.de, robh+dt@kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, andriy.shevchenko@intel.com, songjun.Wu@intel.com, cheol.yong.kim@intel.com, qi-ming.wu@intel.com, rahul.tanwar.linux@gmail.com


--jnvegtj3xe6kqzyc
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Rahul,

On Tue, Jul 14, 2020 at 01:35:14PM +0800, Tanwar, Rahul wrote:
> On 14/7/2020 3:10 am, Uwe Kleine-K=F6nig wrote:
> > On Tue, Jun 30, 2020 at 03:55:32PM +0800, Rahul Tanwar wrote:
> Given the fact that this is a dedicated PWM fan controller with no other
> PWM consumer, do you think that this driver belongs to drivers/hwmon
> instead of drivers/pwm? Thanks.

If you implement the PWM API it belongs to drivers/pwm I'd say. (There
are some "mixed" drivers that implement both GPIO and PWM that live in
drivers/gpio, but if the support can be separated in a sane way, such
mixing isn't welcome.)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--jnvegtj3xe6kqzyc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl8NXC8ACgkQwfwUeK3K
7AkJRAgAmcJGk/pxe7g+BgNi4Tv+KWmis2yCmOnhRXpFv9JQkUcsBvi4O1t9ovuy
P4BFh3rnYA6ks22ovydf5Smi08NCw6jgN678gNRIH6lLnfisjFwVbV77QWeIaDMW
Ny3u3K6a5uA50VR15dLQk3gnKgICi/LqO0KaShsIYziuGajj2HfnFFIgh62n2+oK
Qa+rHu6vKNnhiKC1YA+DtczgT9HEG1S17F98DL7QNQlJ4FYT/gxrhL0mMC2Y1SZO
ZDP2UY6tILSfcgPoDXjd09B89FVhlJOl0Qaa5dz0aVniYjE0YMfvrQ5ZQIGF2YuF
2Z7mWdfi1Yv5/KNyGxY7gg7lEMH9qQ==
=gZ+y
-----END PGP SIGNATURE-----

--jnvegtj3xe6kqzyc--
