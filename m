Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37C342C51B;
	Wed,  7 Oct 2026 11:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791373327; cv=none; b=K9QW0RfwOrdBbIe/lWgnK/6szBmniJ4DrJBDZ8zmxj5Q9f7gPK2UJOLSqyhhmmNgyNRwWidV9vouWly/wXnDX/hY6nXMi+u6LZtFMEbBIt/FHD0l9HDEk8vhJl4kXlbTZAJn3+1R09NyFqFzw0EewHCTVj3Pzrh3zBm3XHhWzLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791373327; c=relaxed/simple;
	bh=WHjliqBWyANlUnPIENEFgHwr0GSpu0nmWG1WHsyy8Lg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q9fv3fCgmRoHbejqk0KSxgZ8AXznlBxHO9BnKOd9jyJq7nwgMd+67WLgvsEGRgxvyE/7xGFTyXQIrC938x2IYSxJhZSDY5rnf07YFiwjOm/zi4kD3LKH6DIXmPJ0kcyR7UyYg307KaoAaeFqbzcbpsmp2rFftVbs8JMVnGfrLdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y5Op3kvt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y5Op3kvt"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id D78F21F0089B;
	Wed,  7 Oct 2026 11:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791373310;
	bh=U/gWD4+uF+hshf4jV8IFeriarw2p1293YxmuUXLDiuE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Y5Op3kvtuJhamiHNZudiMXfK5YZx3gWK24uFJyq8TF70getuQtSg/aOgceLbur8K0
	 mgGEo/ux/z2YL+24acrUdnT/LqmNb0IZm7+4iDyvjT1+rIdJOzD0QLPXnXHQ/ZTcR8
	 5T/kmnrijB9xTFl46C6LY+C1BiEOxJIDsukaNvgnhMSv59ijD0CVWWYeZ6dlLR3q5k
	 R0O84vEb8WuTwgcrVusvhyJCMWyW/lTkQ2vEH84Uz5/AuCwtH11pXNRy3xXZNhen3+
	 XM0LZftPYS1fKHEVnMDY2Y1tiHIxDfJTnyQYZyxB0rQuVEJ3VL+G6aOq9dlNMHWu9P
	 ErLxua++imRQQ==
Date: Wed, 7 Oct 2026 13:41:46 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Meher Thanmaiee <meherthanmaiee.vanukuri@amd.com>
Cc: michal.simek@amd.com, tglx@kernel.org, daniel.lezcano@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, git@amd.com, 
	linux-pwm@vger.kernel.org, Michal Wilczynski <m.wilczynski@samsung.com>
Subject: Re: [PATCH 4/5] pwm: cadence: Add TTC PWM driver
Message-ID: <asYvE-ThtZeYSEyk@monoceros>
References: <20261007-cadence-ttc-pwm-v1-0-52a95a8d98b1@amd.com>
 <20261007-cadence-ttc-pwm-v1-4-52a95a8d98b1@amd.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="liwzd3daugmfm5cv"
Content-Disposition: inline
In-Reply-To: <20261007-cadence-ttc-pwm-v1-4-52a95a8d98b1@amd.com>


--liwzd3daugmfm5cv
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH 4/5] pwm: cadence: Add TTC PWM driver
MIME-Version: 1.0

Hello,

On Wed, Oct 07, 2026 at 02:37:02PM +0530, Meher Thanmaiee wrote:
> +static const struct pwm_ops cdns_ttc_pwm_ops = {
> +	.apply = cdns_ttc_pwm_apply,
> +	.get_state = cdns_ttc_pwm_get_state,
> +};

Just a very quick review: I won't take any new drivers using .apply().
Please use the waveform stuff. And also note that there is Rust support
for PWMs, so if you're adventurous try that. (The reference in that case
would be drivers/pwm/pwm_th1520.rs.)

Best regards
Uwe

--liwzd3daugmfm5cv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmrGL+8ACgkQj4D7WH0S
/k7WbQf+IdxlXDGnofnNGYSJgNSQuykiiXyUxguphS+V2ZA4vtCi3WPVyShJmJFn
QReubs0MCHoik/W77Aoga7xjD+yAOhark7Qyt5bvBmWnBZVqZ1sdZSxfOibA2PRs
TRrzjc1jtzHuLakyMmVOlgrxVVATfm5TrpR4v69m9AMX5K6gtdvvZY5TScE6X118
l9GXS7XRuu4gTIuudT/NAMOnK2p1ghbX1LFcGQ6fY0wAlayLeoVeC3koTYHG0UQA
9NNkJRpZizPsC2huOWeCCz3+C79L6pa+Wz9Mh8cM6v6dQEIOe4WcnKomw4hW+GDZ
IUFGtSO4+my35wClptMOrsLNs8fXPg==
=KvDE
-----END PGP SIGNATURE-----

--liwzd3daugmfm5cv--
