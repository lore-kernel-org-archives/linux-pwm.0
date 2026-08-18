Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0E0356758;
	Tue, 18 Aug 2026 21:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787088386; cv=none; b=Gu15k50PFlUY67jCgWECh6cCHFrOO+vBZoTGf7gGxOnYM6DGvqtyFXByKJbKyvS8UJ7oQ1NlNbJXqr5puBANNOHsBsmDT5qp6tbnESt0q75GAzCV4E0YrbJEiVwxu4QdSVnEiT748rw4VHOH8K7jTmcw1f+R8Pd3jn+kazS2q/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787088386; c=relaxed/simple;
	bh=SuyMjwXFETGFChynAkpeAwy9XY2DzB5LoGagfznZ+W4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ArJ2/XMYd+g/i7xHGANLoLfsN84f6GtbpUKeh9OklB6mUHJDeo3xl534FuN27dShKj5UUVRYHJaC8Rr5nmPPcN3WVHlwjIpAaIzRwpYP9D20vOioG/sxN5u8vdPB8p/qzKRcf0IC//n8KuI4EwIX7AZPvGSDFqSnmFHWGw+DHA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RvI+8R5k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RvI+8R5k"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 625AD1F000E9;
	Tue, 18 Aug 2026 21:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787088385;
	bh=SuyMjwXFETGFChynAkpeAwy9XY2DzB5LoGagfznZ+W4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RvI+8R5k+BZBhhQpMoI2xKYFkMVpcNZKKieTAiXHVue03mKbxHiBo8iJ1GbbKZ3hb
	 gZWHjMuaH7iDJfSYZeePmN8KIEEH1UXHy/Ngdq40JsmgqfpTES7AVwhlM/eRh3Ov02
	 wpAjdIswwyejQRXComsd8JwG+/905t+RhBAwTMTeM6t2oKNAFDR9bXyf+/l69pU3JR
	 Vw//PKNvu7axbIEDhhI5GSHgEUM0oL771kqWu22S6i57iyPwwme9LQgJ0j3178qVCQ
	 vdbH46dVd97Te82BMwFqu+mzLLkhCLCRuQu7Y0pD/RYHQyQrSaDr0K2KbZy2sWQGcp
	 lUQ30Ev0DJzUw==
Date: Tue, 18 Aug 2026 23:26:21 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: Richard Genoud <richard.genoud@bootlin.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>, 
	Paul Kocialkowski <paulk@sys-base.io>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	John Stultz <jstultz@google.com>, Joao Schim <joao@schimsalabim.eu>, bigunclemax@gmail.com, 
	linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v7 2/4] pwm: sun8i: Add H616 PWM support
Message-ID: <aoTMMAGbWelnjJTo@monoceros>
References: <20260703152215.192859-1-richard.genoud@bootlin.com>
 <20260703152215.192859-3-richard.genoud@bootlin.com>
 <aoQibj7sCd6o8W6h@monoceros>
 <CADvTj4r=uBJyJdmK3T+jD_Nitg2NBs7fZgtE5p6wt9zwWgj6DQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="aspcbffde7kziapm"
Content-Disposition: inline
In-Reply-To: <CADvTj4r=uBJyJdmK3T+jD_Nitg2NBs7fZgtE5p6wt9zwWgj6DQ@mail.gmail.com>


--aspcbffde7kziapm
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v7 2/4] pwm: sun8i: Add H616 PWM support
MIME-Version: 1.0

Hello,

On Tue, Aug 18, 2026 at 08:12:43AM -0600, James Hilliard wrote:
> On Tue, Aug 18, 2026 at 5:00=E2=80=AFAM Uwe Kleine-K=C3=B6nig <ukleinek@k=
ernel.org> wrote:
> > I didn't look at Sashiko's feedback
> > (https://lore.kernel.org/all/20260703153337.B5AFF1F000E9@smtp.kernel.or=
g)
> > but I would expect that not all 9 high-severity issues identified are
> > slop. Please look through these for the next revision.
>=20
> I sent a v8 that should have fixed all the sashiko issues along with a
> bunch of other issues:
> https://lore.kernel.org/all/20260804-h616-pwm-v8-v8-0-db37ab8624ae@gmail.=
com/T/

Damn, I missed that because my usual check for newer revisions is using
the sender as key (because subjects occasionally change). You didn't
write about your patch series being coordinated with Richard, I hope it
is.

Just looking at your changelog I think most of my manual feedback still
needs addressing. Can you (or Richard?) please go through my feedback
and address the things still relevant for your v8 please?

Best regards
Uwe

--aspcbffde7kziapm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmqEzfsACgkQj4D7WH0S
/k5h0gf/aSOW4cg9TnUnoNOdZBHgY2AauDIKKspn0FUqvOvhL6QTxqE8Iz8/M9uz
vYzr30cxYHuPdzQiueRB/CGxZ01AIXbLEnPdwf4JzQrzcY8WdUHq76W2urres601
Rw/isuaFFlDLZhmGpq8hFe2aYVIdBusWqkqZ7vqDT82GrI4eMdFpD+EAVp+B6RkI
TLAaQsNpiUlv1yf/XFs2CR0urSgArnABlMBt6Bmuu8NuySY6M2WzztB45U+0S7M6
j36R+K+Qa7TtYcvGEWyx7pNL5hZXDkGgsQS9GXYU8t1pgNf7azHV1iuUbbzlj6aw
YSmgcYcxyYL9dNSN8sTKnit1vmN1Qg==
=p4iJ
-----END PGP SIGNATURE-----

--aspcbffde7kziapm--
