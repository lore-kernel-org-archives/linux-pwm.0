Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3043B528434;
	Tue, 22 Sep 2026 10:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790071578; cv=none; b=KwN0Lt9Lu//+DFUm9ZYXay2l+fl2FmH0hiUPMgPmkM5sYOVOYRbITM/mRbFAxasQqFcP9Y4rBCj5SElTFS9yB35cznkYAYi8ywkaYG9veMtNz+nzN2XPBUnmskM0etZOdnXEv79qJh1sfcStngiWotMeBDzLUm9SGtN46DZYJr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790071578; c=relaxed/simple;
	bh=o/eE6Lc9QhKXydhYkS0CdMFak2PLQIakXJAyzJNeJGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dp3CKuwZz1GmhuqMf1uWCnc3uPvKtGrnb2ErdFQRt7L1SKrfXPBOYYebosI+sYgyX0qtA/jHNu+CBDmdVCQXiuPDpT+yYPmzR+O4chPuvPyls3egWXzk4MCQHz21jHfpBIGiev1QHAG2Tr4/yzAEUCVI9LnQDTjoHv7dFUkXbaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hGhplo9h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hGhplo9h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28EE01F00893;
	Tue, 22 Sep 2026 10:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790071576;
	bh=AIl7i2EIk2Aq07W0OjNAMhb0POXZ7bwY5ANPS8qk1wQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hGhplo9hC7AlrTfaAucTNt2ApWv8yv8TWnPuynoPeiEabnCzczSO8IIgvltwoIwTQ
	 a6jftzVdZu2m+3zNxWwGp9FUSmgirrI0GkzyChyns7gXjtZ93idf4XoaPnwFOUKd+t
	 a/+OGHcscoyCiezWVNs0KE5PgGA1qzJDh6YphB8HxjAB7/GLVSBomaOpO1nZra9p9F
	 GLwtpXYcTqJ+dXJ7prpqHABaidtGZDoODzdYJ4wsf3O6zjVuabxoKEi/k8axMhuwH1
	 xah9mBDl7QXChPR4a5Q/V0Wdntpe2wWmVEnTy1I/CFQ/tefZdsoDXb9A5vyj0k2h2j
	 ccRuxJnQHVP+Q==
Date: Tue, 22 Sep 2026 12:06:14 +0200
From: Thierry Reding <thierry.reding@kernel.org>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>, 
	Mikko Perttunen <mperttunen@nvidia.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] pwm: tegra: Check for match_data being NULL
Message-ID: <arJRPVsReXWfUC_o@orome>
References: <cover.1789741839.git.u.kleine-koenig@baylibre.com>
 <ed943d9be3b785514e0f65a5b8c13a78aba7a090.1789741839.git.u.kleine-koenig@baylibre.com>
 <arD7N6A6ncBNR1Jk@orome>
 <arE-s0zbTUn14aIr@monoceros>
 <arFYGka5NpcgJ8oQ@orome>
 <arI8vXaKTvEJi-Zd@monoceros>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="h3eadmu2uxajfejj"
Content-Disposition: inline
In-Reply-To: <arI8vXaKTvEJi-Zd@monoceros>


--h3eadmu2uxajfejj
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 2/3] pwm: tegra: Check for match_data being NULL
MIME-Version: 1.0

On Tue, Sep 22, 2026 at 10:33:16AM +0200, Uwe Kleine-K=C3=B6nig wrote:
> Hello,
>=20
> On Mon, Sep 21, 2026 at 06:24:39PM +0200, Thierry Reding wrote:
> > You're probably not wrong about opt-in being the more natural choice,
> > but looking at commit 3d713e0e382e ("driver core: platform: add device
> > binding path 'driver_override'"), the intended use-cases are very
> > generic, so it would probably lead to a continuous stream of patches
> > needing to be added whenever a new device wants to be supported with
> > vfio or something.
>=20
> thinking a bit more about that: The use-case presented in that commit is
> about
>=20
> 	echo vfio-platform > /sys/bus/platform/devices/fff51000.ethernet/driver_=
override
>=20
> . If we had an opt-in mechanism on the driver side, it would only be
> vfio* that would need it, wouldn't it? That sounds handleable.

I have a prototype patch that I'm going to send out shortly (after
testing that it actually works). The problem ended up being that the
driver_override is a device attribute, so there's no good way to drop it
based on a driver flag.

What I ended up doing was add a flag to the driver that causes the
override matching to abort if the driver doesn't allow it.

And yes, you could probably do this the other way around and require
drivers to opt-in, but given how long this has been there and how
generic the interface is (and it is ABI after all), I don't know if
vfio-platform is the only one where this is being used. For all we know
there could be a myriad of odd use-cases where people are using this in
one way or another.

I was briefly pondering a more automatic way where we'd check for the
presence of any device ID match tables and checking the device data
pointers, but that's a bad heuristic since there's nothing stopping
anyone from providing "sensible" defaults if there is not matched data.

So ultimately I think individual drivers opting out of this behaviour if
they explicitly don't want to support it is probably the only safe way
to do it.

Thierry

--h3eadmu2uxajfejj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmqyUxMACgkQ3SOs138+
s6EnuA/9EOSAdA5NTHcBiBgBAjotfjMxmv030Eq5wasqiCknM7A85niprfaW3zZ6
cyWUBTmCkyUOsu+cbRpimva5lpQVRMBU629tm1iBCHVFKZ2yX8r8pGnjUYWh1bZf
ihpaeHzomrA7f1jjsJNR20tuK7zxwhIzkcMAOA/HAYTGuNX+XRTTGqQB5l5Bywzk
1cBaRkAcz0Or/Hcmekg8dbcHcNPTlHVWpfg9g0zREWPNpiDIwJcwbSOPfQrkT7q8
Oq1vL5Syfg6jeK3a9ekl5V1IVqsa2fP68/EEQGRIfdWyUWO6WnePj8C/INmZ7GuO
tubuHIqrMCPnV5ubjmc57ZPK7b1ySrCpUT4NKknPglW4RFG6rMYHOMGzphFw8llV
0uEZWEfUfS8Vqfm6Z0qgJHLHfR+h/Y/M8gEgOJDaJ09UaSul6FqeKAwWqOFcFz59
6IB+20OJRHL9eO2HbP4pi320XQpA/KbZgdjBWM4fBiH3PUcSQCTYwbFQqulI408c
oQsWzkFZvDmElXA3A/NyXWsSN6eH/YBnNrX1xKruvY+Mal+vi5sGdgKkr7NXHxj4
CG4IwBkFMFcHAKiS/ywNUvQTFD4NsmMKiSv2p2TmuC6z2lKKZG/zOenAKLTLQcNi
+Xl8voN96/eOPQW7ISZuHwgBkMAI4ZcY5CG2wmASFOqMNCyk6Fg=
=axfp
-----END PGP SIGNATURE-----

--h3eadmu2uxajfejj--
