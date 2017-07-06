From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] pwm: pwm-hibvt: constify hibvt_pwm_ops
Date: Thu, 6 Jul 2017 08:41:32 +0200
Message-ID: <20170706064132.GF16144@ulmo.fritz.box>
References: <fc61e98b728dd0e9179409c4369e5f4d1f5d7f08.1497346829.git.arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yRA+Bmk8aPhU85Qt"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wr0-f177.google.com ([209.85.128.177]:33411 "EHLO
        mail-wr0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753059AbdGFGlg (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 6 Jul 2017 02:41:36 -0400
Content-Disposition: inline
In-Reply-To: <fc61e98b728dd0e9179409c4369e5f4d1f5d7f08.1497346829.git.arvind.yadav.cs@gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org


--yRA+Bmk8aPhU85Qt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 13, 2017 at 03:26:41PM +0530, Arvind Yadav wrote:
> File size before:
>    text	   data	    bss	    dec	    hex	filename
>    1510	    296	      0	   1806	    70e	drivers/pwm/pwm-hibvt.o
> File size After adding 'const':
>    text	   data	    bss	    dec	    hex	filename
>    1606	    192	      0	   1798	    706	drivers/pwm/pwm-hibvt.o
>=20
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> ---
>  drivers/pwm/pwm-hibvt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

Thierry

--yRA+Bmk8aPhU85Qt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlld25wACgkQ3SOs138+
s6GdBRAAr1f8s4OEBRfWzZBp7bhjGzwJhQVQ0ghQkP8QreJNBeijlpLunLVqRk9T
WOGUrv/DiGcv9HsCJbhto1fPnfzurG7iowft61nIcArSt8hAtiMBmMmtEhX8jKqS
BcNAwdxHlYiHm5qq5UGgtZkwEj6/h8hWHNzrltQ/R5c2KaUQ1nbi2PCaOVfdWIy5
aeT3c2sBs1TXn4OsVWLgkcL8/6m7/3FnIY0xFfU+4JJO/dLoKUN2mJeGusa7M/pN
gJPvkvttYn4j5rWjGbU3afUSZkBwBq0ZoCJPihBCn/DQmWCEB0HQYIU44xFsd/Uu
GWLYxptePKF5hS/WjpqpzSa6Z+MCpTtdacz1yYUFdp38icJVRyL88jOuZjqJ6Q8s
N7YX4a8F/A9beZDKTd4Sw9lSsT84uKbpCAHCM2jnf+6WRIB8DlsYHbGDwU52pFtT
9iCSSXigjaHR9PStwqL3kOtEm3ns6AGIunx0YpaFce7t8ehnDZSblYTpJnvTNzdb
9eszjPZDdObFajTyFcKFfyM4PxPwieJJI4IueyJCVrbSgv/z7KjsHbdSQeKzgbaC
XkYm+nMajfcDv+hTUvt63T9+XHXFova2FMvlW6EL//gfk4lUT0Tqv1ylgWU6wxPf
dZZh3akJD68Ov0PbOU8JqM6Ik3J4qI1BLkqaYDHDicG+k74BIcQ=
=hkb6
-----END PGP SIGNATURE-----

--yRA+Bmk8aPhU85Qt--
