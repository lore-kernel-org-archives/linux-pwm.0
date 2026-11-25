Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795627950;
	b=CJvJvdnvIQkEAv6KX1g8X6U0s7OIvfkMs5lKrncmoSGRC0MCkgv3a0f11/sHFGADe6Wz
	 eAxIQYi+s5vQmYFIK1IEjoPv2ocWo6lbpKkZV6RLITAO7hCMX/MYbkiz94+yLNqYuUdpR
	 MUQh2B7n+95IvP//it2fChKysW3dJGVLAfkzQaL6lKgB72I4QUIuwRbDuN/CugNaf1UMJ
	 AA1Eu9b48qjFCUhJcIqLu7q2ySElwLcao/18yITOotCYEDItLKLh+0a1375opcAllP2YE
	 bGEgEWewIogu3u7BC9mkEjdiMvgMkMmS1U/FHIDaH/fwzCEYxYlCpOZHHzqMJNF8fRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795627950;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=0ptdBS8fx26cGjDnm/cY+e7vQYsGvyxsvMQT5ddnw3s=;
	b=yN0ugM0PqCxOvPgxjZKtatI3T0gdWnu9LrAbx8wr+mVSOkcjNMB5QRoXwIaoFIGM4Gwt
	 jC7F1+hGRCsEzczL2IlItuw1jyJWFisICl+3O9vhXEJx4QEzKsE1Q65E/4ApG/MB8kudT
	 vDU89LzpInWT+gdq5LL0h+65qeAVixBxFrXQomrE1gG74G2rJK9NN/XkvV0e9QpFYwHMK
	 yNDLh3KLNt+9wRUTfgvsXjBt+fLAtaU77DM3JbTcwMwXD2PKRM1GB6SqwVvOV1sMNVYOw
	 y054nStAYyOmMyCft+rUS2N8qVeJOumOGARgZVTZA8YoBpdS5jWM8cLuWS10myGEuNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B9t5uBP7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id BBFF5606A31E;
	Wed, 25 Nov 2026 17:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B9t5uBP7
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id C95031F000C6;
	Wed, 25 Nov 2026 17:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795627950;
	bh=0ptdBS8fx26cGjDnm/cY+e7vQYsGvyxsvMQT5ddnw3s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=B9t5uBP7grmQ5u0Zy+DwOyfD3TTyHn2kPUPizAGgcv3NN2wT4I9ydv/CYKPrZHwbd
	 5W8QOtZ72je4q/j6qh1YbmHb9ypXzMwlS3pnT9WpokPYVhdedLwGZ1T9TwEnnuHfHm
	 +8wpcLjmGC38TJl2oGILd+OBu69DX4AKJPfG2gZUWMRpCSAvQlsHUip2ccvtWjaJfY
	 9zSTJff+qlNVQfK/kNX/DPnQ2b8VBrk4Mgs7lrYUdB/z5RnpXsmFAzwWI2uMEdo1fE
	 SP1dSnAFhrcS2WMDn3m/H/24i0RhiKwzq1QCaTZ5Co2x5fG0eFFhBdGnnwVWFb33Xx
	 lAi/H2MiqCc9w==
Date: Wed, 25 Nov 2026 18:32:27 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Gary Guo <gary@garyguo.net>
Cc: Priya Bala Govindasamy <pgovind2@uci.edu>, m.wilczynski@samsung.com, 
	ojeda@kernel.org, boqun@kernel.org, bjorn3_gh@protonmail.com, lossin@kernel.org, 
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu, dakr@kernel.org, 
	daniel.almeida@collabora.com, tamird@kernel.org, acourbot@nvidia.com, work@onurozkan.dev, 
	elle@weathered-steel.dev, linux-pwm@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	ardalan@uci.edu, zhiyunq@cs.ucr.edu, dzueck@uci.edu
Subject: Re: [PATCH 1/1] rust: pwm: reject over-aligned driver data in
 `Chip::new()`
