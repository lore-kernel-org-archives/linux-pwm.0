Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795648545;
	b=ofTMUoPxKx0Pf7z1zgwQvx/UlPU23/agiqlmI+uOi9bSNOGMQUAgC4iSRUDq8KZrruqq
	 Uosce5JNVjY+KTCGcG29TxRGUSm6nePQ77xR8uaDfJoosJPFbR0NN4mLOSHrJvvqlc7M6
	 5D/PajIROQbziDTg3uuXd0hwqZUneewUwsrtN5DKRwuLe2AHMA9D/9RhI/4qkcYs1DILQ
	 n7uHHD89uHqTgS9ZNOyaqPoZzwpmJpbtePWcwtGiCcPssWOzZZuA+CLUHtG+/FMXKqfQ/
	 S4qHpXHpf1v5Z6MQU3oL96Wug8a+Po2+ziPYJ41onUSA1XQgfOF55kSlD+NeOAy+EZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795648545;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=RKU43PV6v6Z6Y7r13RaAE1fMnAuQ4/xp8oTM5GP3ccM=;
	b=L1DuCUYu/+hE/PFKbd01ePA90oGKsdMYpMWub+VkIZTvW+xeO2/z0EalMQy6FBQoD0TD
	 ZVBH4FId/sqomavGonj0VPtbSDtYengsoSWg1Dof/rJ8Lff0FWGpvqrTEcmPJ2ILaVViU
	 2K7ZzOxRNb9UhoLUQRB9JwKqG8lP8G65C7o6hMQntfn8vaYYU9p9yhUALVOQaR7VjxpmW
	 Hy953PUjjiiM1wOq/dfSgTekEs+EQBbZ5aPueInNvAObhI+IhomK9w9zi5l1KjM2oTwbj
	 RpxGf8XthgklrMhle1eIjOIGwKyArfn2dlJGaGxTthPDOCBKC1bAgQUYiZYHk++DgxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L3+i0JDP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id CDE7F606A321;
	Wed, 25 Nov 2026 23:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L3+i0JDP
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 94C061F000CA;
	Wed, 25 Nov 2026 23:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795648545;
	bh=RKU43PV6v6Z6Y7r13RaAE1fMnAuQ4/xp8oTM5GP3ccM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=L3+i0JDP93bNhCHqYr2zL5RMHo7EsNjmuIcuHxD9rzEqTybdE9RFReipmqhYiXgyJ
	 CVXOMO85sv/BMx2/o9De/1fJaD1gprQl90y/+dxdY9QUCx1i7Uzt+hH6AJitbwwWpW
	 FK3hs3k8CwxTVf9s+C/iqc5+9nIK9U0oCDHdIeMVnrNcipLhFgQ5AuMN82Etir07nL
	 dJPD7PVD4Apw/+1ISfmn5/Qtm+zoOvWgnjZ6k39JniWKMwdqvmCZpG/llADy6qaB0i
	 9IFlBlaThMj7AP8lDyyVFkkusQjMX5KUUUQueazUEVdPj4gORKMY2TfhCeFH5UHeDd
	 5acViyZQct/VQ==
Date: Thu, 26 Nov 2026 00:15:42 +0100
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
Message-ID: <awdrlmrOn0_lKlUX@monoceros>
References: <cover.1794600927.git.pgovind2@uci.edu>
 <caddec5478a0d39a73152247a60bc21b3c609cc7.1794600927.git.pgovind2@uci.edu>
 <DN4FFKMFI488.187QX5RI55L8S@garyguo.net>
 <awcbICD_lN4uJrKo@monoceros>
 <DN4H92P6CGXR.UWHS0SN6H62D@garyguo.net>
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
	protocol="application/pgp-signature"; boundary="rxczz6rflblfv7tr"
Content-Disposition: inline
In-Reply-To: <DN4H92P6CGXR.UWHS0SN6H62D@garyguo.net>


--rxczz6rflblfv7tr
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/1] rust: pwm: reject over-aligned driver data in
 `Chip::new()`
MIME-Version: 1.0

On Wed, Nov 25, 2026 at 05:45:03PM +0000, Gary Guo wrote:
> On Wed Nov 25, 2026 at 5:32 PM GMT, Uwe Kleine-K=F6nig wrote:
> > On Wed, Nov 25, 2026 at 04:19:30PM +0000, Gary Guo wrote:
> >> On Fri Nov 13, 2026 at 8:25 PM GMT, Priya Bala Govindasamy wrote:
> >> > This issue was detected by FerroLens, an LLM-assisted analysis tool,=
 and
> >> > was then manually analyzed and reproduced.
> >>=20
> >> This should be a note and not commit message. Move it below the ---.
> >
> > FTR: While I agree that the commit log is very verbose (and being only
> > half Rust-literate I still don't understand it completely :-), but I
> > like the info that this was found using a tool (in contrast to being a
> > real problem triggering with mainline) in the commit log.
>=20
> Perhaps better to just state "This is a soundness issue and not triggered=
 on
> any of the in-tree users"? I think that's what's important for commit log=
s.
> Whether a tool is used to find it doesn't have direct correlation to whet=
her any
> in-tree users are affected.
>=20
> Given the removal of "Assisted-by" requirement recently I thought the ide=
a is
> that exact tool / model used doesn't belong to commit message anymore.

I'm ok with making the statement "Found by static analysis" or similar.
The thing that's relevant is that it wasn't hit in real life. (Assuming
that the reproduction that the patch author wrote about involved
modifying a driver to use a struct with stricter alignment requirements
than currently present.)

Best regards
Uwe

--rxczz6rflblfv7tr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmsHbBsACgkQj4D7WH0S
/k5JLAf/UJzK0sCwcg1hpwNCWXxGpVGKiUYgTp22ZVXBAKfT9JcO81eRRNAYTtLl
jR/kf14S94se2B8dAxdfCnASGuWlVavBcGp34+cm8x5dA7c8ssAc/77sfOa49oJO
OAcM6xd/bX6NzxeKfUl7XF3N+9J9MmYgMLWoR51LrkhMWh/TvFlna8U7COAJwECu
1UNzQXqT4fguvNuue28HpTc3LAQ5IkEbWhptJjKxgM1XOU+IcJfHGUWy3cafDBqJ
JJ9tdyjKCtvQ4MW/lDvR8MxZ+ZYnwWyFCfpNHmu5YfDKZYmFATf17oVii1SCdGF0
MjSsKKenCHkwTnDOsKqoLB65u6NWMQ==
=sMvJ
-----END PGP SIGNATURE-----

--rxczz6rflblfv7tr--
