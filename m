Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795771689;
	b=qn/dqap8kUACKICilEf07oMvLWPAC3556RHRMa48BxsLwGWka5AAIbFZ5fSm3wKuJ8JJ
	 0Wj8+FjMxTH/qtqVYWF4GtuMYfCXaKwT4PZnG2lgYEhIys4c07B++pmc+3YZps1XTsHRl
	 wybSledh1l1c60cpaDRF0BOdyOmFa8dl4XaYoc32lzqAF8IgvsLAK/VE+KLkW0iQNFTBH
	 rtEnnqc9OfHyLD3CHRSEE813d3pRUmO8kisclFSUJtjF15Fb0yXU4gsBM7rh9mtG+WwJ8
	 HPN7oMSk/qBFN8Eb+kNox5k7x2o3DizkCYK1231n94cptdY5K4x/ogZsBHMT3yiS5rQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795771689;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=0sl6GQdvl1PXJoCjyLC2MYdFK0R3lhNpJlTKVoZXQR4=;
	b=GbDc9cY5Kx9y7NA/tbM2a+zKkWUt5cKVA8ehrXzeNLLU2x2TlFxc7g1s9kSfe3uc4oGx
	 T2dR3U3cBW37LLsKxHH1ppnBApZNav+AT9+Cr0xjmm1kwoOoz9eFLw1j6nLXeKTNBprme
	 mFscBzma8h1U21YQiGunBPlsaLbKYTI9TmHtnOldy0eFE2PwhNDHMRdQmCmwJbswsyLxD
	 xmmaQpHDfjhg/aLytEuREDIAxjSQI6GWuI4jWX1bIWu58euznSvr8iSjbJGGE9FNf3HDt
	 OCR67zYyoB9dSb3VjlW1RYfZKCdCa6AlNLKppKYQrfQl1hyPph9woktSnikQcptF4bQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zpf+01Eg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id D877E606A31C;
	Fri, 27 Nov 2026 09:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zpf+01Eg
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 73A6E1F00899;
	Fri, 27 Nov 2026 09:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795771689;
	bh=0sl6GQdvl1PXJoCjyLC2MYdFK0R3lhNpJlTKVoZXQR4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Zpf+01EgyzkiAUUkfYtFx1WrcyIDjOuKOWlaSDX8gabh8G7vod2PGJwLCZyw1KPrV
	 yrK7UUuXBpMn27E6UJ1UPEgoCvgVS8jb0wIGzWAG92J8cHnm/YTuAhkAw6EZZclbH3
	 V2Bcbxabu/LZ9GficdCTvpu+MCqvY3MjAOITVUDIJE5Ui6O7vWxV9jPLNQ8hYP4E4t
	 UJYVKNhixRHZ00kdlWlP6n4qjKefVXaCDJ7WBoQv/pDbdq0pi0OfyNy9xbBd+dn5pA
	 zktqAYzwM5Y2+TuX498LPqvVSvdle86XPPJ0m0Gw5nbSwliNjB+AeO407IemxoYZ3j
	 LPtOHj4K1FckA==
Date: Fri, 27 Nov 2026 10:28:06 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Priya Bala Govindasamy <pgovind2@uci.edu>
Cc: Michal Wilczynski <m.wilczynski@samsung.com>, ojeda@kernel.org, 
	boqun@kernel.org, gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org, 
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu, dakr@kernel.org, 
	daniel.almeida@collabora.com, tamird@kernel.org, acourbot@nvidia.com, work@onurozkan.dev, 
	elle@weathered-steel.dev, linux-pwm@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	ardalan@uci.edu, zhiyunq@cs.ucr.edu, dzueck@uci.edu
Subject: Re: [PATCH 1/1] rust: pwm: reject over-aligned driver data in
 `Chip::new()`
Message-ID: <awlMukHhET0ALF2j@monoceros>
References: <cover.1794600927.git.pgovind2@uci.edu>
 <CGME20261113202542eucas1p27ba92593376041c476afa9c5286205cf@eucas1p2.samsung.com>
 <caddec5478a0d39a73152247a60bc21b3c609cc7.1794600927.git.pgovind2@uci.edu>
 <9ee41556-4a24-47b2-9db3-9665048658eb@samsung.com>
 <CAPPBnEbnBPsYxE5ZXPkhGfueMoYD6DAH7dDrR=wRcq_mD686fg@mail.gmail.com>
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Post: <mailto:linux-pwm@vger.kernel.org>
List-Help: <mailto:linux-pwm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pwm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tafrygdzirvhmnen"
Content-Disposition: inline
In-Reply-To: <CAPPBnEbnBPsYxE5ZXPkhGfueMoYD6DAH7dDrR=wRcq_mD686fg@mail.gmail.com>


--tafrygdzirvhmnen
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/1] rust: pwm: reject over-aligned driver data in
 `Chip::new()`
MIME-Version: 1.0

Hello,

On Thu, Nov 26, 2026 at 09:38:59AM -0800, Priya Bala Govindasamy wrote:
> On Wed, Nov 25, 2026 at 7:42=E2=80=AFAM Michal Wilczynski
> <m.wilczynski@samsung.com> wrote:
> > The C layout uses PWMCHIP_ALIGN, which is private to core.c. If Uwe
> > agrees it might be a good idea to move it to include/linux/pwm.h and
> > assert against that, so the two can't drift apart.
>=20
> Thanks for your comments. As per Gary and Uwe's feedback, I will
> shorten the commit message in the v2 patch. Just to confirm, for v2
> should I only update the commit message, or also move PWMCHIP_ALIGN
> into include/linux/pwm.h?

There is precedent on a symbol that is only in include/linux/pwm.h for
Rust. So if you group PWMCHIP_ALIGN to pwmchip_release() and extend the
comment accordingly that would be ok for me.

Best regards
Uwe

--tafrygdzirvhmnen
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmsJTSMACgkQj4D7WH0S
/k4Gkgf+LUVLQfEGSoCQ6is/LBawLAmnEE/0DjLpbHle5x6PUBT56P5BM4wcnfeG
XH9yo6txd9GpkuthodMqGZQ4HkoCUwIx4GS0bbvCkgY64s4wm2PKSgg5VXYJnZAP
5HPcTlG7hWLAFAvOsJIIxctn7G+MCUSE5py77AucluAQuh6FnygljiB+07XwqxId
jGAf7oDUFSWKgZS8wN2Tdq6Ja1MsUUZ36f5WvksdCI2ixKQy6uXGRMdTYq3XZzWw
sWzouDEmOKte7azFRNQVOw3JKgUQtjcxq3KgkL7o1HLnDvRYEpr6Wn/PHrLSf7fc
TxXEy3DanwtLCkHURBF83DF95EGJug==
=U71u
-----END PGP SIGNATURE-----

--tafrygdzirvhmnen--
