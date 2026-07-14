Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58655233927;
	Tue, 14 Jul 2026 12:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784030917; cv=none; b=uQBOE4fVBOPahVTT/dBBOUHhDFhAN6cjl9VpApdFNn85H+0wYkH2BWqOt7KfKsk3S7MGnVLTarly/ECFlVFEgfELJ+cBJ/MDOLAf87qMxQoZ6jR7oF7uJTIjvcHyCRQKHiWYb0mdbqfko2A4CT0l4kVMlZNFQ86ekMXtpOVTv74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784030917; c=relaxed/simple;
	bh=dXY0GC+RtMRuoUAl+Q3RuJBFmYA4ldj/VgShDcX0rQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lq2/XYbZcop8ZoKM1/FQpNAkNotMviq+NiNw8UG5kEiXGyAzgKTQDZWW9EHkTuZbUsa9eK72fNOvKpjeYsykrdZ8XPDtfIZwxDFtVqubd1km4iBGcUm7NNiB1WLycWyj9H35bkydmIImzhTtLfO9ar9PIZC3AKbNJ9X82QjKerk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cOL2UimI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cOL2UimI"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id A67EE1F00A3E;
	Tue, 14 Jul 2026 12:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784030916;
	bh=dXY0GC+RtMRuoUAl+Q3RuJBFmYA4ldj/VgShDcX0rQc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cOL2UimIR1Nt072NbjV9FBhG/jQxuoldBxeRMjsVpngK9wVzl3wvI5DfV5TyAo3OF
	 UXGstIAdfS1kAHhlz9wT8HS+XxGHqcz9OJYy2Unk20mLlfqjoMpU/2uq0ZpLv+OuYt
	 p9+AqMs4aqLR1qG4oQgM550FI8/zdhRbCHxSStrLY6OAdWdrUza1Jn/H+2seDapBom
	 JuTiv2jVE2Dn3WOa67fpLFW4qssdLmLgzOY9WlFsmd46cT0bCoCAstg2Q9i7E3kakI
	 zswPMEbGp2TolahAWDnIGhXNOE/jjjDM52r9jhCKc4mWDhfa4KTMjO+J4mRFAMHYhb
	 56vun/HilhxlQ==
Date: Tue, 14 Jul 2026 14:08:33 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: "Ola Chr. Vaage" <o.c.vage@gmail.com>
Cc: Thierry Reding <thierry.reding@kernel.org>, 
	Jonathan Hunter <jonathanh@nvidia.com>, linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org, 
	linux-kernel@vger.kernel.org, "Ola Chr. Vaage" <ola.christoffer.vage@scoutdi.com>
Subject: Re: [PATCH] pwm: tegra: fix doubled output frequency due to divider
 truncation
Message-ID: <alYmY0535HVPRNz2@monoceros>
References: <20260713111541.473547-1-o.c.vage@gmail.com>
 <alX5fmfHs1CW_bps@monoceros>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bbyk6v3ybvtkrwjw"
Content-Disposition: inline
In-Reply-To: <alX5fmfHs1CW_bps@monoceros>


--bbyk6v3ybvtkrwjw
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] pwm: tegra: fix doubled output frequency due to divider
 truncation
MIME-Version: 1.0

Hello again,

On Tue, Jul 14, 2026 at 11:14:58AM +0200, Uwe Kleine-K=F6nig wrote:
> The usual behaviour for .apply() is to pick the largest possible period
> not larger than the requested period (and similar for duty_cycle). The
> tegra PWM driver doesn't do that and instead trys to pick a nearest
> match. If you change how the configuration happens, the only acceptable
> way is to migrate to the usual behaviour, still better, convert to the
> waveform callbacks.
>=20
> The driver also lacks a .get_state() callback and should not use
> pwm_is_enabled(). Also calling tegra_pwm_config() discards bits from
> state->duty_cycle and state->period if they are bigger than INT_MAX.
>=20
> So there are some things to work on in that driver, but don't make the
> clock selection not more complicated as it already is and as is
> necessary.

I started on that, but failed to Cc: you. Please see
https://lore.kernel.org/linux-pwm/cover.1784030076.git.ukleinek@kernel.org

Best regards
Uwe

--bbyk6v3ybvtkrwjw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmpWJr4ACgkQj4D7WH0S
/k7FhQf/asLvaUiHOopjiDbi9CHLkv3NquzJwY4hRuPuXYi97Fs2iz/b+6F3UjwB
dPtkhMrrcEqdOJLq3uMeboDwO8Pl8YxfXvDzkKcawlGnHVEU3okDqTObSRDsnws/
52OMgQDOk+NyuZIt8NoptSSm8H8fxI01BYcAtKLHZB7RayEG8ln/rioGme3+zEXu
fZrFzECYtEZV3aaiNU9eKahXpOEfJXnQtMKK9MsZ1H78S2pQfiC5kEEsbQbhIiXx
mNQWtJxFgkzw7a1wBSOBSW9Lmi9M4dixG1Spie13A2hMHlJsVS2bXbsNbBxC41Zp
y22N2oiJ7O2OotQDa5vXmYxtZgyLgg==
=jVt5
-----END PGP SIGNATURE-----

--bbyk6v3ybvtkrwjw--
