From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2] pwm: pxa: Use of_match_ptr()
Date: Fri, 4 Apr 2014 10:49:21 +0200
Message-ID: <20140404084920.GB474@ulmo>
References: <000d01cf4eef$13881770$3a984650$%han@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+pHx0qQiF2pBVqBT"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:61861 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751655AbaDDIuG (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 4 Apr 2014 04:50:06 -0400
Received: by mail-bk0-f46.google.com with SMTP id v15so256195bkz.5
        for <linux-pwm@vger.kernel.org>; Fri, 04 Apr 2014 01:50:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <000d01cf4eef$13881770$3a984650$%han@samsung.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Jingoo Han <jg1.han@samsung.com>
Cc: linux-pwm@vger.kernel.org, 'Eric Miao' <eric.y.miao@gmail.com>


--+pHx0qQiF2pBVqBT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 03, 2014 at 12:44:54PM +0900, Jingoo Han wrote:
> Use of_match_ptr(), because of_match_ptr() returns NULL pointer
> when CONFIG_OF is disabled.
>=20
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> ---
> Changes since v1:
> - Add of_match_ptr() to of_match_device() in order to fix compile error
>   when CONFIG_OF=3Dn.
>=20
>  drivers/pwm/pwm-pxa.c |    7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)

I already fixed this in the PWM tree before submitting the 3.15 pull
request. What I did was rather revert the original patch because given
the use in pxa_pwm_get_id_dt() there isn't any real advantages to using
of_match_ptr() anymore.

Thierry

--+pHx0qQiF2pBVqBT
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTPnIQAAoJEN0jrNd/PrOhe0oQAJxC2+SFVxAjndbMM1sUzhZS
F/6KHlu1v4vw/Oe5hA0sQPh18Tmxep8snwlxgbeQ9TKgLvVL4oT6DOv8xtL2l6Kf
J4+2sWI8Bz2eueMKY9uVmNohNU3LDHLuThhpZRMOzn9uHx4h3cjdjXZuMxiWBKfI
tLaQ48IIkQzIHjDiPsU3SAaqNbjmn04waaTfOrjkOKpmrH6Edf7tI9KXrwdqJLxN
RkTat31b2yONxfaMO2Z6jM9WwySsmtJtRRFMHr1XNuPs++6ghzOkKaAUx6yAYb4j
X+/JV49CODNCaEoEzINFCcuVC5DSRLCnJjrkM40rBMvBHnZTN0Kpiizm+87zaG7m
CSeiBbWBrTNiNVuFA52P02Bg9rSHVdvsdpRyifTqYfZNSC51xQka6BoSVw0BgFca
w5eFLX8W6jolqI/vN4Vb0lH0c1+2foWXCiMx7bWQRpsJrtXNUMDZr+qhS7HkzsNB
x3beg/uoJto1+iFr8sW7gTGQngzJq4VdwWaAFKLZtfn+vV+z9reuJl0JfY8hOh4c
Q6B79biykucWw2w+TW7a/ysNVqrupAiPb/S0OX22ACNzgXIbumKFbC9dCCaQlgc7
5KgCM2AoGXoV+8dDKXJqT/ZT9ShQ8R1GFp8Zx0Xpf4V/zT0kgh598P1R1xjSG205
OG7dLK1i6O7JuQlZBYrV
=rydn
-----END PGP SIGNATURE-----

--+pHx0qQiF2pBVqBT--
