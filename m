Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B48438D3F9;
	Tue, 11 Aug 2026 22:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786489144; cv=none; b=aMln2GZOZP78G8PyL1ov4wUx11/2ZDQcsGzBVhPC2U0Z8QTTqX/BQUGqqGzg96sb/S00h7xZA8CwDnO8kPN9wnZ88uE+RRtXVosOQlbl9umBth4E+ZzOqYzqtLgulKbdsEfA2QhVcHM0N5BKLnWSM8xDqJJURTlPHQZ2bglA/zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786489144; c=relaxed/simple;
	bh=v1mlBgsg2PtvLEwBU1pVKahWO09p8g+Okqo9NCg+wIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=STSpQyiLihAMa92eozwkjS4SSQgVM16tAuVG5XYNrcP+4EN8cH4QgsQK/k4b6ru35b+hqf/oC2Cxp8oqMmhFqaaGTRnes7WOXSUXV+cciCQabkVKTzOdNh7hiaZWTruibEjDZ++Pdp1j9x1KK2ApPjIeh1Jl4fQCBMy4Q/7mnGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c8Yp9CyM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c8Yp9CyM"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 8E2C31F000E9;
	Tue, 11 Aug 2026 22:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786489143;
	bh=L878Y2FCSeUYAm6DEI1wNveVQulYO+oPHyG5saSsW1M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=c8Yp9CyMcpjvUDzvTfrjm6J8JY8BmtmNQs5Zjzq65jwwi7lUVyPGK19Vus/9gwOh1
	 gp5PRBB28v3SGCjtXiYRAYA+Dfm7Wq8RBYwrm6clSJe7mzKOqPXjVskdURAgGEfGjf
	 jC8RwG37EeMVaXsdD3g4LgRTPSnthhmHZS3DtbECVwK59vQ/f9854+OFzK9jNuZpSm
	 lZvmOd9YsYPIVupwqOh3NEw/h9iCXd3J6N/jek4qnLa0efJCaLEe8AvEZMtMV+A0pV
	 AI1JO8Q9KWFFnYXaIARLiQEyHWFyrKKNU6ZJXnxEPRyoK5y0PysfJdGjj25y6ugh+Z
	 k8wY3WqmkkVhA==
Date: Wed, 12 Aug 2026 00:58:59 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Eduard Bostina <egbostina@gmail.com>, 
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, 
	daniel.baluta@nxp.com, simona.toaca@nxp.com, goledhruva@gmail.com, m-chawdhry@ti.com
Subject: Re: [PATCH] dt-bindings: pwm: Convert TI PWM Subsystem to DT schema
Message-ID: <anuo_LNHuSvZZMgh@monoceros>
References: <20260811092208.687731-1-egbostina@gmail.com>
 <20260811174808.GA2709327-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ntxy2e5gk4fecbs4"
Content-Disposition: inline
In-Reply-To: <20260811174808.GA2709327-robh@kernel.org>


--ntxy2e5gk4fecbs4
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] dt-bindings: pwm: Convert TI PWM Subsystem to DT schema
MIME-Version: 1.0

On Tue, Aug 11, 2026 at 12:48:08PM -0500, Rob Herring wrote:
> On Tue, Aug 11, 2026 at 09:22:08AM +0000, Eduard Bostina wrote:
> > +examples:
> > +  - |
> > +    pwm@48300000 { /* PWMSS for am33xx */
> > +        compatible =3D "ti,am33xx-pwmss";
> > +        reg =3D <0x48300000 0x10>;
> > +        #address-cells =3D <1>;
> > +        #size-cells =3D <1>;
> > +        ranges =3D <0x48300100 0x48300100 0x80>,   /* ECAP */
> > +                 <0x48300180 0x48300180 0x80>,   /* EQEP */
> > +                 <0x48300200 0x48300200 0x80>;   /* EHRPWM */
> > +    };
> > +
> > +  - |
> > +    pwm@48300000 { /* PWMSS for am4372 */
> > +        compatible =3D "ti,am4372-pwmss", "ti,am33xx-pwmss";
> > +        reg =3D <0x48300000 0x10>;
> > +        #address-cells =3D <1>;
> > +        #size-cells =3D <1>;
> > +        ranges =3D <0x48300100 0x48300100 0x80>,   /* ECAP */
> > +                 <0x48300180 0x48300180 0x80>,   /* EQEP */
> > +                 <0x48300200 0x48300200 0x80>;   /* EHRPWM */
> > +    };
> > +
> > +  - |
> > +    pwm@4843e000 { /* PWMSS for DRA7xx */
> > +        compatible =3D "ti,dra746-pwmss", "ti,am33xx-pwmss";
> > +        reg =3D <0x4843e000 0x30>;
> > +        #address-cells =3D <1>;
> > +        #size-cells =3D <1>;
> > +        ranges;
> > +    };
>=20
> One example is enough.

Also it would be nice if that one example included the actual PWM.

--ntxy2e5gk4fecbs4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmp7qTAACgkQj4D7WH0S
/k7m5gf/QafZDYcoko+9zy4vn8+PmkeLxWLq0owNEZzeC0OxwMsdNbBAFKoekf93
dj050pADhwivBueq/9x/GUk/nkIaK5k1Ern2+W38D9PFj2tYbVTDC7OWd/QxvGJR
GnHw+VrSfDsEPoCx91VRAaPV+3y7tleKK7P7facybDouIfLGdYNT4TZLdmZNVber
Ba+HJp49wRfznKCiCslpH1bzumVhqTwFeD+LQWk1WL7PWEl6Nl76ujQTXVzlrFvK
EcOH8XQJoJoSU1fGRhKdZjD5P0xV6HNuzcjLIaEusKm0lOWyPkCcx2ghb5Pr0VsC
ShqTc9+H19EoymRq85XgKohCy4+V4A==
=AOGV
-----END PGP SIGNATURE-----

--ntxy2e5gk4fecbs4--
