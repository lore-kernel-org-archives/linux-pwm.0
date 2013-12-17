From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] backlight: pwm_bl: Remove error message upon
 devm_kzalloc() failure
Date: Tue, 17 Dec 2013 10:34:16 +0100
Message-ID: <20131217093415.GC13823@ulmo.nvidia.com>
References: <1385910243-4625-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eHhjakXzOLJAF9wJ"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-bk0-f43.google.com ([209.85.214.43]:33189 "EHLO
	mail-bk0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751790Ab3LQJfm (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 17 Dec 2013 04:35:42 -0500
Received: by mail-bk0-f43.google.com with SMTP id mz12so2696861bkb.2
        for <linux-pwm@vger.kernel.org>; Tue, 17 Dec 2013 01:35:41 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1385910243-4625-1-git-send-email-festevam@gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: jg1.han@samsung.com, linux-pwm@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>


--eHhjakXzOLJAF9wJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 01, 2013 at 01:04:03PM -0200, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
>=20
> No need to have a specific OOM message, since there is generic MM out of =
memory
> message in place.
>=20
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  drivers/video/backlight/pwm_bl.c | 1 -
>  1 file changed, 1 deletion(-)

Applied, thanks.

Thierry

--eHhjakXzOLJAF9wJ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSsBqXAAoJEN0jrNd/PrOhNXsP/16VXjHxMT1f8eF3WDTwxBEq
f376Yn4+26lJTC/DXYOLXfJZh5KCF5OEZ7XKmhJDgl21SKWTdxAhqFc+xpk6Mh1m
qaRHvq38HmxbgI+ERZOMtvg7av3cPMoEwPQcBo6VQ/6K69/0dmzfqcBs+JGLrX41
ihVKO8LBQL1o72Pd+amQR98fkvureNBmTDPHComwuz3rUbe8j7px2x2Zm1vsw8Za
d+Sd8c1syfYvlQ5LBm7q0DF5W8uXfEeM4rtotTpKZ3I3kRe3yz6ODmasbTHczJc0
zqzbkHWI9qq0M4jhMW0JUYacNj4eVxmUZIRRfG4ioaSlNXVE44JzCFH06U2rkBZ7
iOYp1ZIEcnyZE6JxrT7DQYOoGiHse5oyM3ehKzJJU9ODT4/whfjY+23kkDyCuoI2
pofBtTF1MfzADTijFQJahv91WxiMlBf0Y0gsey1o57ucnF79HYillFZ0Xe88oUlC
a/pZ2vccqEVwOJkQbqZFST0s1jwN8P7e6ScJOiE0lfOL1VGB7zID4rMWc3aZ7WGG
iP4q7EXj6gJ51xwbACCisR0o6mBEJlt0oTww9dZffRkrvV3aQ2YAT6F6aR0lrems
fNnqfVl2J3DEsCwfBtlwYjX69Qeeg0WHySQjpxtPU1BpLdgqpDpO8yvRTZ7BaSPS
jwb3X/2RCQ643hlj7AZz
=AN46
-----END PGP SIGNATURE-----

--eHhjakXzOLJAF9wJ--
