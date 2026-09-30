Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7584F68D3;
	Wed, 30 Sep 2026 13:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790774093; cv=none; b=Up9KbR2/y5UXUG1YBnIVyucUA+1YyS+GfX6SWNF6HihioQzFYcDTPiHkUFCzc9HOjotOwZcwxS2Awgxn9CsFq0NIsZdjXCmGU8uBjCWHLgFxbtZQR9h4vXHH83WLlct8KEeQfSV/1YeByEidmvzwMZ7FFC3EhA3xHZIhSNsvT8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790774093; c=relaxed/simple;
	bh=aiSOICotg52TfW1b8MbO/YOgGLrfmQcxPttr0LniycA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qYQIz49uHxT/wB3/x37d1J2dVDgkNRUlkIG5Dr8z4wneWcO9+LaOY6AyM4mahgNC1F/iQyKwgc7w1COBORbYdsZx2zDeylC/P8TPYhaT/z+IrkqeVL2iCtVfoijqdtey35JCQMBH3eXcKi6EVJGOQ540sgDvzozTQ6yxFfZWy7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lqIZAlrV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lqIZAlrV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6CD51F000FF;
	Wed, 30 Sep 2026 13:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790774078;
	bh=KDn7usA6OmsRhbjY0z6uIMXxy96TouSoeWnGObsGvsE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lqIZAlrVKHJhHT2y0NOa51SsHf7uc9FQoBmt8kruUMar6YS64j0PvKIe+fzuRG9Ut
	 YbAz0SH3bmiba8FT84XCvclIfF9cy+PcAzR3G1RH9fBA0hk2mkQkm6UTdfHxniGBQh
	 GFOo3btAmZx4r0jzEbA5oEsqH4nF2UBM879pxp3gieQpIvfIzr+AuLUusSW+DKCoiy
	 HBQyut4wYUj0xRq8XIoXLOaCg629GyD4FKIXrAyJhthXcJDGJYcVKRGVDVn3xz/vRo
	 0PwTj18HS5rSkc/UdBT1TEb/uZvduL0k38Av8hwGO+5zBRumQc+MfzzlD0ciBMKeP2
	 yU1mMHsYiO+EA==
Date: Wed, 30 Sep 2026 15:14:35 +0200
From: Thierry Reding <thierry.reding@kernel.org>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>, 
	Mikko Perttunen <mperttunen@nvidia.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] pwm: tegra: Check for match_data being NULL
Message-ID: <ar0JBTAxcXVmTx1b@orome>
References: <cover.1789741839.git.u.kleine-koenig@baylibre.com>
 <ed943d9be3b785514e0f65a5b8c13a78aba7a090.1789741839.git.u.kleine-koenig@baylibre.com>
 <arD7N6A6ncBNR1Jk@orome>
 <arE-s0zbTUn14aIr@monoceros>
 <arFYGka5NpcgJ8oQ@orome>
 <arI8vXaKTvEJi-Zd@monoceros>
 <arJRPVsReXWfUC_o@orome>
 <arz4S1-q7DXM8y4s@monoceros>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wpegfzvg6vdg7m5a"
Content-Disposition: inline
In-Reply-To: <arz4S1-q7DXM8y4s@monoceros>


--wpegfzvg6vdg7m5a
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 2/3] pwm: tegra: Check for match_data being NULL
MIME-Version: 1.0

On Wed, Sep 30, 2026 at 01:55:59PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> On Tue, Sep 22, 2026 at 12:06:14PM +0200, Thierry Reding wrote:
> > On Tue, Sep 22, 2026 at 10:33:16AM +0200, Uwe Kleine-K=C3=B6nig wrote:
> > > Hello,
> > >=20
> > > On Mon, Sep 21, 2026 at 06:24:39PM +0200, Thierry Reding wrote:
> > > > You're probably not wrong about opt-in being the more natural choic=
e,
> > > > but looking at commit 3d713e0e382e ("driver core: platform: add dev=
ice
> > > > binding path 'driver_override'"), the intended use-cases are very
> > > > generic, so it would probably lead to a continuous stream of patches
> > > > needing to be added whenever a new device wants to be supported with
> > > > vfio or something.
> > >=20
> > > thinking a bit more about that: The use-case presented in that commit=
 is
> > > about
> > >=20
> > > 	echo vfio-platform > /sys/bus/platform/devices/fff51000.ethernet/dri=
ver_override
> > >=20
> > > . If we had an opt-in mechanism on the driver side, it would only be
> > > vfio* that would need it, wouldn't it? That sounds handleable.
> >=20
> > I have a prototype patch that I'm going to send out shortly (after
> > testing that it actually works). The problem ended up being that the
> > driver_override is a device attribute, so there's no good way to drop it
> > based on a driver flag.
>=20
> Did you see that I sent such a patch already.
> https://lore.kernel.org/lkml/0f7446324f6a0c8f0153d6532d92a6eeecd6a308.179=
0612298.git.u.kleine-koenig@baylibre.com/ .
> You were on Cc:, I thought this to be enough to make you aware and
> didn't mention it in this thread here.
>=20
> I hope to not have provoked much duplicate work.

Well, from the looks of it you ended up hijacking my earlier attempt
while it was being discussed. It's customary to ask before you do so,
specifically in order to avoid duplication of work. Or at least answer
on the original thread that you plan to take this in a different
direction so that people know what's going on.

Anyway, I was still waiting for any conclusions on the original thread
and didn't spend any more time revisiting my original series, so no harm
done.

Thierry

--wpegfzvg6vdg7m5a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmq9CzgACgkQ3SOs138+
s6HEWQ//QJYK/mNmAW6wc5Z7YaXWMGIbUKADjrdWOyia7B5LwceCRyjUjCkPtLvW
96Y8IL6K3pTsRStX2MedxCzN+jNor1o9BE70K89dXyzyAi4zvoNZBfP+zqfVh05d
/lEDm7Prtp5WmkU8k+x4W5UM3Y6Qsg5V1TsTfTegz4JaSLRpV3Gg59PY6RneNvtU
N4wUUGbAbEO4MHBD+fDlIIthOld7PvOfR794mLwBEqyISiwZgFMbaAzzLzvDB9ug
sAaBZ+9Ze6pVir3AvilafJg/5lLLLpIbFh/EttZENTt+A/owF3TkaOUaaaAjE68N
ssj3t1qiySY8ZCs0yjYwlxmpn/brfyQOH0Wo1id34qJwnXZwyG0OQ0gSTldS4u8W
TbD2aRgFZ2CizkWKxhlOs/As50tr3RkcrZbsBX7YySjdwJC6TZCQShepuXQcPzoO
SwPDjddzmF4JzD4kiwVcqvzy7zwmpJCZl5WjpTz9AknvxBVUo6vqvW/8BJjRLUrT
+6GmPZ1qGC2bwfe8mJNzPSMBPzSoQusNCoRImQDpCzuSDppZZoimgkSfswvR0Voj
JdhlbMOI8kZD5WUdt7qSasz8mwBexsKNZF8eEZZjOS1OspMFfwFKQGVirfHxcWdJ
hJqsuyKDtCcxCy30z2i+i9xMWhfof0bwrdBQEmCMJ1DeuAeIkXU=
=WB0+
-----END PGP SIGNATURE-----

--wpegfzvg6vdg7m5a--
