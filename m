From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH] pwm: sun4i: Add support for pwm controller on sun5i SoCs
Date: Mon, 12 Oct 2015 15:49:50 +0200
Message-ID: <20151012134950.GC2278@lukather>
References: <1444556997-28885-1-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nQHD+3g9yI+EYXJy"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:39330 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752715AbbJLNtw (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 12 Oct 2015 09:49:52 -0400
Content-Disposition: inline
In-Reply-To: <1444556997-28885-1-git-send-email-hdegoede@redhat.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree <devicetree@vger.kernel.org>


--nQHD+3g9yI+EYXJy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 11, 2015 at 11:49:57AM +0200, Hans de Goede wrote:
> The pwm controller on sun5i SoCs is identical to the one found on sun7i
> SoCs. On the A13 package only one of the 2 pins is routed to the outside,
> so only advertise one pwm there.
>=20
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Thanks!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--nQHD+3g9yI+EYXJy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWG7p+AAoJEBx+YmzsjxAg6/4P/25siYK1ZyOPuPqmhrTeEut6
bTag43mH9d6J8k8d04IZaMnoXRjuBbJ07wBNUiD3+YPoxMeUmymlX5nITXkDQSCb
9nezzIvVr8WvO91KexO4DS5Zv63vHKEWEHfld88kjmVOOYa6R3ER1/dKtCrEZABs
7Kbe/+LiLO8NLefHFqghbXD6FD6JzCZbEOq0y9mVO6Zdm09MayA7JKZB/H+GSemT
vvHtwBE8owexBQP948YQ8Pj+ZduZ+lovwdwyQe2BwK0e897c5Zyws46t6zm0H2nM
dspOv8HB4r2NsaRBvihNXxctriXAygF8kkJKQQXPrLokinIP+aX8UxcYZeNXpQwD
EFKcbpudqC1lhLTWO53OvolMG0Jv3eNAyT8rNaLn2tH2JWDrm3tAV6UmZL72SBL3
CrQWboVpV/e39jxzFJR8CtnkAYoqUQ8jzDteCARuY43TyvMT1e+8++qz4pEnNvFl
JQtunbbduRL7GnRunmPhT8a6T9v0iBoWoYRnBE3/34Sve04ft4YcFqiShuC0+o+x
vD7kER9bXahKf900cESiXP0fBKEdd8TTDj7cCY+aVwHI2oJRcMlZ5DBaAyCheZHA
mpN14egDMlAQMgplN4oPOyx4Pf/QgbzqepULXHFyY1NzN6KAp368Q/VpxVtbJvMb
Z/DAhpLvyorAxHouKOHc
=zz7+
-----END PGP SIGNATURE-----

--nQHD+3g9yI+EYXJy--
