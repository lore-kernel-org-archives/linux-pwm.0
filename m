From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] pwm: Fix possible ZERO_SIZE_PTR pointer dereferencing
 error.
Date: Mon, 25 Aug 2014 14:38:42 +0200
Message-ID: <20140825123841.GF4163@ulmo.nvidia.com>
References: <1408352924-19122-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Wb5NtZlyOqqy58h0"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:47492 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755476AbaHYMix (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 25 Aug 2014 08:38:53 -0400
Received: by mail-pa0-f50.google.com with SMTP id et14so21216715pad.9
        for <linux-pwm@vger.kernel.org>; Mon, 25 Aug 2014 05:38:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1408352924-19122-1-git-send-email-Li.Xiubo@freescale.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Xiubo Li <Li.Xiubo@freescale.com>
Cc: linux-pwm@vger.kernel.org


--Wb5NtZlyOqqy58h0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 18, 2014 at 05:08:44PM +0800, Xiubo Li wrote:
> Since we cannot make sure the 'chip->npwm' will always be none zero here,
> and then if either equal to zero, the kzalloc() will return ZERO_SIZE_PTR,
> which equals to ((void *)16).
>=20
> So this patch fix this with just doing the zero check before calling kzal=
loc().
>=20
> Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
> ---
>  drivers/pwm/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

Thierry

--Wb5NtZlyOqqy58h0
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT+y5RAAoJEN0jrNd/PrOhRr8P/29XBFv+mgZbvqWGnjDP5FXU
EFPgvcfEnijOjWdCYs6+EJc86R5WxWjHtC0HnkSaTu0eK4CbIa7P8z+upacCAeO8
8/f/PI6nZ15XJegVoRzoIQEJrSX3Oqd9NOCZf3eQ42gyGsookjb1yO89COBbqHMc
aVkLfH1LVwEDQobl6azhQVy1A0jt53IlWnhRod0LrMlS4BozU4sKG6sPjuTp1/Pe
hZAZEahBn5DuAZAvkmS9EICSrJnDpbX9YpSNstAKVXqiL0Pa15oKXkN4MBLA+t/W
K0JfS20Ph4L3FKenXjl6sjyi41MImlN5RcQdYBPZlk5DG86+Hr4sky+xj/OGgdWY
mcThR40Egf51TjFpQzuLBUZsS/0D3Pe4/bn8Ypx0Gbmi+O2kBuvL0hnyL2JbiqtF
PcDDODXr/km72S2hU38FV+r+ptvSfCg/Lr45+8eFVDMaZcxsIrAoz1rm5rbpg33Q
m4YgCSSIPmLXpLVO7h1qU4EHw3tR6u8UT43svCVz3FtKwBDMybSFJCY5aTiGKmnj
HlB6pmVASJBVWF3VnU4QDKnPD6O0rRp6gyyVnbGhfiYWofjQoxJ7GeXoW4tQG3uV
pEkJLF1wmHNYAhKugjBmLLwGkbIxBeIpPQrFDqLKsFDy35zHRm58MKcQHb1yVtet
qyBYwVFDPDXrgPkU93Ny
=Tkwl
-----END PGP SIGNATURE-----

--Wb5NtZlyOqqy58h0--
