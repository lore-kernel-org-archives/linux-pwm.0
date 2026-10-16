Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ABA14AA1EB;
	Fri, 16 Oct 2026 12:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792155327; cv=none; b=qLt3wM9MPCubb2cv71u2gYtLBfWEcipCRNwcTfTLYgELjXd1sYysUFvT/br9sBa1kuhYSePtd4XzLYLCX5Hz+ZiGsiUPy2ikQCN3X1vxRxUDHqq7uDft0nI10pVOR+L81cmLOn/KpV4qbAn15rJ/+Moh9giMx25co4Mpes2NaPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792155327; c=relaxed/simple;
	bh=x2YQasmYgNoIcWbMmM7tADEOHzZFlLvmhusTwPVBOpI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mzi++C7FtnXw4VGgMDrKsVW0RI1+/od8fIkvMYeqquD8I+bdMR5jiNTcDgV+qQ+viDnyr0Z+hhrwn2PFoJEz2ch+qDtg4uMoTD56r8Hj3UGPAE+eG0Kv+6VWLgai1j/h0PVcEaOTqg+vvajG2wHJ5mmSA6DxZ+YCb+tC26bGsYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bqShC6nT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bqShC6nT"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 524A81F000C4;
	Fri, 16 Oct 2026 12:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792155324;
	bh=x2YQasmYgNoIcWbMmM7tADEOHzZFlLvmhusTwPVBOpI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bqShC6nT1pyz78bMkGYWwjI3dBBdGbTYOwNRVHfOycHplyHnMZxpw8+N22yP8j3C+
	 9lbp2DJWOWZUFIqvLHYOJbsjc4DNKtRw+ODU0vjlDmsojFUCfxB5OSIAg14rvYc34d
	 iamtkyRgPBi0N3HVBqFmb6t8izI9DpSzVVCyNHV8aUteGBYyIn3xQTPwmuI45ZnojD
	 jXFXuJgSYR0cZVwydSbmsBv6wVluj9WorPaODzN/WfK2U5scEDChGpDP3stIqBLCbK
	 JqLV0JJLhDlmsD//vOvvoSJXWPBzyLyYeWq8MFdNX2U9zhsuO3dT9l7Hz7X5WSZZI8
	 jwUylbs/ZCoxw==
Date: Fri, 16 Oct 2026 14:55:22 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Hal Feng <hal.feng@starfivetech.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor@kernel.org>, 
	Emil Renner Berthing <emil.renner.berthing@canonical.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paul Walmsley <pjw@kernel.org>, Albert Ou <aou@eecs.berkeley.edu>, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v23 1/2] dt-bindings: pwm: opencores: Update compatibles,
 examples and maintainers
Message-ID: <atH4DnTWVZPkaO2C@monoceros>
References: <20261014110429.52762-1-hal.feng@starfivetech.com>
 <20261014110429.52762-2-hal.feng@starfivetech.com>
 <9c0737d8-455d-4025-8482-950b64029f35@kernel.org>
 <atCos9UIaZoRs4N8@monoceros>
 <20261015-poised-modest-leech-4decf5@quoll>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tlxupjokx7zu2hhw"
Content-Disposition: inline
In-Reply-To: <20261015-poised-modest-leech-4decf5@quoll>


--tlxupjokx7zu2hhw
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v23 1/2] dt-bindings: pwm: opencores: Update compatibles,
 examples and maintainers
MIME-Version: 1.0

Hello Krzysztof,

On Thu, Oct 15, 2026 at 12:27:16PM +0200, Krzysztof Kozlowski wrote:
> On Thu, Oct 15, 2026 at 12:20:54PM +0200, Uwe Kleine-K=F6nig wrote:
> > Hello Krzysztof,
> >=20
> > On Thu, Oct 15, 2026 at 11:01:29AM +0200, Krzysztof Kozlowski wrote:
> > > On 14/10/2026 13:04, Hal Feng wrote:
> > > > Remove the jh8100 compatible since the JH8100 SoC has been canceled=
 and
> > > > will not be released.
> > > >=20
> > > > Change the register size in examples to 0x10, since an OpenCores PT=
C IP
> > > > has only 4 32-bit registers: CNTR, HRC, LRC and CTRL.
> > > >=20
> > > > I will maintain this pwm module in place of William.
> > > >=20
> > > > Tested-by: Maud Spierings <maud_spierings@hotmail.com>
> > >=20
> > > Drop, did not happen. Is it so tricky to respond to the one patch her=
e,
> > > where the tag would be applicable, instead of replying to cover lette=
r?
> >=20
> > I don't know what Maud did, but if they checked that the various dt
> > linters are still happy, that doesn't deserve a Tested-by:?
>=20
> No. Why would compilation be called testing?

I'd call the task of checking if anything breaks with the proposed
changes testing. For changes to .c files that most likely requires
complilation and running the resulting code on a machine. For dt binding
changes it means "testing" if all the existing device trees still
conform to the new binding because you cannot compile and run the
binding specifications. So in my mind this is still testing and a
Tested-by trailer is ok and welcome for me.

And from a more social side: I really appreciate if someone invests the
effort to check patches, by whatever procedure is appropriate, and
honoring that with a Tested-by: tag is the least we can do.

Best regards
Uwe


--tlxupjokx7zu2hhw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmrSHrIACgkQj4D7WH0S
/k6/6gf/WndYDL7DRTkXBUp7aiUnqS9zwpqTT9urNZ6PAF71xqj2PIQ/2nzKaicH
Qsbfddt0y9u/70gYd72GYVTZI4Juf9S/leijTBlQTzEGnwoE7eIJjeoGdmQwJ34v
XSDKbwPPBCLycHX2PXmnx9S7YabNcFnILSfVs1VLTkW6v7pMqUSvOFfxDqKFxggS
/nuOEEFr+Ol3znei3R3hRHG/tmwrxAXyA0ENwprAg+cea+o0KpF94Nf2eavXCKUZ
QdaiG7qAC4yPPp9EBTke6DsHJ1itFmPGU6219HzEJC2vaCFpmgmwwnLU7bdogJ0s
t6aMJnXKv/yxOXUDoe9YRIi26iq6cQ==
=EJUo
-----END PGP SIGNATURE-----

--tlxupjokx7zu2hhw--
