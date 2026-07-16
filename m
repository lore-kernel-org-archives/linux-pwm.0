Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99FD03E00B0;
	Thu, 16 Jul 2026 08:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784190561; cv=none; b=oZn0kip719U8Tmxz3GgeTXU3NzCLZZ37qfbpuJHNHpucl7sGJ4qMV0OqjK6WKuy/9jvnOEeWQEmyLmk1m70fF5dAWCvfNCXuJe1Af81fxrt2qWbzDELqM6/6QP/wqHSy2Iy5l91OOAXpXfhqfpsWTp88YLhe5V6dp60+nS8VxRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784190561; c=relaxed/simple;
	bh=0p9UM3hekDNMYg0UvNkcMP9B+zlbNR3iFqruhihgdR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yspkdq/TEEpS3RJEqKaJ+gt/P5fVP8tDosULcjT1HdwZuogb4zXe4VpCdr4J54qxnjXAvACkKaBd8aAewFOu70blIOfzOW/roM5XYL2l6Rc4t/EBib0kmXMWlEPHIftikvASmhZ16z/VK54JmHSTgtpIBEFbGVbtLX3q4TO3S5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oooHe8CH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oooHe8CH"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id A0D1D1F000E9;
	Thu, 16 Jul 2026 08:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784190560;
	bh=0p9UM3hekDNMYg0UvNkcMP9B+zlbNR3iFqruhihgdR4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oooHe8CHZt1nCjmXOjPTVVZ4Ov+8pql5xOK1SJ7aAyDcLNsyHZvUcU2XkPVqOnuVl
	 oV6D48cyELDRoFkgJKQ1nxOrnfUskJPX8FD5ekK1ND/ORFPOGhiVfkvsdXqErSDJv2
	 CNVfemy1jljcFl6FtQ3SqI+wJtt/YKAnP17xbW8Fa+wxiIa9MzMcFckVezkrbaba2Z
	 6A6FArKl528YNYhWa3cER76PVBL3UEBLkdXv8vjz2D0oxDV3BEKNjc/JdVfCcP0iVS
	 HKYqmrQKwnyRhebBpBJYvZo/cVFRCRLzum4WBb0SySjMD3wdcD11SCOok/xoPmxGJ2
	 oubV9ZlE0Wjyw==
Date: Thu, 16 Jul 2026 10:29:17 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Biju <biju.das.au@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>, linux-pwm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v6 05/11] pwm: rzg2l-gpt: Drop unused rzg2l_gpt_chip
 parameter from rzg2l_gpt_calculate_prescale()
Message-ID: <aliV9kNpREmcPbCV@monoceros>
References: <20260604095647.108654-1-biju.das.jz@bp.renesas.com>
 <20260604095647.108654-6-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fdhkxks7nfme7w7l"
Content-Disposition: inline
In-Reply-To: <20260604095647.108654-6-biju.das.jz@bp.renesas.com>


--fdhkxks7nfme7w7l
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v6 05/11] pwm: rzg2l-gpt: Drop unused rzg2l_gpt_chip
 parameter from rzg2l_gpt_calculate_prescale()
MIME-Version: 1.0

On Thu, Jun 04, 2026 at 10:56:35AM +0100, Biju wrote:
> From: Biju Das <biju.das.jz@bp.renesas.com>
>=20
> The rzg2l_gpt parameter was passed to rzg2l_gpt_calculate_prescale() but
> never used inside the function. Remove it and update the sole call site
> accordingly.
>=20
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Applied that one to

https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for-=
next

Thanks
Uwe

--fdhkxks7nfme7w7l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmpYllsACgkQj4D7WH0S
/k5TbAf9EqYBQbI5h7W09bZp5lYMkAl42Fmajm0+c5JE+ij3OsTTT6F5nDEhuMbo
6CKsMD83LSqMVdFwilASsS5JpTQkA+D06YmSzfqKnqIxsTZYjXV3vU2GG5uv4sfB
9P0G8qG9iBy1wb7SFmmsrNpZimwLySvvFFFhA4If4TtDhNldFlLImwNiLaPYiHxz
r+6zYWRSOGjdmLTz5mjEta47uP7qQdkwm3eOfMFzPmtj1wlvgpYoBD8yEEi7WxS6
0Av3MkriIakU8G9ii2xLcSg9+cD8UR+7k+Vzo3NAbmkx+SbunVCAU4ygjPw+V4G1
LIom28hjonJo7eQBpbagOJiv2gD5xQ==
=l50w
-----END PGP SIGNATURE-----

--fdhkxks7nfme7w7l--
