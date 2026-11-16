Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794841069;
	b=IF2KivCScJINIzKnE2dQ5hpvNIZUoM426M8KDW+w1RDfZtoMn9KUK7hyR1I4Hu6GTtmI
	 HANhgfzdjCTc/Xq2CwPxW8hM1tCc1bNHrmx6922MgUO2GK2eXtH0hkB4QzQm+jgsFX/Ou
	 BqVECxyrHttaMz3DyKfWKY0UxLMeGbh86kBaUhXwYQyGocEunjFdGIlX0FkAGSwsj2Ats
	 QAFCYPB1Jbs54iPs+yzOC2EcU3O0T/7dB8+ie5yEtQAF+H27vDlSkgUqsYLaGOk1vpgGJ
	 UgEpCWMb9seiCWLOUVHJhnVD2uy8wcufvrAEmRKlsgMgg5bv4d8SvT2S/AWifkJ36wg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794841069;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=sWhxqk4MyTmV2zxNqrN/BVQOIcVMMLVIl275tsyfp4E=;
	b=dyy8G5MDYrmhufM7OWNHM103QpYMP3CfsdALL8kTZ08GgdaACNpgeyCrXrHEaEaEYNKX
	 lL+WICrPburu1Zl4kwOgpjyULMatpGPMbGeuiwJA3dKIYrJC0XtiYvcQ3thpYXrSXy7OQ
	 hiEK4YnfI3MoLFLDhPU3V7PB66aca9RHa1Nv/YPfcNGCXAWFsgX7csS0dpKHgEQ+B0awC
	 4YXYbhfwLxfJZx8rYxLc0SNoaa+G06IKMfj6ReHQ2gg/ikNnzGpzre+yu3MouHBIwSIM5
	 4ddWUaru3SuyS64Oohji4c1rpjdjtEF3mr3T1W0rs6ZR+lsp1cI71ZllrYN7pM/Hk2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GvLDnJ7t;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id A152E606A323;
	Mon, 16 Nov 2026 14:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GvLDnJ7t
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id A8D4C1F000C4;
	Mon, 16 Nov 2026 14:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794841069;
	bh=sWhxqk4MyTmV2zxNqrN/BVQOIcVMMLVIl275tsyfp4E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GvLDnJ7tqn7SWEhm8067ZOt2cIfSr5mt0Ly5WIf70koqp1MUQWj2ztrY0Em6BMg51
	 QFJxDphZ91Qg9A3yY8zHEXF/0jmvgtyQ+JaFN0yk4zQxBb4BTXJGDVqs/AG4Gv+Jdv
	 C78u7Izi1V/9N3M6ogeEuYQ4pDFSnn+Svh2LeWlcBm1C2ONomCwakgauB04lGi6UpN
	 iIdcfIataY5uTKGnE78qxVCfE9Tg78kCu8rL9b7YQEW/5kB1tY5diw4zrTMR34g9CY
	 2Vj9ngBIK6Q0qGXe1vM/AvtaLkdPwEvEFuF0bu4g4HEe1lEkHRYVMbrnaEPGsAldFe
	 SWV/OR8P2jKxQ==
Date: Mon, 16 Nov 2026 15:57:46 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: FUJITA Tomonori <tomo@flapping.org>, 
	Michal Wilczynski <m.wilczynski@samsung.com>
Cc: fustini@kernel.org, guoren@kernel.org, ojeda@kernel.org, 
	wefu@redhat.com, a.hindborg@kernel.org, acourbot@nvidia.com, aliceryhl@google.com, 
	bjorn3_gh@protonmail.com, boqun@kernel.org, chenhan0017.work@gmail.com, dakr@kernel.org, 
	daniel.almeida@collabora.com, gary@garyguo.net, linux-riscv@lists.infradead.org, 
	lossin@kernel.org, tamird@kernel.org, tmgross@umich.edu, work@onurozkan.dev, 
	linux-pwm@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>
Subject: Re: [PATCH v3 2/2] pwm: th1520: Fix 32-bit build with COMPILE_TEST
Message-ID: <avsZPKgzc9DIIsh8@monoceros>
References: <20261030020209.3833766-1-tomo@flapping.org>
 <20261030020209.3833766-3-tomo@flapping.org>
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
	protocol="application/pgp-signature"; boundary="tbxmqwzfkfcttcdq"
