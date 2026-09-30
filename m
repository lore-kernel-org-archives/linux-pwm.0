Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEBEE45D91B;
	Wed, 30 Sep 2026 10:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790764186; cv=none; b=EJs8lLm5Mgb59yDzeKhTaVzdjf5l7VCZNj8bt39Htb7judQiO7E9FaR0N651eVrKwQKp3iELt3B0o7wELhJ5J1Hi7XqxBf/uBbecxdTiThfBS/iRwVX2/UAcc14+I7KtUlhWB3m+ncu2SbCPwxv5w2VCl+O+B0PqvjGzRB25RHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790764186; c=relaxed/simple;
	bh=XypHvjK5uPib3gTzLMK3ROmEL2JUJgny3XWTGHw5q7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m5v/DTg2gKtx6QecgoctSW+FIv0CUpgSpljwsCywegU3BVEivtXe9WiTs5/QF48w5/EbOreO8n+SAc6d58a/Qdoros98dIBdpgI03+hdoSXI4S5M7inhIuF/U59nR56vs/S81Hol3xHIAVcP+Oiigm7FbLmvpBMa3OMNLyMQsW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FAAUlSno; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FAAUlSno"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC0451F000FF;
	Wed, 30 Sep 2026 10:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790764184;
	bh=XypHvjK5uPib3gTzLMK3ROmEL2JUJgny3XWTGHw5q7U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FAAUlSnoYYurnCYex91tc1QBD3i/oUzFFyh2x73vvFgF4jP7xNvXO938l7CgsuQlg
	 lGm5ZLeV21M9u/s6zEzBlvvXNONH9/QAxi4S0nvMJWNwFoLABFtUWwqKn0KxDkRAuT
	 Y+1rr6fSdAZx4PfwALwUlkOoG4OoWFYzgQrY7+wjKFE54EqLYVFrIRWyZFqBTew79q
	 ieZ4eSnDosiIY3ODS1QWftgZYFKIaZLphV9B7mUL8AK8vm5NV95clVDR45euA96ltT
	 1paIxCfqSrTzEu7+9iT0HyWzuDHzZ0b2GgwqVucgVteKh8sbdkei/2kNe7xEbsvSgP
	 iNRO7X1uLWFkw==
Date: Wed, 30 Sep 2026 12:29:42 +0200
From: Thierry Reding <thierry.reding@kernel.org>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>, 
	Mikko Perttunen <mperttunen@nvidia.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"Ola Chr. Vaage" <ola.christoffer.vage@scoutdi.com>
Subject: Re: [PATCH v2 3/3] pwm: tegra: Implement .get_state()
Message-ID: <arzjXtZj0hIf5iZU@orome>
References: <cover.1789741839.git.u.kleine-koenig@baylibre.com>
 <b72b16cf704aa662a1b49805db284379d4fa4050.1789741839.git.u.kleine-koenig@baylibre.com>
 <arEAjOHU4rH5aGqb@orome>
 <arE932ZcHGB8RAN6@monoceros>
 <arJTSEfkILPQmqNV@orome>
 <arzcE4nVRTAK9C-X@monoceros>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="x65eqfhbbjg6hmbn"
Content-Disposition: inline
In-Reply-To: <arzcE4nVRTAK9C-X@monoceros>


--x65eqfhbbjg6hmbn
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 3/3] pwm: tegra: Implement .get_state()
MIME-Version: 1.0

On Wed, Sep 30, 2026 at 11:54:03AM +0200, Uwe Kleine-K=C3=B6nig wrote:
> Hello Thierry,
>=20
> On Tue, Sep 22, 2026 at 12:07:26PM +0200, Thierry Reding wrote:
> > On Mon, Sep 21, 2026 at 04:26:03PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> > > On Mon, Sep 21, 2026 at 12:18:16PM +0200, Thierry Reding wrote:
> > > > It feels like this has too many assumptions built-in. That's mostly=
 a
> > > > predefined issue, but I think if we want to get accurate hardware r=
ead-
> > > > out, we need to address this.
> > > >=20
> > > > According to the register documentation, the PWM depth is 16 bits w=
ide
> > > > (on generations where it can be programmed). The value defaults to =
255
> > > > (which is n - 1 encoded, hence TEGRA_PWM_DEPTH), but it can technic=
ally
> > > > be reprogrammed to any 16-bit value, as far as I can tell.
> > > >=20
> > > > So I think for this to be correct we'd need to read out the actual =
value
> > > > before overwriting with TEGRA_PWM_CSR_0 contents above. At that poi=
nt I
> > > > think we'd need to either adjust the mask to be (2 * depth) - 1, or
> > > > maybe better yet, avoid masking it out arbitrarily based on the dep=
th
> > > > and instead cap it at depth so we never exceed the 1:1 ratio for du=
ty
> > > > cycle vs. period.
> > >=20
> > > As long as .apply() also hardcodes TEGRA_PWM_DEPTH, it's IMO fine that
> > > .get_state() does so, too.
> >=20
> > Okay, fair enough.
>=20
> Is that an Ack then?

I've been thinking about this some more and I don't know if it really
makes sense to keep hard-coding TEGRA_PWM_DEPTH. If only .apply() uses
it, then it's mostly fine, I suppose, because we don't care what the
current (or initial) state is/was. So we either don't use the device or
we overwrite it with a custom set of values.

Once we add .get_state() into the mix, now we kind of have to care about
the initial state, because we might end up using those values. If we did
not care, what would be the point, right? Which means that if we read
out wrong values, we, well, get wrong values. Which then may mean that
we overwrite values that we shouldn't, etc.

I suppose this would be okay if we reject any depth values other than
the default as errors. But then we also significantly reduce the
usefulness of this patch.

Thierry

--x65eqfhbbjg6hmbn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmq85JYACgkQ3SOs138+
s6GMSg/8CShCqOv5o6ZDmB+VHSaIQFFGttOeoXgmzAA2smnA4YfobLPobkLnCycp
Jt9Nl1ks+s7Y7XilTXZxPjeg6a7vlKlNB1MPZZVfS7Me83rdJaw84jj92pVtl6Ar
8nxcah0tE/jcbS+RS2A419cch5o9sS8RtaCqR84vyQwxiht/EqHLDjTXr1ysW1Yk
2zcPgErdivSMfe9dipW9ZkmLSeZTVDHT9YMnC6/51C9wPfcSBqToiFXKRxpgMlw2
SgRwmUWEp3m6CfumD5bQWJ2uPCkrIJu5PNy+MNcL9qQgtxslworz7FgeSpFCgCtr
2JYyllAYKzHgrktKfMS3BYyRonfWzxTZ26JxZKgxRZKx6nKpDpqB/n4fp9cHf01i
8m7M0gd6BKtSYcZ/jJcvhJTnyNS3hMbxjx4YVzwzZ+V4AJg6NJATFn6Z5R/Ov4bb
/HKdZdajsmI2Rlr0JpX/z0gSInNnl/1bjB5u56dMdx0YE2VZqM92dNPqdIo1j4CW
1Ar/kXTdJmeEnhI7teoaB1VAucD8H0masAOfLNmrxAnMMvLUU0HxA9+sQmrYeQq5
SkImXEY2a3AjnVADJv9TVLtb84F6idEb7MumGTyasgwApf81ASPj85CAGxSL/oEl
JFg1o7zJFEkvTfLtfB41fME8Wajus2WokswqmEh/2jkHNCO5ybo=
=AW50
-----END PGP SIGNATURE-----

--x65eqfhbbjg6hmbn--
