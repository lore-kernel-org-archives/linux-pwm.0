Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E633AFAF4;
	Mon, 15 Jun 2026 06:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781505295; cv=none; b=iEmJddhsRiXefRGgGgFHvIVtL1vVGzFFLEyjKcDWQRZDc2fus38bvi9WTezv7yW0Gp4nBdPxW3+14pduEe/PW4lV4y+kRyt0p8rNbU3K4X1F4d9mUjVguhFSMQMX1FXN+RV8PhPM36TGPENlSX91CJxaJiwD9EveizGrVdUW+rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781505295; c=relaxed/simple;
	bh=LwVwZ1OH794aFnSS7FIyTAlzmDuCdGBWxBc78g/rlcw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CybEPb2eZiMkJAOMEUhmePhGa8H9dywysKJAD4/AywbkLeVjanT4FojC8wVKelq4vbIA/PfDhzr9oHhaOKz4e6Oqzo62SAtVxppv9mbF5Cn2L2ej4V465JtN1ic46SND1adlR/BSajiWEZl1S3PmBSqtVNTgg/xb5rNHJwXnHNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M15whiB7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M15whiB7"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id A230B1F000E9;
	Mon, 15 Jun 2026 06:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781505294;
	bh=LwVwZ1OH794aFnSS7FIyTAlzmDuCdGBWxBc78g/rlcw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=M15whiB7awNSzpgBgSLlWyrVBDSrbGMngmgj4QA5DHrS9J3frZf509O0fV2RQbd94
	 yhpGEseCZZDlGfCAaUUrtT1CNxBkhSAzt919SG0KUMewHAfTf81TYOsS0Co1zO3JAf
	 +HSErqQLjMyM/q+XqhcLjDCJj/KUWo4mLP4Kir/5plPOMbfOy6VfwPHTyQHil4MbyB
	 km3LiF8oxFKGJXhKisvRoZcinCilhh2pvZb9EtZd5gkXmQbYlCe5SaIeEPW8+J248C
	 S1QVq2vi39+IiTCtQZe4E106CR7PxvTVZkQDCT2gugxR2+wtEi//eQ81X84Rr9wMyO
	 vt+0OsI2+CTjA==
Date: Mon, 15 Jun 2026 08:34:51 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Charan Pedumuru <charan.pedumuru@gmail.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Pal Singh <ajitpal.singh@st.com>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: pwm: st,pwm: convert to DT schema
Message-ID: <ai-cWP8XW0ZwBnbH@monoceros>
References: <20260613-st-pwm-v1-1-458c2c89709a@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="emncwsoh2jwmrgbx"
Content-Disposition: inline
In-Reply-To: <20260613-st-pwm-v1-1-458c2c89709a@gmail.com>


--emncwsoh2jwmrgbx
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] dt-bindings: pwm: st,pwm: convert to DT schema
MIME-Version: 1.0

Hello,

On Sat, Jun 13, 2026 at 07:04:11AM +0000, Charan Pedumuru wrote:
> Convert STMicroelectronics STiH41x PWM/Capture controller binding
> to DT schema.
>=20
> Signed-off-by: Charan Pedumuru <charan.pedumuru@gmail.com>

FTR: sashiko found a relevant issue in this patch, sent a mail about it,
but not to the list. It's about the old binding requiring `interrupts`
which isn't the case in the new proposed one.

Find the full message at
https://sashiko.dev/#/message/20260613071327.BE3101F000E9%40smtp.kernel.org.

So I marked this patch as changes requested.

Best reagrds
Uwe

--emncwsoh2jwmrgbx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmovnQgACgkQj4D7WH0S
/k40YwgAuXZImzLUX+KOPP158jbavgVEmzuiuBb//DdDlrIGgzzO6v+dBAMA9SDj
PvuC7RBW/B5UooAcMZ1ug0XNSKEBPdmt5Y0gQ87AHDpCorEj0TT7sxnwkNsPFX7x
HWl9G8cL27P6GutcVbCOluI0yYR7Nw1zHYQf21RyAACqbQ8Vhyhh72ob5smi9YfV
33kT4xEB6wS6RhPxBqf4Nq+uAItquyUKzPnYPnJyA/tYFsPGidRAMDVQ67CCC59y
b1wHuvuWgjOm7Vf43RWcIcBZflb/1IGtXsHWm2NX0LiS7MCBDIiuchqFT32NykG0
RZvK1jwXaN14bK03WyRqvyufOjWRXA==
=XSA6
-----END PGP SIGNATURE-----

--emncwsoh2jwmrgbx--
