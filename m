Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8171F2BD022;
	Wed, 15 Jul 2026 14:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784125241; cv=none; b=JrERAU/THVAQOe87WIlgpDznqyJiPqQnrzb4aWSnQCQfzuao6wlZjdnAQkxvEvsABvbaUzqiIyC3ee9T+44LHvBPCbkzRbSj/vjxPbfY6x05lCuQhaMltebDcmInyv1C1jlA9BX5pfcwF1FA9yZQADNXYZL8KcCiD+3APiV86Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784125241; c=relaxed/simple;
	bh=ro6VRXspuxMXfvly+fYFaPaYy/M2NHDAOqdhR+YRyik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XghnSMhKajexEvChG5oEYnE87CcxFSY88s3M6koOI009gXDNzSiQwikD0j0xkpGeZ5H6LgiZE4PRwDZ/cLQL26SqR3Wq49QfqeLZ9rgpawq01YbW/T5Wi79DaMh7dk5pY7Ex76TGzS+mkJBfm8N8NQ7gjqFr1sxt6+cc86wBDXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZNTxi35b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZNTxi35b"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 8B6F01F000E9;
	Wed, 15 Jul 2026 14:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784125240;
	bh=g6AJyQM50c0yTW+18pkw5ecn5PlX/W2Oc8QKRSrrxlg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZNTxi35byK8tuaGnOvKX438ww+ILUo3EZF2PpjoopMYWEKRGC6A31AoqeQQcr5fKT
	 cPCjd3cNXFtT+00JQDmzGoTZH/6YFSaHjAh6BsSzxuq2ii3I3iSh1tzDLylDSEGyNl
	 Eoz1PYTK7olPM+KIymleyeTrtX0VBPUruk4HUwTFlUv5ZoB3BXVOO2qSsApfMz/uGL
	 swssnPWbpLEBuey/v+7YB9C5of3tj7E3fuAsvey9x/ilcTYAB78XYXzgDrqfsHZ7nP
	 Fxq4AmQNqQsYZ0g2somnlx5U7VgpOJ2+WWkXd8pmeZMqQBN1QnhcyURz85q7plxDaz
	 +Maq5mgkLJpBA==
Date: Wed, 15 Jul 2026 16:20:37 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Mikko Perttunen <mperttunen@nvidia.com>
Cc: Thierry Reding <thierry.reding@kernel.org>, 
	Jonathan Hunter <jonathanh@nvidia.com>, linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v1 1/6] pwm: tegra: Check for match_data being NULL
Message-ID: <aleHtUjVKlhP7loE@monoceros>
References: <cover.1784030076.git.ukleinek@kernel.org>
 <c7d4a3ee8c615f5f6f468c0040fdb0e8864152ba.1784030076.git.ukleinek@kernel.org>
 <Mlcy4yaiRVq9tB-a8gkHvA@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cjwt26vckx67l6lr"
Content-Disposition: inline
In-Reply-To: <Mlcy4yaiRVq9tB-a8gkHvA@nvidia.com>


--cjwt26vckx67l6lr
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1 1/6] pwm: tegra: Check for match_data being NULL
MIME-Version: 1.0

Hello,

On Wed, Jul 15, 2026 at 01:11:00PM +0900, Mikko Perttunen wrote:
> On Tuesday, July 14, 2026 9:02=E2=80=AFPM Uwe Kleine-K=C3=B6nig wrote:
> > It's unlikely but not impossible that of_device_get_match_data() returns
> > NULL. Handle this case instead of triggering a NULL pointer exception.
> >=20
> > Signed-off-by: Uwe Kleine-K=C3=B6nig <ukleinek@kernel.org>
> > ---
> >  drivers/pwm/pwm-tegra.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >=20
> > diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
> > index 5cdbe120ba2d..53743f83869a 100644
> > --- a/drivers/pwm/pwm-tegra.c
> > +++ b/drivers/pwm/pwm-tegra.c
> > @@ -322,6 +322,13 @@ static int tegra_pwm_probe(struct platform_device =
*pdev)
> >  	int ret;
> > =20
> >  	soc =3D of_device_get_match_data(&pdev->dev);
> > +	if (!soc)
>=20
> Very subjective, but my preference is to have curly braces whenever the
> if block is more than one line, for clarity.

If you read Documentation/process/coding-style.rst by the letter, this
case shouldn't have braces, but I agree that adding braces here is
clearer (and that coding-style.rst shouldn't be read by the letter).

> > +		/*
> > +		 * This can only happen if pdev was matched via pdev->name
> > +		 * (which should not happen today) or in combination with a
> > +		 * driver override.
> > +		 */
>=20
> I feel like driver_override falls in the realm of 'root can mess with
> the system as they feel like but if they don't know what they're doing
> they get to keep the pieces'.

IMHO even root should not be able to trigger a NULL pointer exception.
Not sure there is a general agreed on policy about that though.

> So adding a check in every driver, or
> in practice having a random mix of drivers with and without the check,
> doesn't seem necessary to me.
>=20
> If we actually want to check for this condition, could it be done
> centrally instead? I.e. don't call probe if there's no match data and
> the driver's match table implies it requires it.

So you'd want to check the device-id table before calling .probe() and
if all entries have a non-zero .driver_data don't honor the override?
Hmm, maybe something to discuss at the "Driver Core" microconference (at
LPC 2026 in Prague), but my spontanous reaction is that this is a
heuristic only and might prevent valid use-cases.

> > +		return dev_err_probe(dev, -ENODEV, "Unsupported device\n");
>=20
> 'dev' is not defined (yet).

Ooops, that leaked in as I reordered the patches to have the fixes
first. Thanks for noticing.

Best regards
Uwe

--cjwt26vckx67l6lr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmpXlzMACgkQj4D7WH0S
/k6xdwgAlUyVMhOibDDgWf89SZtGeppTIAX3ZvxHfHzFVvBfkjxvoTWp/KxTwO2U
58usyw6AA3wzwRjznMn2KQzdoMMXs2Aq57CFSUlWoOKB3pZaHHaQmJHMc/f9qb60
Dw8YPruHy3Lx6+95Btz3362Ulaf45buhZhiPJjOO55lxSTo1hYzAAyux1l3z8Cpd
SFI0M84/5R4bDNDLKnoD7JvQ1jTwbdR+GZGaXw+vwheSq4P2H7xSXtq8TYo8vPQj
ASb4VTWYn+i2wWGXT7Ijk3QHmpBUB5Jknn96tPy1rE8S0hT0Ro9RCG61MmjZ9tD5
M6ia/ANjOtLvzv4ISsNiIvh23O7vPQ==
=uji5
-----END PGP SIGNATURE-----

--cjwt26vckx67l6lr--
