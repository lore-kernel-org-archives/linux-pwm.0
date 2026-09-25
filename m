Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD273E5A29;
	Fri, 25 Sep 2026 17:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790356878; cv=none; b=PtPmL2fHtcxkukVhd1WgoNfivyMY58+3ul+K2toeRuk9JSohFQvcwZ8qWKBo0pdaqwQoHrMm+xgfaz6loXD/1+O7T1wWvrzoBeoFC3shiyTviwvT4BF1rbF0AVDDEf3Bx1J3R6+1wumX3efTqr7+1pCrOEbHK+GoKmPdtNR6pkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790356878; c=relaxed/simple;
	bh=9nxjdweXkfbdFmcVmxCbVDT+ZNzgnb55FCH+39qpVTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GtFupJB86Mq/H1OYiLaye4Y4MKgy4lzuO/zqTl5qxR+6k8LfF7ssQhZJMWBkY+6fxJ1eb87EUyT+ds75eR8EqSP8gNvxMzVQI4CBYGgQjgxPJiIJ8BFmdqF1ENSgMoFVe04ueemQA5TrBEsu67XCbUzCZ3jbu1wJa+KdMC0u3eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=avzssm6B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="avzssm6B"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id CAF501F000FF;
	Fri, 25 Sep 2026 17:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790356865;
	bh=9nxjdweXkfbdFmcVmxCbVDT+ZNzgnb55FCH+39qpVTM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=avzssm6B3ZmQ9maWQ3GcZtHsNF75TJPqMt3TMplCbByFHzu3y2S4FOf5a9GTqAm3o
	 TJoaGTAJLEcrmd0WInIx6lEmlA9dvahyUZubgBiFmpbY3BJexYPXJtLQw4ddkr4SIy
	 rl+yzVRU4lw0K90PN5vv0yhdVRVGkRp3PKSZe61TyERtMxh1mpj0oH0l5SfKWX6TUq
	 Z1m6mlHEwGntuv3s7gk3OgupFyZJ8pO8ac93ZAmdQrh2YihlbK3/EwTWtawl+GiJF3
	 FmVtBqZasBVyGt3l0qq82Ir0q226+v6xi9K8vBozQenTctcK1IT3ZZhv9We/4rfnsu
	 k2gPnVP5dpoiQ==
Date: Fri, 25 Sep 2026 19:21:02 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Thierry Reding <thierry.reding@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
	Jonathan Hunter <jonathanh@nvidia.com>, driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org, Thierry Reding <treding@nvidia.com>, 
	Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH 1/2] driver: core: Allow drivers to opt out of
 driver_override
Message-ID: <araoY6u_A9Odej-G@monoceros>
References: <20260922-driver-override-opt-out-v1-0-58c35ded3b83@nvidia.com>
 <20260922-driver-override-opt-out-v1-1-58c35ded3b83@nvidia.com>
 <2026092227-marbling-untying-c1df@gregkh>
 <arJ6s51FV4T9IK5w@monoceros>
 <arKLt__frMjzSA4t@orome>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bbtn3p6yjvnym6gs"
Content-Disposition: inline
In-Reply-To: <arKLt__frMjzSA4t@orome>


--bbtn3p6yjvnym6gs
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/2] driver: core: Allow drivers to opt out of
 driver_override
MIME-Version: 1.0

Hello Thierry,

On Tue, Sep 22, 2026 at 04:09:25PM +0200, Thierry Reding wrote:
> > Having said that I think there is only a handful of drivers that are
> > actually supposed to work when used in a driver override (vfio stuff,
> > spidev and i2c-dev come to mind), so I'd prefer that drivers opt-in
> > instead of opt-out. Otherwise we yet another flag that drivers should
> > set in general but don't because driver authors are not aware[1]. The
> > few drivers that rely on driver overriding should be identified quickly,
> > and if we miss one that doesn't result in a way to make the kernel oops.
>=20
> We could easily invert the logic in this patch to make this opt-in, but
> it might be difficult to know exactly which ones want to opt-in, given
> it's been enabled by default for a really long time.

I'd have the heart to do that in combination with a kernel parameter
that allows to drop the strictness (and remove that after some time).

Currently the only driver I'm aware of that is supposed to be used with
driver_override is drivers/spi/spidev.c. AFAICT the i2c equivalent
doesn't need driver overriding (as it attaches to a bus instead of an
individual device) and vfio seems to work without overrides.

I'm sure I missed some driver, but these can easily get fixed when users
start wailing.

Best regards
Uwe

--bbtn3p6yjvnym6gs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmq2rXwACgkQj4D7WH0S
/k4y6Qf/WHpV211HunZ0wwB5h4C4fAGjvWqgqNBu/LmrhVTOIwaiuI5BxwV8OFhy
E3F73Flg/ut4YI+HtlXg68LpqjmUSgcbiJEteZPCnIYYx25ktV5fi+urviBaUwtU
a3bU80j+x4rzV6A9MZZFLgUkPAWWbFPNjftVouzBZFXQ2NClu9Tv1h2CiaLeM6em
Bm6DIgjLlLvdcQT2eYzwvdPAYzA1OPbRRwUw/lxdTgi3hMInYXCGaz/UDeTYqQLm
yqcVECMadseqEkk0p3lqkRB8WocIIJp709HFuV06UFcZ6oQci84s42mGGjERL6vj
MZnhtS2j2oSCzR7r3ImzRZaaeEZBLg==
=oN5m
-----END PGP SIGNATURE-----

--bbtn3p6yjvnym6gs--
