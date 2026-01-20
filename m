Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5523A962A;
	Tue, 20 Jan 2026 14:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768918778; cv=none; b=sIWQRXfbPFhRsox13k82qDIfpJyGfVFUsulfNKUzluFwJhIiHa3WLmFRCWl3mexzjhxcu2j5GDhdzU7xAK+nVjbNsxRH9lNDqdDVSS9+CIZBOGXPz7pKlAKHp5MkVmx8wjJKSmXYsZ7xSBx/f4wsQYPRWqzG881ob6VfHrw5FeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768918778; c=relaxed/simple;
	bh=0EqlVac/TAXb6i3OqtFhx2Hv2zoj/4CI4DLtAy5JmzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=USKPoN30d58rohySDvXq7KzjvwEUGs+L0l7yBxrDRg85OP0VNf9A2bWULZoLf2TQpgdL7tCDFMiBnj+xDADKDKV2EebTMK65x2c1umKI7l/FZcdySFA8WgvnuuNP7nvqLCcDA5j6EfaThMID2sh+gpuVji/PX0EsW+7AgNJ58WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q1RW/Ngr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q1RW/Ngr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF678C16AAE;
	Tue, 20 Jan 2026 14:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768918778;
	bh=0EqlVac/TAXb6i3OqtFhx2Hv2zoj/4CI4DLtAy5JmzQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q1RW/Ngre5Nn7fCZL0oyaPJmmwEaiEPs2NCJPSBOxhgyka1zQizSxdFCuvNSsNqsC
	 JFQ5ZdphxGpdZX0xJS56GgzLPoLN1kljbgbLyY2iDwv7ja/LvS7yEMxTU5Z4f5vd0Y
	 QSDlw0vpXLhZOyFiS9loOo6rxUeoWfxhGNEoOVcL9AbsDXbBBbkMGwlH6feo6LrFMN
	 EprcGUUTeL7v+9aP3AglbmmgPgBaST8FGE9KpXmHmdphCjX4SbirCJCDpsXq9zMtgg
	 DPxaS4BU8O0fUkeCk/FGnH7otF/J0zt1svA7zAoYikgc5+ICQzt6fKAxbCJUDTFLTn
	 s+RMsyPndp2rg==
Date: Tue, 20 Jan 2026 15:19:35 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Dave Stevenson <dave.stevenson@raspberrypi.com>, 
	linux-pwm@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v3] regulator: rpi-panel-v2: Convert to new PWM waveform
 ops
Message-ID: <izui2w7jddvnji3nbw57yivdoohrs6tabkb42gtklhy53v7byg@zkcjf4js5fbl>
References: <20260104194224.41245-1-marek.vasut+renesas@mailbox.org>
 <x25kxyh4t4u6c3ilj7nxp6sywab5dsar46b2foesrwfux2l4b2@d5iwqqcpdhlm>
 <797047eb-e422-4a8b-80eb-ab130066c1d7@mailbox.org>
 <xsjwvmlqclctnf6dgwyuoi7zits27is2s7r7taprb2w2lhsf7i@uiljd7o3ivbk>
 <855e5015-98c8-48f6-9320-ca8163591940@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ld45a7p5cyvqifvp"
Content-Disposition: inline
In-Reply-To: <855e5015-98c8-48f6-9320-ca8163591940@mailbox.org>


--ld45a7p5cyvqifvp
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3] regulator: rpi-panel-v2: Convert to new PWM waveform
 ops
MIME-Version: 1.0

Hello Marek,

On Tue, Jan 20, 2026 at 02:50:03PM +0100, Marek Vasut wrote:
> On 1/15/26 5:37 PM, Uwe Kleine-K=F6nig wrote:
> > . Given that the dt specifies something made up and the driver was
> > written in a way that is wrong but does the right thing in combination
> > with the made up .dts, you cannot fix the driver to be a correct PWM
> > driver without having to adapt the invented values in the .dts, too.
>=20
> I think this is what this V3 does. Would that be an option here ?

No, the driver doesn't become a correct one with your patch.

Another option I see is to make the driver directly a backlight driver,
instead of a (broken) pwm driver + pwm-backlight.

> > Maybe the lesson to take away here is: if a driver implements a PWM, Cc:
> > the linux-pwm list and the pwm maintainer on the submission. And let me
> > point out that even get-maintainers.pl knows about that:
> >=20
> > 	$ git format-patch -1 --stdout d49305862fdc4d9ff1b1093b4ed7d8e0cb9971b=
4 | scripts/get_maintainer.pl
> > 	...
> > 	"Uwe Kleine-K=F6nig" <ukleinek@kernel.org> (maintainer:PWM SUBSYSTEM:K=
eyword:pwm_(config|apply_might_sleep|apply_atomic|ops))
> > 	...
> > 	linux-pwm@vger.kernel.org (open list:PWM SUBSYSTEM:Keyword:pwm_(config=
|apply_might_sleep|apply_atomic|ops))
> > 	...
>=20
> I do use get_maintainer to CC people when sending patches, hmmmm.

What I looked at before writing this was:

	$ git log linus/master -- drivers/regulator/rpi-panel-v2-regulator.c | gre=
p Link:
	    Link: https://patch.msgid.link/20250616154018.430004-1-marek.vasut+ren=
esas@mailbox.org
	    Link: https://patch.msgid.link/20250609223012.87764-1-marek.vasut+rene=
sas@mailbox.org
	    Link: https://patch.msgid.link/20250609000748.1665219-2-marek.vasut+re=
nesas@mailbox.org

and neither I nor linux-pwm was on Cc: for these. Maybe you used
get_maintainer.pl from before 8f960106c150a9733f5d7408b975c0a687617961?
:-D

Best regards
Uwe

--ld45a7p5cyvqifvp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmlvjuwACgkQj4D7WH0S
/k795Qf/bdUx6+IsxkCaHyE7d4QAurHelpaVYegFvKJjePU31Pwienrr363Pnt2n
wdOA94sdqt/G9UMBIQHGK+392cwctqwxUZBXamfYW3YqGY2qFjIwxU9tzgUnI8/k
jx2bdQoACn8vgy2BHI9B5xbYWVXQ2ZW9InfRWDEzD73xzrR5HG6LPiXloAAijtJh
NZUGGwjx20kDgMPBqTITLXEUw38XReypUGj+Zr88Hrl9U2numFOMjDwJSUkIynhS
yBLIQk2cADRjPHcSJmtKhtBTaTZhi2R9Hn3980tVvBrFJ1K6t0qlFrYy4g6wAoPC
NH2XtpH3EjN8wWCfMdIUpjhdJBEaZQ==
=hVsv
-----END PGP SIGNATURE-----

--ld45a7p5cyvqifvp--
