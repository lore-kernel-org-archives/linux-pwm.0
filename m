From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v2 2/2] Add PWM fan controller driver for LGM SoC
Date: Fri, 19 Jun 2020 08:29:13 +0200
Message-ID: <20200619062913.ynpcue3rsyk66i5g@taurus.defre.kleine-koenig.org>
References: <cover.1592474693.git.rahul.tanwar@linux.intel.com>
 <79fefda4aad5ebeb368129375bf128b74ed12224.1592474693.git.rahul.tanwar@linux.intel.com>
 <20200619060213.ldvun5y4tgnz55hh@taurus.defre.kleine-koenig.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zcja3pmebqldofsq"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbgFSG3S (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 19 Jun 2020 02:29:18 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC153C06174E
        for <linux-pwm@vger.kernel.org>; Thu, 18 Jun 2020 23:29:17 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20200619060213.ldvun5y4tgnz55hh@taurus.defre.kleine-koenig.org>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Rahul Tanwar <rahul.tanwar@linux.intel.com>
Cc: linux-pwm@vger.kernel.org, thierry.reding@gmail.com, p.zabel@pengutronix.de, robh+dt@kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, andriy.shevchenko@intel.com, songjun.Wu@intel.com, cheol.yong.kim@intel.com, qi-ming.wu@intel.com, rahul.tanwar.linux@gmail.com


--zcja3pmebqldofsq
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello again,

On Fri, Jun 19, 2020 at 08:02:13AM +0200, Uwe Kleine-K=F6nig wrote:
> You had concerns about my review feedback that I don't like the fan
> stuff in the PWM driver. I still think that the fan part doesn't belong
> here.

I suggest splitting the patch. First introduce a generic PWM driver and
in a second patch add the fan stuff. This way you can get an ack from me
at least for a part. Also it makes it more obvious that there is going
on something special and we can have a dedicated discussion about it and
a concious decision made at the end.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--zcja3pmebqldofsq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl7sWzYACgkQwfwUeK3K
7AkVtQgAiH0/d2UedzwsoLV9fKLCcPwQT24HKh/jR61f5Gl/bIWJWI2ffoaxBVSC
y+bPENDDkwaLE3hQTvOlRZvHK4rjVYw6poTUh662eHuDCDAhWSiB/vvEHS5iWSe7
HdMkjzvMsZEYvcM2Ibe3o6om3F1I0OUxnu5l3Bz6PhkVl+ATqcV1IKrzQwMAFW68
Cvz86eHBz2KeCZ+AnxJvvM8uibDnDwSxPzHVqReoR22bLJvoZ6IOzp5T95NhlDd2
MeM+5Tz29z7Wdk+VXmjAX/oQomlRYLuffxtXIhi+Ex03wEklNSFgIsC65DtSGIEm
0wszuzFBBaHS/3gIZwTVJmE/XZ9fSA==
=okrZ
-----END PGP SIGNATURE-----

--zcja3pmebqldofsq--
