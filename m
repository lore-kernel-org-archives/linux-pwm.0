Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706AD45041A;
	Mon, 21 Sep 2026 09:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789984041; cv=none; b=HQZv7l5vg8g0kxyjHBcOc9qeIx50wnv5WWuTRBupi6faXM5AqHrCoATj70IiPExUB6gUbSje+YsL3YHGoZ0VDN512N7rhucZ+sUKs93NJdUa4vuaptMgOkuvL1Bi5X+oF24krlCwhLDhbYpWQhGhJtNSNILUG3ZenjZ4TqRq8sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789984041; c=relaxed/simple;
	bh=sV0Q6DZmJiFlK9XXKaWqVq6Mfzdz2G1bKukcbBWU5B8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bNG5Xr8ZyPGXeqqxXoce6xDyfMf53uHN2szrxLAdn4Lu+qG1mtvt8tT1PHKtS78dFFkPCAnV6yZrDdnrlDagoVHKlh+z73tXbiOcTknmr1FPPPbM83Q1keT056l1PuXen/sIUVCLmQ4glgjx6w74+g9YyQMKEOp0efnpBdRq8xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=klq8REdx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="klq8REdx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CBF01F000FF;
	Mon, 21 Sep 2026 09:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789984040;
	bh=j9QVrwUd/zyMk2v12UJUCTpAd4hx99UpQ0/hWJbYrsU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=klq8REdxl8ZgT3mCL6ywQU7IYNeY8eJH6AmNdOqJ99amOA1XFJkISekZyd2h9FV39
	 zEkA9uo324HNijwK462aE3Q5rf/JSUpMSyDOc/U/ylRsIIK7R0F/9WCRjtU3C193Y/
	 WgOdu00GMVx55h4UHTZVpMwh5snbVSy/5jroppCAZQSuUD5/37D7BrSD5yB9VBbHq8
	 45DysSh9HzsGanYdfvWVKFFaGaqr1r/TcWUXBt7gW8fqeVXG8v52fKHH+KHTGPGXji
	 +Dmx4yB61uCVAyTpvIdv6RbeO82+Sigz/TQoUvVIRRSt/7ii2a9xjFh+ddH9nCQYAs
	 /59+bAZP3I81Q==
Date: Mon, 21 Sep 2026 11:47:17 +0200
From: Thierry Reding <thierry.reding@kernel.org>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>, 
	Mikko Perttunen <mperttunen@nvidia.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] pwm: tegra: Check for match_data being NULL
Message-ID: <arD7N6A6ncBNR1Jk@orome>
References: <cover.1789741839.git.u.kleine-koenig@baylibre.com>
 <ed943d9be3b785514e0f65a5b8c13a78aba7a090.1789741839.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bjkyzysa7eclgr2f"
Content-Disposition: inline
In-Reply-To: <ed943d9be3b785514e0f65a5b8c13a78aba7a090.1789741839.git.u.kleine-koenig@baylibre.com>


--bjkyzysa7eclgr2f
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 2/3] pwm: tegra: Check for match_data being NULL
MIME-Version: 1.0

On Fri, Sep 18, 2026 at 04:33:46PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> It's unlikely but not impossible that of_device_get_match_data() returns
> NULL. Handle this case instead of triggering a NULL pointer exception.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>
> ---
>  drivers/pwm/pwm-tegra.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
> index efb7ab60f602..b461d3877f43 100644
> --- a/drivers/pwm/pwm-tegra.c
> +++ b/drivers/pwm/pwm-tegra.c
> @@ -323,6 +323,14 @@ static int tegra_pwm_probe(struct platform_device *p=
dev)
>  	int ret;
> =20
>  	soc =3D of_device_get_match_data(dev);
> +	if (!soc) {
> +		/*
> +		 * This can only happen if pdev was matched via pdev->name
> +		 * (which should not happen today) or in combination with a
> +		 * driver override.
> +		 */
> +		return dev_err_probe(dev, -ENODEV, "Unsupported device\n");
> +	}

We don't usually do this. Matching via anything other than OF device ID
tables (or ACPI, I suppose) is a programming error and you deserve the
crash which forces you to fix things rather than continue with an error
that is easy to miss.

Driver overrides aren't going to work with these devices anyway, so I'm
beginning to think it might be worth looking into opting out of the
override behaviour for select drivers.

Thierry

--bjkyzysa7eclgr2f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmqw/SUACgkQ3SOs138+
s6Havw/7B5w1CD5lp5uwLJdPafHuXtDGoHKTN3ztzrJdCydAYqXbzQYY6XqYm83y
S+kw2+ln/qDGJ/bfDFHDUv2hSGhTVC+W7VOt1SvXUbDqjanEdym4AC3/H/qqRgPL
D3ZKf+uoO02t9Yy2KAelpkHuM+n6aNG/6j5fVBTofYQjrSo1xyoWLonptcnHxl6S
AoxjV3+7KWiL879P8GKJiPxXO/HyeJLA3tcv3DG/MG2Igdm1SVYgpJrCfPA9Fq3d
2/2jB5xQW5DL8YdTkh2nP8brJKaFB5hXuiK/M7za9zBUCJjEr2kc5vS67BY7o8u/
SDcC3J1RSpEf2TLrFlv9xWcl+/ssAqP1YhQQduvubpCvFoQ3h7rrZP2/mGQPsrsw
7SoB/5dfeaOuk2z1jW84Hb79SR6d3TKxLGcINhf08d8WFG7IGaZe/X824WTpkm9e
x8Qau4fq2q9QYcHXvGRdEJ7oD/ZozwTB74clTUl4zrPPU77D0xCLAcp/egYhheeU
dGAlalh1+5HStb2gzURTL8iSESD0FJckkhjE9EUSurZfj+4D3D3Vz5NSjkaXq14k
+rJwAfvB6wrmcmTOzCwXyl3DzL3o4FFgLMwxhs/x0hbR6yK/TPWF0rcQgte8+N0y
Wb6ee9hNkmFA6pUpGXxKJOXhaEOyJOXyQc46aIsrLY1KXausKls=
=ip4m
-----END PGP SIGNATURE-----

--bjkyzysa7eclgr2f--
