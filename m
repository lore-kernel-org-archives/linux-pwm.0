Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C50147C0E6;
	Wed, 23 Sep 2026 10:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790158312; cv=none; b=Y17N2txACi8XpB+FVTm4jjyItTDUAbd+q6nYh0oquunOy445AcoC21deIIRD5P37p8JqnHNLbOIH9ky88HvSXz5VIVnxkt3w1IP95YIh8J9NloNoHkvYmDBHXaNOXzDoskBJ8LNlsEvhtmYreovam2uPvv1hdFxf6g3yqrx4Ll0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790158312; c=relaxed/simple;
	bh=tHmBpHwXmyrUocCjeB90xHJBo5pUu7l+/ZjvyWUDw4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mps+e1X7UINAYd+9YaM3iU1SdgwgAajl6Jfsg0Z+yCsAkA7FiWsKIfZ0uHXIX6EvRfHwqYfOVj4k81l5Xh+e5032MDhurkbdSsrVs36pdQ4W7cu1ZmfkGPuAg3fP2AR8CnE+134fARBg339PZTFp2th4cbZ9oeZSgRnf+uZkJws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VuKt3nUv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VuKt3nUv"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 5AF7F1F00893;
	Wed, 23 Sep 2026 10:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790158301;
	bh=Lzwi0Mawi31RemVumzSqchu9DrI7b9hCSXz46KflOoA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VuKt3nUvlo/v/IzT+Tj47tvuL6nA4HV3Q7NBHHdCS/G6dVIGJM0CxYOYjHPdAOtaS
	 +i/+FuwrpRzaq2oBfaxfyeApTyHcdp5v87ynMCNYRiGhMf7uLOZP1YwenSYSNYQq+s
	 8X5GmDzrvjIA/Aj0uAYCVm7Foyz8wV1RBm+OelSBSSO9n+IYA6NLrqoh1dH8vOj8OH
	 nO07S6eJ90f4pDGHhtHOFuMqIUiMOFhJJ65YhsNkWCmQFwSx1cfvOWsuulqZA/lbGe
	 0JS9c3Q2tTA9Idu3LlClILtxjjSKSeeOxmUGgnpXVvOOYmfE2ZEez2exncC2AbhmVj
	 8g5oWxnfs5hoA==
Date: Wed, 23 Sep 2026 12:11:39 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Richard GENOUD <richard.genoud@bootlin.com>
Cc: James Hilliard <james.hilliard1@gmail.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Maxime Ripard <mripard@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Brian Masney <bmasney@redhat.com>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Paul Kocialkowski <paulk@sys-base.io>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	John Stultz <jstultz@google.com>, Joao Schim <joao@schimsalabim.eu>, bigunclemax@gmail.com, 
	linux-clk@vger.kernel.org
Subject: Re: [PATCH v8 2/4] pwm: sun8i: Add H616 PWM support
Message-ID: <arOif-bN6JgLeWd3@monoceros>
References: <20260804-h616-pwm-v8-v8-0-db37ab8624ae@gmail.com>
 <20260804-h616-pwm-v8-v8-2-db37ab8624ae@gmail.com>
 <arFMta6PPwmzSk86@monoceros>
 <CADvTj4r1sFjPko7G5DwrPUw9x1tPzQspJhCUmHSMtrudn7SXEQ@mail.gmail.com>
 <33e760ca-2bb4-4f1d-a736-7e74a97e60c4@bootlin.com>
 <CADvTj4rBUNF6EaKXbsy5t1cS0iakpWVdpQ5sQF2qLS4YyHM2aQ@mail.gmail.com>
 <58145d8f-dd16-4cc2-b2ea-d475462241ab@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fd6ngstaj7r33ymy"
Content-Disposition: inline
In-Reply-To: <58145d8f-dd16-4cc2-b2ea-d475462241ab@bootlin.com>


--fd6ngstaj7r33ymy
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v8 2/4] pwm: sun8i: Add H616 PWM support
MIME-Version: 1.0

On Wed, Sep 23, 2026 at 09:16:28AM +0200, Richard GENOUD wrote:
> Le 22/09/2026 =E0 17:46, James Hilliard a =E9crit=A0:
> > The resolution tradeoff is real, but the waveform API currently specifi=
es
> > the ordering: choose the largest period not exceeding the request, then
> > the largest compatible duty length not exceeding the request, then the
> > offset. That's the ordering implemented in v9.
>
> The ordering stated by pwm_round_waveform_might_sleep() documentation is
> period_length_ns, duty_length_ns and then duty_offset_ns, but what about
> duty steps?
> It's not stated in there because it's not a user input, but still, it's a
> quite important value for a pulse width *modulator*.

=46rom my POV as someone who cares about many PWM lowlevel drivers, it
would be ideal if there would be a generic function that only relies on
conforming and ideally simple lowlevel drivers and work out a good
period that makes the required amount of duty steps available.

When I designed the requirements for the round-to-hw function I had in
mind that it should be possible to find the next higher possible period
for a given lower bound (and that works, only lacks implementation).
Working out a period that has finegrained duty steps is harder but
doable:

But something like that should work:

 - Pick a period P
 - P*, D*, _ =3D round_to_hw(period=3DP, duty_cycle=3DP-1, duty_offset=3D0)
 - Either take P* - D* as a measure for the finegrainedness, or continue
   to research available steps using round_to_hw(period=3DP*,
   duty_cycle=3DP*-1, duty_offset=3D0)
 - If there are too little steps pick a different P and retry.

Best regards
Uwe

--fd6ngstaj7r33ymy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmqzpdkACgkQj4D7WH0S
/k7BfQgAr7KMuPAtN/IKDLW/9x3RqwTMy0tlPrFOQzqERY7t/kxB0cw+TGg3fkiZ
oInOoNbriO+IGxdXHfBaVdmzS3XSF/EnOW4xETeqEsIqjRLnB14+38m9iF8Spi7t
/2lHC5ceG7fFfdLEI96+DUY179JZ83zzy5JgLWXXs6uQNrY+Lo7+ApQDip3IeV9m
apd+gqxBpPvAoytV6ffgVSga/pffZArLfoKStB0PfeNKFi5S07gBSL1FzCjd82c9
hLWzLR5dA3gtIGDOOVH1SOOrgcElqzIYbaHed30mEy4W62fifUEHexz0oe9VzbqV
JR5xSciGikOWhpchtrzM0b8rIfy4bQ==
=LEUc
-----END PGP SIGNATURE-----

--fd6ngstaj7r33ymy--