Message-ID: <awcbICD_lN4uJrKo@monoceros>
References: <cover.1794600927.git.pgovind2@uci.edu>
 <caddec5478a0d39a73152247a60bc21b3c609cc7.1794600927.git.pgovind2@uci.edu>
 <DN4FFKMFI488.187QX5RI55L8S@garyguo.net>
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
	protocol="application/pgp-signature"; boundary="553axux3auq2ermk"
Content-Disposition: inline
In-Reply-To: <DN4FFKMFI488.187QX5RI55L8S@garyguo.net>


--553axux3auq2ermk
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/1] rust: pwm: reject over-aligned driver data in
 `Chip::new()`
MIME-Version: 1.0

On Wed, Nov 25, 2026 at 04:19:30PM +0000, Gary Guo wrote:
> On Fri Nov 13, 2026 at 8:25 PM GMT, Priya Bala Govindasamy wrote:
> > `Chip::new()` does not check the alignment of the driver data type `T`.
> > This allows a Rust kernel module to choose an arbitrary alignment for `=
T`.
> >
> > `pwmchip_alloc()` reserves `size_of::<T>()` bytes for the driver's
> > private data. `pwmchip_priv()` aligns this storage to `PWMCHIP_ALIGN`,
> > which is defined as `ARCH_DMA_MINALIGN`. But, `PwmOps` does not restrict
> > the alignment of `T`, so a caller may provide a `T` whose required
> > alignment is greater than `ARCH_DMA_MINALIGN`.
>=20
> The commit message is overly verbose slop, please simplify it. Just state=
 the
> issue (`pwmchip_alloc` aligns to `PWMCHIP_ALIGN` only) and the fix (reject
> drvdata with higher alignment with const_assert).
>=20
> >
> > This can result in `drvdata_ptr` pointing to misaligned storage for `T`
> > in the underlying C allocation.
> > If `drvdata_ptr` is misaligned for `T`, that breaks the safety
> > requirements of `pin_init::raw_try_init()` which requires a valid,
> > aligned pointer as an argument. This is undefined behavior.
> >
> > Additionally, `Chip::drvdata()` can be called using the `Chip` produced=
 by
> > `Chip::new()`. It creates a reference to `T` from the misaligned storage
> > which is also undefined behavior.
>=20
> These all follows from underalignments and there's no need to do this
> explicitly.
>=20
> >
> > Reject over-aligned types at compile time by asserting that T's alignme=
nt
> > does not exceed ARCH_DMA_MINALIGN.
> >
> > This issue was detected by FerroLens, an LLM-assisted analysis tool, and
> > was then manually analyzed and reproduced.
>=20
> This should be a note and not commit message. Move it below the ---.

FTR: While I agree that the commit log is very verbose (and being only
half Rust-literate I still don't understand it completely :-), but I
like the info that this was found using a tool (in contrast to being a
real problem triggering with mainline) in the commit log.

Best regards
Uwe

--553axux3auq2ermk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmsHG6kACgkQj4D7WH0S
/k584AgAoROiNHvgZ3driRGTU555fNIPYcbMGAUU+my3lqfWESMq7v9Oq5Loawl2
NhExXyrs7rZK0lvwVpZN2Hhxf8g1OMaPph2PnwQwUDFIiPGgZR6LhcIzd0w4xE/5
khsLUWxX2/bBlyOUF7aMygLOikUyJnSlTDzTI+6EF1d+kX4Vstbto0OOE69SstcR
6tQjQJLPSEJoKD6xi+IIhRdGQUZpHCv2q3Y34I1zQajddq6sR9EQf7iIa8Jp0E/z
1SYyyi9lZJTwpUfZapt6cKaMnmX8fqUsvC7szNobPeFJjQlY1gq1cb0ZfR0oZncT
QlohAQU17SAh/TRQkvTFYR0fp+O12A==
=mNhO
-----END PGP SIGNATURE-----

--553axux3auq2ermk--
