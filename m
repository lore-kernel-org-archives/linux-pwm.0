Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C26B261B8D;
	Fri, 10 Jul 2026 05:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783662730; cv=none; b=AALTy+rcKCe8lyLrJZc/HfHeTI6hFGwOdSpWEo9KoK3SeQZitCkaqHE/O1ZjXH2vsOUIcJHEJpbGeT/I6UBDPlgGmmm5ztzRysvvk042NVMCKLZyyrKzINz1xaTKcEZppK1G2rLAhd2YXEMqQCq7P+GkqPf8g/PKe4IlaWmQeDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783662730; c=relaxed/simple;
	bh=C4dNNoFjTmPVDTd4umr8f7jmGd8315uAllp4/LlblxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NGh/ltMk3Aytxtjo0p2Q5dQOP22ozXNmBRtOF+ovK1R38gC78I9ny/bIxqUuOBJK+Sto0iU+LVUICwO5Ad2rtSTT5g66MfkdejeA0DVaOIFVP6SaMmVOmCJrHN+UhQjaOH6jDcN94zXyBGcieKwEOlWcHBIRQsOpfpX1AtQW4aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aIOX9Shj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aIOX9Shj"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 785011F00A3A;
	Fri, 10 Jul 2026 05:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783662729;
	bh=ZlU/SLfr9dTR0mdUitfTL77FTvnZBZpyDlOZV2Imu08=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aIOX9ShjNelV0k+BMzoYK183zFCk/u95tFkL52ITZ0QIvUUWuA7Ee4APMimULIqP0
	 yf+RzAf2uuh2tjmx92xYZsTW5kQPv2y0lUWzcH5ECLppWnLopoLlLiFDe/kykGsj1E
	 xwYAVBFjiLxTGEzLddV7KP1bKYyzSWLpuVOXn9bmJFs6kuR4xjizEl7TFYR9AGi+1w
	 HmlNjAyuI+ROhxEqzVuk7KDBMGr47KjqRl8O7M0GfmroZngfJt8s5NnyjrSqs8WTa7
	 5qcbvTiQiwN1MZdU7RHDbWl2votRN3czdFlJstJwRHPeDj5TsBy7xT1eFhdZuN5x1D
	 lezXDmL3US5rw==
Date: Fri, 10 Jul 2026 07:52:06 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Keguang Zhang <keguang.zhang@gmail.com>
Cc: Binbin Zhou <zhoubinbin@loongson.cn>, linux-pwm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] pwm: loongson: Fix low pulse buffer register
 handling
Message-ID: <alCIB5nGfYlEZsMg@monoceros>
References: <20260626-pwm-loongson-fix-v2-0-5492db953879@gmail.com>
 <20260626-pwm-loongson-fix-v2-1-5492db953879@gmail.com>
 <aktdkn-NcQt7J1YS@monoceros>
 <CAJhJPsVffZLTzXyA41rxm=A54sZhROVg-+K-gWo1KEzuKGv15w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pg2hkufpcicibmwc"
Content-Disposition: inline
In-Reply-To: <CAJhJPsVffZLTzXyA41rxm=A54sZhROVg-+K-gWo1KEzuKGv15w@mail.gmail.com>


--pg2hkufpcicibmwc
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 1/2] pwm: loongson: Fix low pulse buffer register
 handling
MIME-Version: 1.0

Hello,

On Thu, Jul 09, 2026 at 03:25:38PM +0800, Keguang Zhang wrote:
> On Mon, Jul 6, 2026 at 4:00=E2=80=AFPM Uwe Kleine-K=C3=B6nig <ukleinek@ke=
rnel.org> wrote:
> > > -     /* duty & period have a max of 2^32, so we can't overflow */
> > > -     state->duty_cycle =3D DIV64_U64_ROUND_UP((u64)duty * NSEC_PER_S=
EC, ddata->clk_rate);
> > > +     /* low & period have a max of 2^32, so we can't overflow */
> > > +     state->duty_cycle =3D DIV64_U64_ROUND_UP((u64)(period - low) * =
NSEC_PER_SEC, ddata->clk_rate);
> >
> > What happens if low > period?
>=20
> pwm_state_valid() in drivers/pwm/core.c ensures that duty_cycle <=3D
> period before the framework calls the driver's .apply(). Since this
> driver always programs low =3D period - duty, low cannot exceed period
> when configured through the PWM framework.

But this is only the case when .get_state() is called after the hardware
was programmed by Linux. The function should also work for the state the
bootloader left the hardware in.

Best regards
Uwe

--pg2hkufpcicibmwc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmpQiIMACgkQj4D7WH0S
/k6sKwf/bnIBymcZ/fJgylLmT3nJ/s8EtYF02hfFrxZA6aOX62BqWC4jM8sqBrAr
LF2Rvnyhs0JAgaqYUE75gRscrS8oLJgMjKpFQ/0PIPmsukVRRTKq6QRDKh4zRRF7
nOQ62cu1jzqjytxEX3rtoLMmCuzuNd9FhrgSIV3QYixkXAhxRnMU10BvHl6mKgYX
WDtMf0p2Yr0yJcvOn57zs+buCh9toA2cS4KFy36mSvyubipQRxNSrQ+gdzT7E+5q
Ft6ZZ4dQuJKsHOkrCyhflr5dG4PHXB9vpA7boSFZYfmtvHs3M08FRTl9k7I5SN8t
EN70pwOc/dAenzNuCjiaqKKBX0XHFw==
=NEj/
-----END PGP SIGNATURE-----

--pg2hkufpcicibmwc--
