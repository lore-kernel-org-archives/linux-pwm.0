From: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <uwe@kleine-koenig.org>
Subject: Re: [PATCH] ARM: dts: imx: default to #pwm-cells = <3> in the SoC
 dtsi files
Date: Thu, 9 Jul 2020 20:59:54 +0200
Message-ID: <9cbe6c13-4923-af99-d10e-b53a92141e27@kleine-koenig.org>
References: <20200709144527.23528-1-uwe@kleine-koenig.org>
 <CAM9ZRVt8V9mPwAtQ3pvPqGc-Zuxs-SkcoSNk49JipwvERByGdw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="pNdbZ0eN0hHWwqCHlPF8ZiqS3ciMA49DX"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbgGITAG (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 9 Jul 2020 15:00:06 -0400
Received: from antares.kleine-koenig.org (antares.kleine-koenig.org [IPv6:2a01:4f8:c0c:3a97::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9FC1C08C5CE
        for <linux-pwm@vger.kernel.org>; Thu,  9 Jul 2020 12:00:05 -0700 (PDT)
In-Reply-To: <CAM9ZRVt8V9mPwAtQ3pvPqGc-Zuxs-SkcoSNk49JipwvERByGdw@mail.gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Paul Barker <pbarker@konsulko.com>
Cc: Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org, linux-pwm@vger.kernel.org, Matt Ranostay <matt.ranostay@konsulko.com>, Pantelis Antoniou <pantelis.antoniou@konsulko.com>, Thierry Reding <thierry.reding@gmail.com>, kernel@pengutronix.de, =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pNdbZ0eN0hHWwqCHlPF8ZiqS3ciMA49DX
Content-Type: multipart/mixed; boundary="3SNSUA0LWMXjfkHJvHGM5rfiWhGXG9lnR";
 protected-headers="v1"
From: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <uwe@kleine-koenig.org>
To: Paul Barker <pbarker@konsulko.com>
Cc: Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
 linux-pwm@vger.kernel.org, Matt Ranostay <matt.ranostay@konsulko.com>,
 Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
 Thierry Reding <thierry.reding@gmail.com>, kernel@pengutronix.de,
 =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Message-ID: <9cbe6c13-4923-af99-d10e-b53a92141e27@kleine-koenig.org>
Subject: Re: [PATCH] ARM: dts: imx: default to #pwm-cells = <3> in the SoC
 dtsi files
References: <20200709144527.23528-1-uwe@kleine-koenig.org>
 <CAM9ZRVt8V9mPwAtQ3pvPqGc-Zuxs-SkcoSNk49JipwvERByGdw@mail.gmail.com>
In-Reply-To: <CAM9ZRVt8V9mPwAtQ3pvPqGc-Zuxs-SkcoSNk49JipwvERByGdw@mail.gmail.com>

--3SNSUA0LWMXjfkHJvHGM5rfiWhGXG9lnR
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hello Paul,

On 7/9/20 7:30 PM, Paul Barker wrote:
> Thanks for picking this up Uwe, I must admit it fell off my todo list
> due to the coronavirus situation.

That's fine, I won't send an invoice :-)

> Is there a reason why imx23.dtsi, imx28.dtsi and imx51.dtsi have not
> been changed?

imx23 and imx28 were not converted as they are for a different driver.
imx51 I somehow missed ...

Will send a v2 later including imx51.

Best regards and thanks for you taking a look,
Uwe



--3SNSUA0LWMXjfkHJvHGM5rfiWhGXG9lnR--

--pNdbZ0eN0hHWwqCHlPF8ZiqS3ciMA49DX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl8HaS0ACgkQwfwUeK3K
7AlSAwgAgDWRXiCvzVPWdl99QfB6xz4iJbDUk8kryAE9lAPK9a/ZUwwbys5SAr7+
sALdalC5iy7vyzkr7jPODMIXtwS6UlrOi9MYi208OjLp4IagO7bDDisqyA8xujo8
q+V9GtATIUMC7/LROWWKpGMkyo3STVbNX9sRnuZNlZD+uQHettUW0VWwKWxMw54S
Bilnhhe4tbiDbIbhovs/v2he9Uv3CjGR72SWC3wN3sgA689rtrwGGW7Ed1esEkB/
EsKJdDm7ivLKjJCzWVhucDAz1O85XzbWV5yyXZRJqwRyd6Y63YBo5gdxM7Pj089F
zaBgD3Eyn6HkIoBqRrIUaITRBhUyLg==
=yP7J
-----END PGP SIGNATURE-----

--pNdbZ0eN0hHWwqCHlPF8ZiqS3ciMA49DX--
