Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0EA1231842;
	Sat, 26 Sep 2026 18:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790445974; cv=none; b=kGk9Ohr3/l6F77pSNTS6i+4nHDo1gF2rYE9vOCptEpkkguK87YFNI4dqKxMcjObchAztjXa1qHjQju+wT3JameR+dipD5lMIKRJskiZ0IONWoCVJMyx0AJCYtCyCTXAU1KMFj6lhi5lzePfOWtQtbe1CPUjqcWjxYfW6LHjrePE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790445974; c=relaxed/simple;
	bh=H6MlZfmuqvEHiRpcKmmdEW8Vh9rNn2PQMtpFcbOse+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nzxEAWMsu9z1v+Fp84EJhG64d1HZjG5HcMWnikCy3d1cZlBtE4wGd7L6i3W7RaOO00ewoOdNebbkj8e0w1NOPuPvGfe5UEc5V5UC0U6tH8r+JHMc2GSF8fA8CTVEY70Rqr4637ea3y0s3JrWZJNTlOD3CRYVartOjlS/symYQb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C3PKcs1G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C3PKcs1G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACD071F000FF;
	Sat, 26 Sep 2026 18:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790445972;
	bh=wYYaiwkOPUjr+j4UaQRgxxzscg0L0EnuNJCXdqEfXQA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=C3PKcs1G4z0FBX4/p60m8PgMsiYXohlNrKywBMGRldUPqllqJx0F14cckjHQvfkG8
	 QCW+MZ5gc3DA1+BJteWB9rZx/KBR1o/BTKZkhAbaJwZ5LAf6aHKvt/XCSEF3WtqQQ6
	 on5j+9CYViLcFfz0F+OTSvy8Lc1eXPnmkQyP64+tpawKHo0+KdG6dntzT8pU/XWgcp
	 Fy25Fuz46gPGN+/NavM4wGEmi3M3Cqzf9AEEqk/S/1xp2OS5aW1m2YqZnyTUdYJshq
	 xipS//mCqGJk+0DVEmnG/7MK9EqtWjtMf4rAZEJn8GVQX4R7xb6amKddJagXh/ISBY
	 F7si8ncPH5aHQ==
Date: Sat, 26 Sep 2026 19:06:07 +0100
From: Conor Dooley <conor@kernel.org>
To: linux-kernel-dev@aliel.fr
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org
Subject: Re: [PATCH v2 1/3] dt-bindings: pwm: amlogic: Add core clock for T7
Message-ID: <20260926-landless-prowess-df404db4d910@spud>
References: <20260925-add-t7-sys-pwm-clk-v2-0-f23a22b71a5c@aliel.fr>
 <20260925-add-t7-sys-pwm-clk-v2-1-f23a22b71a5c@aliel.fr>
 <20260925-facial-follow-032de22361c1@spud>
 <8e23838a-da5e-499c-a8be-3e2a7a0939e7@aliel.fr>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="LVLyBwFl5JS2r2Gm"
Content-Disposition: inline
In-Reply-To: <8e23838a-da5e-499c-a8be-3e2a7a0939e7@aliel.fr>

--LVLyBwFl5JS2r2Gm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 26, 2026 at 11:43:20AM +0200, linux-kernel-dev@aliel.fr wrote:
> On 9/25/26 6:41 PM, Conor Dooley wrote:
> > On Fri, Sep 25, 2026 at 05:13:28PM +0200, Ronald Claveau via B4 Relay w=
rote:
> >> From: Ronald Claveau <linux-kernel-dev@aliel.fr>
> >>
> >> The T7, A1, C3, and S4 PWM controllers have a system clock in
> >> addition to the two input clocks of channels A and B.
> >>
> >> The channel clocks are acquired by index in the pwm driver,
> >> where the core clock is fetched by name, with optional get
> >> which is silent when not provided.
> >>
> >> Require clock-names and minimum 3 items for T7, where the
> >> PWM devices do not work without all 3 clocks.
> >>
> >> Add an example showing T7 usage with its fallback to
> >> amlogic,meson-s4-pwm.
> >>
> >> Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
> >> ---
> >>  .../devicetree/bindings/pwm/pwm-amlogic.yaml       | 33 +++++++++++++=
+++++++--
> >>  1 file changed, 31 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml b/=
Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
> >> index c337d85da40f1..59320f288552b 100644
> >> --- a/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
> >> +++ b/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
> >> @@ -62,7 +62,7 @@ properties:
> >> =20
> >>    clock-names:
> >>      minItems: 1
> >> -    maxItems: 2
> >> +    maxItems: 3
> >> =20
> >>    power-domains:
> >>      maxItems: 1
> >> @@ -140,13 +140,34 @@ allOf:
> >>      then:
> >>        properties:
> >>          clocks:
> >> +          minItems: 2
> >>            items:
> >>              - description: input clock of PWM channel A
> >>              - description: input clock of PWM channel B
> >> -        clock-names: false
> >> +            - description: gate clock for the PWM controller
> >> +        clock-names:
> >> +          minItems: 2
> >> +          items:
> >> +            - const: channel-a
> >> +            - const: channel-b
> >> +            - const: core
> >>        required:
> >>          - clocks
> >> =20
> >> +  - if:
> >> +      properties:
> >> +        compatible:
> >> +          contains:
> >> +            const: amlogic,t7-pwm
> >=20
> > Shouldn't this (based on your reply on the previous version) be s4?
> >=20
>=20
> The change above is for S4 and SOCs which fallback to S4. It allows the
> third clock but let the schema validation compatible with two clocks
> existing DTS. Here for the T7, I add requirement for the exact 3 clocks.
>=20
> Do you recommend to require the 3 clocks for all S4 and S4 fallback, and
> update the associated dtsi files ?

Yes, I think so. Sounds to me like they only work because of the
CLK_IGNORE_UNUSED set in their clock controller drivers, so the correct
thing to do is make them all require the third clock.

Chers,
Conor.
>=20
> >> +    then:
> >> +      properties:
> >> +        clocks:
> >> +          minItems: 3
> >> +        clock-names:
> >> +          minItems: 3
> >> +      required:
> >> +        - clock-names
> >> +
> >>    - if:
> >>        properties:
> >>          compatible:
> >> @@ -182,3 +203,11 @@ examples:
> >>        clocks =3D <&pwm_src_a>, <&pwm_src_b>;
> >>        #pwm-cells =3D <3>;
> >>      };
> >> +  - |
> >> +    pwm@60000 {
> >> +      compatible =3D "amlogic,t7-pwm", "amlogic,meson-s4-pwm";
> >> +      reg =3D <0x60000 0x24>;
> >> +      clocks =3D <&channel_a>, <&channel_b>, <&core>;
> >> +      clock-names =3D "channel-a", "channel-b", "core";
> >> +      #pwm-cells =3D <3>;
> >> +    };
> >>
> >> --=20
> >> 2.49.0
> >>
> >>
>=20
>=20
> --=20
> Best regards,
> Ronald

--LVLyBwFl5JS2r2Gm
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCargJjwAKCRB4tDGHoIJi
0hGlAPwPcQT485NFPVpsmaLttMgeXLihgXcxvovjhjL6RFevHAEAhbpFtA4RAfsa
N/8aLtpv423553Psdr1Wrc70RFZcTwA=
=Qo82
-----END PGP SIGNATURE-----

--LVLyBwFl5JS2r2Gm--