Content-Disposition: inline
In-Reply-To: <20261030020209.3833766-3-tomo@flapping.org>


--tbxmqwzfkfcttcdq
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 2/2] pwm: th1520: Fix 32-bit build with COMPILE_TEST
MIME-Version: 1.0

Hello,

On Fri, Oct 30, 2026 at 11:02:09AM +0900, FUJITA Tomonori wrote:
> From: FUJITA Tomonori <fujita.tomonori@gmail.com>
>=20
> Fix the following build error on 32-bit ARM with COMPILE_TEST:
>=20
>   ERROR: modpost: drivers/pwm/pwm_th1520.ko: symbol '__aeabi_uldivmod' un=
defined!
>=20
> The driver divides u64 values when it converts between nanoseconds and
> clock cycles. On 32-bit ARM, these divisions are compiled to calls to
> __aeabi_uldivmod, which the kernel does not provide.
>=20
> Use div64_u64() and div64_u64_round_up() for these divisions, in the
> same way as C drivers use div64_u64() and DIV64_U64_ROUND_UP(). The
> results do not change.
>=20
> Fixes: 3c180003dffb ("pwm: th1520: Fix missing Kconfig dependencies")
> Reported-by: Andreas Hindborg <a.hindborg@kernel.org>
> Closes: https://rust-for-linux.zulipchat.com/#narrow/channel/291565-Help/=
topic/64bit.20division.20in.20.60pwm_th1520.2Ers.60/near/626825599
> Suggested-by: Uwe Kleine-K=F6nig <ukleinek@kernel.org>
> Assisted-by: LLM
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> ---
>  drivers/pwm/pwm_th1520.rs | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm_th1520.rs b/drivers/pwm/pwm_th1520.rs
> index 728993998446..bd05fe49650e 100644
> --- a/drivers/pwm/pwm_th1520.rs
> +++ b/drivers/pwm/pwm_th1520.rs
> @@ -31,6 +31,10 @@
>          mem::DevresIoMem,
>          Io, //
>      },
> +    math::{
> +        div64_u64,
> +        div64_u64_round_up, //
> +    },
>      of,
>      platform,
>      prelude::*,
> @@ -68,13 +72,13 @@ const fn th1520_pwm_fp(n: u32) -> usize {
>  fn ns_to_cycles(ns: u64, rate_hz: u64) -> u64 {
>      const NSEC_PER_SEC_U64: u64 =3D time::NSEC_PER_SEC as u64;
> =20
> -    ns.saturating_mul(rate_hz) / NSEC_PER_SEC_U64
> +    div64_u64(ns.saturating_mul(rate_hz), NSEC_PER_SEC_U64)
>  }
> =20
>  fn cycles_to_ns(cycles: u32, rate_hz: u64) -> u64 {
>      const NSEC_PER_SEC_U64: u64 =3D time::NSEC_PER_SEC as u64;
> =20
> -    (u64::from(cycles) * NSEC_PER_SEC_U64).div_ceil(rate_hz)
> +    div64_u64_round_up(u64::from(cycles) * NSEC_PER_SEC_U64, rate_hz)
>  }
> =20
>  /// Hardware-specific waveform representation for TH1520.

For me (being at most half-literate in Rust) it looks ok, and I'm fine
to let this patch go in together with the first patch of this series via
the Rust tree.

@Michal: If you have objections speak up quick!

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>

Best regards
Uwe

--tbxmqwzfkfcttcdq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmr7Gd8ACgkQj4D7WH0S
/k7jwwgApmKdGIB2twgVr/wJDmt0FgXcvfoRPfuzeIYwDKDRWsY5ot//hqEcmyth
Aae4eMor0twnfU/jai/yFCiXQAACMZT1EmKCB3CLWHrjyUYYOkvHDOxZs8PYFyyG
dn178AwEVuyzov3nDye9+lKK+ADuchzyw91n02z501wQbIOj0RVQf7iHOSRlGRmn
kHKztPxlt4uCIOz7/cRgrB2jC4ifcGwFG2w7TGn9x2D/h+WJV/AhYQMWP537z1kb
55Wwc9p7Si/Q0+GYFMk00/I+4DbLK8QB9pXHLmiEuf+wCr3FyZVnN03bfAs1iu5r
xWayczrwFNyU9lyhNv7ZTx0ob5qjew==
=aLxg
-----END PGP SIGNATURE-----

--tbxmqwzfkfcttcdq--
