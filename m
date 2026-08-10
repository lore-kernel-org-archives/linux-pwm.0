Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2142D781B;
	Mon, 10 Aug 2026 08:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786350773; cv=none; b=iARvZErw4e0HSn0Uk3P0eVfdWGiCK19Lr8zqDoS1YRzkoL9d7KEIkLqc8Zacn8o946LbIsT1mp8mYt4AYdSN6FgsJ/VdlAVLr37iofvXIjoC2JMWG1AZWlfiUqjzUjy2f9X2Hs6Z4525ad6pPZ/KFBf+6rQoAySaeylyFzWkfL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786350773; c=relaxed/simple;
	bh=1F7tiMkdVfQbmqkaM3bTFDCkeRFJXaEzsjGBW2IYP94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VaFppwjZea05sPpMlug2k/Yq0GcEP49c/bxKMGBAdwEvaFrubP0+9GbIAhCFWTG1fLnw/3DsUipLNWmvx44Z4VoeVq4am48hOcT6hZ7VbC5+/xt0W2up46JxEymBM1DdkBavlmfswgFcLxqx73xwC+Sy3Mt9QKrvc1FvJZCtk5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FqHB2Rb8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FqHB2Rb8"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id DED341F00A3A;
	Mon, 10 Aug 2026 08:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786350772;
	bh=BZwCetn5tKJgMx12L3rbZnaRYrOL9u/YdfDRRTM7R4E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FqHB2Rb8uLVJQqw+uPDYtm5nPvPpwx6yaRv0i8ZReY2EaWjHwYGAaYVcULrQ2ImbU
	 QVNJHaX+e3fasSuK5C6EcrUUc4PLJ8SiFj7cWZbic8h1GbXjRlhptlfrSdRVCzwCvY
	 pc6ikAnXhXypY6j4VHh0bxMNlcllxiiWrVJlp5ZV0ynxalft3ZhnvlRvLAG8To9P0t
	 JZoP3JXRjLHw+yl0pX5bNHq+39iDzt2L46K3Wcv6DMVntFbzU0zlohCUB/tV+jyt18
	 +lKAw+LPyNc7ft5vpX70kUysblZbd/deXReQIyY5Dkyg6WvgmUfw7SSSYop4FpEfsb
	 kk23E7YdIRyGw==
Date: Mon, 10 Aug 2026 10:32:50 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Charan Pedumuru <charan.pedumuru@gmail.com>, 
	Lee Jones <lee@kernel.org>, Lee Jones <lee.jones@linaro.org>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] dt-bindings: pwm: st,sti-pwm: convert to DT schema
Message-ID: <anmK4os44Uz27oR9@monoceros>
References: <20260629-st-pwm-v5-1-a93f2bfec38c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vfr6esdl6of4c5jx"
Content-Disposition: inline
In-Reply-To: <20260629-st-pwm-v5-1-a93f2bfec38c@gmail.com>


--vfr6esdl6of4c5jx
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v5] dt-bindings: pwm: st,sti-pwm: convert to DT schema
MIME-Version: 1.0

On Mon, Jun 29, 2026 at 12:58:37PM +0000, Charan Pedumuru wrote:
> Convert STMicroelectronics STiH41x PWM/Capture controller binding
> to DT schema.
> Changes during conversion:
> - Fix compatible string from "st,pwm" to "st,sti-pwm" to match the
>   actual hardware variant naming convention used across STi bindings.
> - Drop pinctrl-names from the required list as pinctrl properties are
>   inherited and validated by the pinctrl schema.
>=20
> Signed-off-by: Charan Pedumuru <charan.pedumuru@gmail.com>
> ---
> Changes in v5:
> - Enforce stricter validation of the clock-names property.
> - Link to v4: https://patch.msgid.link/20260625-st-pwm-v4-1-958d7d6bdf39@=
gmail.com
>=20
> Changes in v4:
> - Fix compatible to "st,sti-pwm" in examples.
> - Modify subject line to point to the correct YAML file.
> - Link to v3: https://patch.msgid.link/20260625-st-pwm-v3-1-ace9bff88529@=
gmail.com
>=20
> Changes in v3:
> - Fix compatible to "st,sti-pwm".
> - Drop pinctrl-names from required.
> - Modify the commit message to explain the changes made.
> - Change maintainer to "Lee Jones <lee.jones@linaro.org>".

I wonder if Lee has a comment about that. In v2 the maintainer was

	Ajit Pal Singh <ajitpal.singh@st.com>

and I don't see Lee agree to be named maintainer. The only rationale I
can find was

	Also the maintainer email doesn't exist now. I will change that
	too with other maintainer.

in
https://lore.kernel.org/all/9379bfdb-9a9c-4fea-924c-6c1dc8e997c1@gmail.com/
=2E At some point in the past lee.jones@linaro.org didn't exist either. I
added that address to the list of recipents to test.

Otherwise looks fine.

Best regards
Uwe

--vfr6esdl6of4c5jx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmp5jK8ACgkQj4D7WH0S
/k6zYwf5AZ81+Bsp+Ss/JEoHaYp3cjcqN3KW1QGi1q2KyJX/IwHo5ESXAtTboSuV
YjYq+9h2GhZfF270MObXuMKryUsacXkFTLFFxHCIsLFoXgoNzDEtmzNBT5F65ODP
emtVPeBmz6kpIYILpQ8upFWOkGXh2egiP0T3ayxCHDgxKLAIVJO7k8Sw0Yunig+w
Tq3c/65PT6Z59ZuvbXa3DKPjPMkthK+idqxTaCKucH0BxsCM5T6RzWjqdAdZlW1T
PvBdya9BMot/Mp595S286wGjEual1nvhz0FB5WtYgP6jhG93sbJGFValfHXv85Xq
ZORrqQawpvN2Tp1vu3JPoDQMq8yygQ==
=Q4bJ
-----END PGP SIGNATURE-----

--vfr6esdl6of4c5jx--
